clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3*2/3])
set(h, "paperposition", [0, 0, [16 11.3*2/3]])

set(0, "defaultaxesposition", [0.095, 0.185, 0.870, 0.790])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")


ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

dat = load("../pomiary/freq.dat");

amp = 479.98; # agilent
shf = 505.80;

amp0 = 950/2;
shf0 = 500;

u_s = (1.65/sqrt(3))*(5e-3*shf0+2);
e_d = (1.65/sqrt(3))*(1e-2*amp0+1);

det = 144 / 12e6;# + 1e-6/6.9 #/6.66; #1e-6/5.5;

u_rw = 0.38; # 0.38 0.51 1.10
u_rab = 1.96 * sqrt(0.5*2.6e-7*amp0^2);
u_rc = 1.96 * sqrt(0.5*2.6e-7*amp^2);

src_path = "sin";
cv = "uns";
i = 0;

for j = 1 : length(dat)

	if exist(sprintf("../pomiary/%s/%d.txt", src_path, dat(j,1)), "file") != 2; continue;
	elseif dat(j,1) < 100; continue;
	end;

	i = i + 1;
	f = dat(j,1);
	o = dat(j,2);

	fun = @(x) amp*sin(o*x) + shf;

	pts = load(sprintf("../pomiary/%s/%d.txt", src_path, f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);
	diff = pts - org;

	[u, c, s, w, m] = get_uncertainty(diff);

	[a, p, u_d, w_d, vx, vy] = get_dynparams([amp amp], [pi get_filter_phi(o)]);
	uv = [0.0, sqrt(u_rw^2 + u_rc^2), u_d];
	[uc_c, cc_c, sc_c, wc_c, hm_c] = get_unccalc(uv, cv);
	dc_c = 100*(uc_c-u)/u;

	[a, p, u_d, w_d, vx, vy] = get_dynparams([amp0 amp0 -e_d], [pi get_filter_phi(o) get_filter_phi(o)]);
	uv = [u_s, sqrt(u_rw^2 + u_rab^2), u_d];
	[uc_b, cc_b, sc_b, wc_b, hm_b] = get_unccalc(uv, cv);

	[a, p, u_d, w_d, vx, vy] = get_dynparams([amp0 amp0 e_d], [pi get_filter_phi(o) get_filter_phi(o)]);
	uv = [u_s, sqrt(u_rw^2 + u_rab^2), u_d];
	[uc_a, cc_a, sc_a, wc_a, hm_a] = get_unccalc(uv, cv);

	uc_ab = max(uc_a, uc_b);
	wc_ab = max(wc_a, wc_b);
	dc_ab = 100*(uc_ab-u)/u;

	freq(i) = f;
	vars(i) = w;
	du_ab(i) = dc_ab;
	du_c(i) = dc_c;

	vuc(i) = uc_c;
	vur(i) = u;

end

mn_d = mean(abs(du_c))
st_d = std(abs(du_c))

semilogx(freq, du_c, "x");
ylabel("Względny błąd oszacowania, %");
xlabel("Częstotliwość, Hz");
xlim([100 21000]);
ylim([-20 10]);
grid on;
box on;

print("../obrazki/sinfit_error.svg");
