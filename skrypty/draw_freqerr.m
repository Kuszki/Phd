clear
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3*2/3])
set(h, "paperposition", [0, 0, [16 11.3*2/3]])

set(0, "defaultaxesposition", [0.085, 0.125, 0.820, 0.835])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd")(4)
A = lin_ident(@(x) fwt(x, "spline4:4", 5), 128)(num,:);

dat = load("../pomiary/freq.dat");

amps = freqz(A, [], dat(:,1), 48000);
amps = abs(amps);

amp = 479.98; # agilent
shf = 505.80;

amp0 = 950/2;
shf0 = 500;

u_s = (1.65/sqrt(3))*(5e-3*shf0+2);
e_d = (1.65/sqrt(3))*(1e-2*amp0+1);

det = 144 / 12e6; #+ 1e-6/6.66; #1e-6/5.5;

u_rw = 0.38 * get_rowcoef(A, 0, 'r'); # 0.38 0.51 1.10
u_rab = 1.96 * sqrt(0.5*2.6e-7*amp0^2) * get_rowcoef(A, 0, 'r');
u_rc = 1.96 * sqrt(0.5*2.6e-7*amp^2) * get_rowcoef(A, 0, 'r');
u_s = u_s * get_rowcoef(A, 0, 's');
cv = "uns";
i = 0;

for j = 1 : length(dat)

	if exist(sprintf("../pomiary/sin/%d.txt", dat(j,1)), "file") != 2; continue;
	elseif dat(j,1) < 100; continue;
	end;

	i = i + 1;
	f = dat(j,1);
	o = dat(j,2);
	k = amps(j);

	fun = @(x) amp*sin(o*x) + shf;

	pts = load(sprintf("../pomiary/sin/%d.txt", f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);

	difs = zeros(1, length(pts)-128);
	diff = pts - org;

	difs = filter(A, 1, pts - org);
	difs = difs(length(A):length(difs));

	[u, c, s, w, m] = get_uncertainty(difs);

	[a, p, u_d, w_d, vx, vy] = get_dynparams([amp amp], [pi get_filter_phi(o)]);
	uv = [0.0, sqrt(u_rw^2 + u_rc^2), u_d*k];
	[uc_c, cc_c, sc_c, wc_c, hm_c] = get_unccalc(uv, cv);
	dc_c = 100*(uc_c-u)/u;

	freq(i) = f;
	vars(i) = w;
	du_c(i) = dc_c;

end

afrq = linspace(0, max(freq), 128);
amps = freqz(A, [], afrq, 48000);
amps = abs(amps);

[ax, h1, h2] = plotyy(afrq, amps, freq, du_c);
xlabel("Częstotliwość, Hz");
ylabel(ax(1), "Wartość wzmocnienia, V/V");
ylabel(ax(2), "Względny błąd oszacowania, %");
legend("Wzmocnienie", "Błąd", "location", 'southwest', 'orientation', 'horizontal')
grid on;
box on;

set(ax, "ycolor", "black");
set(h2, "marker", "x");
set(h2, "linestyle", "none");

print("../obrazki/mono_freqcomp.svg");
