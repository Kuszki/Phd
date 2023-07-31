clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

saw = @(x) (2/pi)*asin(sin(x));

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd");
A = lin_ident(@(x) fwt(x, "spline4:4", 5), 128);

dat = load("../pomiary/freq.dat");

amp = 479.65; # agilent
shf = 505.85;

det = 144 / 12e6;

u_r = sqrt(0.38^2 + 0*0.9388^2);

i = 0;

for j = 1 : length(num)

	cr = R(j,:) = A(num(j),:);
	K_r(j) = get_rowcoef(cr, 0, 'r');

end

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

	[yv, av, fv] = gen_sawfun([1], o, amp, shf, 15);
	[wc, wv, av, pv] = get_filter_var(fv, av);

	cv = sprintf("n%s", repmat('s',1,length(wv)));
	fv = fv(1:length(wv));
	dv = 1.41*av/sqrt(2);

	printf("%d\t", f);

	for l = 1 : length(num)

		crow = R(l,:);

		difs = filter(crow, 1, pts - org);
		difs = difs(length(crow):length(difs));

		[u, c, s, w, m] = get_uncertainty(difs);

		K_d = abs(freqz(crow, [], fv/2/pi, 48000));

		uv = [ u_r*K_r(l) dv .* K_d ];

		[uc, cc, sc, wc, hm] = get_unccalc(uv, cv);

		dc_c(i, l) = 100*(uc-u)/u;

		printf("&\t%+0.2f\t", dc_c(i, l));

	end

	printf("\\\\ \\hline\n");

end

printf("Średnia\t");

for j = 1 : columns(dc_c)

	printf("&\t%0.2f\t", mean(abs(dc_c(:,j))));

end

printf("\\\\ \\hline\n");

#printf("&\\multicolumn{%d}{S[table-format = +2.2]}{%0.2f}\t\t\t\\\\ \\hline\n", columns(dc_c), mean(abs(dc_c(:))))

mn_d = mean(abs(dc_c(:)))
st_d = std(abs(dc_c(:)))

