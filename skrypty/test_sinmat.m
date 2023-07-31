clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd");
A = lin_ident(@(x) fwt(x, "spline4:4", 5), 128);

doDraw = true;

dat = load("../pomiary/freq.dat");

amp = 479.98; # agilent
shf = 505.80;

amp0 = 950/2;
shf0 = 500;

u_s = (1.65/sqrt(3))*(5e-3*shf0+2);
e_d = (1.65/sqrt(3))*(1e-2*amp0+1);

det = 144 / 12e6; #+ 1e-6/6.66; #1e-6/5.5;

u_rw = 0.38; # 0.38 0.51 1.10
u_rc = 1.96 * sqrt(0.5*2.6e-7*amp^2);

cv = "ns";
i = 0;

for j = 1 : length(num)

	cr = R(j,:) = A(num(j),:);
	K_r(j) = get_rowcoef(cr, 0, 'r');
	K_d(j,:) = abs(freqz(cr, [], dat(:,1), 48000));

end

for j = 1 : length(dat)

	if exist(sprintf("../pomiary/sin/%d.txt", dat(j,1)), "file") != 2; continue;
	elseif dat(j,1) < 100; continue;
	end;

	i = i + 1;
	f = dat(j,1);
	o = dat(j,2);

	fun = @(x) amp*sin(o*x) + shf;

	pts = load(sprintf("../pomiary/sin/%d.txt", f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);

	difs = zeros(1, length(pts)-128);
	diff = pts - org;

	printf("%d\t", f);

	for l = 1 : length(num)

		crow = R(l,:);

		difs = filter(crow, 1, pts - org);
		difs = difs(length(crow):length(difs));

		[u, c, s, w, m] = get_uncertainty(difs);

		[a, p, u_d, w_d, vx, vy] = get_dynparams([amp amp], [pi get_filter_phi(o)]);
		uv = [K_r(l) * sqrt(u_rw^2 + u_rc^2), u_d * K_d(l, j)];
		[uc_c, cc_c, sc_c, wc_c, hm_c] = get_unccalc(uv, cv);
		dc_c(i, l) = 100*(uc_c-u)/u;

		printf("&\t%+0.2f\t", dc_c(i, l));

	end

	printf("\\\\ \\hline\n");

#	hist(difs, 100, 100)
#	pause

end

printf("\\multirow{2}{*}{Średnia}\t");

for j = 1 : columns(dc_c)

	printf("&\t%0.2f\t", mean(abs(dc_c(:,j))));

end

printf("\\\\ \\hline\n");

printf("&\\multicolumn{%d}{S[table-format = +2.2]}{%0.2f}\t\t\t\\\\ \\hline\n", columns(dc_c), mean(abs(dc_c(:))))

mn_d = mean(abs(dc_c(:)))
st_d = std(abs(dc_c(:)))

