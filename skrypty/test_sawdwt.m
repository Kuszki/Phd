clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

saw = @(x) (2/pi)*asin(sin(x));

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd")(4)
A = lin_ident(@(x) fwt(x, "spline4:4", 5), 128)(num,:);

dat = load("../pomiary/freq.dat");

amps = freqz(A, [], dat(:,1), 48000);
amps = abs(amps);

amp = 479.65; # agilent
shf = 505.85;

det = 144 / 12e6;

u_rw = 0.38 / 1.96;
u_rp = (1e-3)*(amp + shf)/sqrt(3);

u_r = 1.96 * sqrt(u_rp^2 + u_rw^2) * get_rowcoef(A, 0, 'r')

i = 0;

for j = 1 : length(dat)

	if exist(sprintf("../pomiary/saw/%d.txt", dat(j,1)), "file") != 2; continue;
	elseif dat(j,1) < 100; continue;
	end;

	i = i + 1;
	f = dat(j,1);
	o = dat(j,2);

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

	[yv, av, fv] = gen_sawfun([1], o, amp, shf, 15);
	[wc, wv, av, pv] = get_filter_var(fv, av);

	cv = sprintf("n%s", repmat('s',1,length(wv)));
	fv = fv(1:length(wv));

	dv = (1.41*av/sqrt(2)) .* abs(freqz(A, [], fv/2/pi, 48000));
	uv = [ u_r dv ];

	[uc, cc, sc, wc, hm] = get_unccalc(uv, cv);

	du_c(i) = 100*(uc-u)/u;
	dw_c(i) = 100*(wc-w)/w;

	printf("%d\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%+0.2f\t\\\\ \\hline\n", f, wc, w, uc, u, cc, c, du_c(i));

#	freq(i) = f;
#	vars(i) = w;

#	hist(difs, 100, 100)
#	pause

end

printf("\\multicolumn{6}{|c|}{Średnia wartości bezwzględnych wielkości $\\delta_{c}$}\t\t\t\t&\t%0.2f\t\\\\ \\hline\n", mean(abs(du_c)));

mn_u = mean(abs(du_c))
st_u = std(abs(du_c))

