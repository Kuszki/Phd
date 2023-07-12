clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

saw = @(x) (2/pi)*asin(sin(x));

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd")(3);
A = lin_ident(@(x) fwt(x, "spline4:4", 5), 128)(num,:);

dat = load("../pomiary/freq.dat");

amps = freqz(A, [], dat(:,1), 48000);
amps = abs(amps);

amp = 479.70333667505;
shf = 505.85509908961;

det = 144 / 12e6 + 1e-6/5.5;

u_rw = 0.38 / 1.96;
u_rp = 0*(1e-3)*(amp + shf)/sqrt(3);

u_r = 1.96 * sqrt(u_rp^2 + u_rw^2) * get_rowcoef(A, 0, 'r');

for i = 1 : length(dat)

	if exist(sprintf("../pomiary/saw/%d.txt", dat(i,1)), "file") != 2; continue;
#	elseif dat(i,1) != 8000; continue;
	end;

	f = dat(i,1);
	o = dat(i,2);

	fun = @(x) amp*saw(o*x) + shf;

	pts = load(sprintf("../pomiary/saw/%d.txt", f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);

	difs = zeros(1, length(pts)-128);
	diff = pts - org;

	difs = filter(A, 1, pts - org);
	difs = difs(length(A):length(difs));

	[u, c, s, w, m] = get_uncertainty(difs);

	[yv, av, fv] = gen_sawfun([1], o, amp, shf, 5);
	[wc, wv, av, pv] = get_filter_var(fv, av);

	cv = sprintf("n%s", repmat('s',1,length(wv)));
	fv = fv(1:length(wv));

	dv = (1.41*av/sqrt(2)) .* abs(freqz(A, [], fv/2/pi, 48000));
	uv = [ u_r dv ];

	[uc, cc, sc, wc, hm] = get_unccalc(uv, cv);

	printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%+0.2f\t%+0.2f\n", f, wc, w, uc, u, cc, c, 100*(wc-w)/w, 100*(uc-u)/u);

	freq(i) = f;
	vars(i) = w;

#	hist(difs, 100, 100)
#	pause

end

