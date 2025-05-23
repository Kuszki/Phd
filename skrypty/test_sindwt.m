clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

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

	[a, p, u_d, w_d, vx, vy] = get_dynparams([amp0 amp0 -e_d], [pi get_filter_phi(o) get_filter_phi(o)]);
	uv = [u_s, sqrt(u_rw^2 + u_rab^2), u_d*k];
	[uc_b, cc_b, sc_b, wc_b, hm_b] = get_unccalc(uv, cv);

	[a, p, u_d, w_d, vx, vy] = get_dynparams([amp0 amp0 e_d], [pi get_filter_phi(o) get_filter_phi(o)]);
	uv = [u_s, sqrt(u_rw^2 + u_rab^2), u_d*k];
	[uc_a, cc_a, sc_a, wc_a, hm_a] = get_unccalc(uv, cv);

	uc_ab = max(uc_a, uc_b);
	wc_ab = max(wc_a, wc_b);
	dc_ab = 100*(uc_ab-u)/u;

	printf("%d\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%+0.2f\t&\t%+0.2f\t\\\\ \\hline\n", f, wc_ab, wc_c, w, uc_ab, uc_c, u, dc_ab, dc_c);

	freq(i) = f;
	vars(i) = w;
	du_ab(i) = dc_ab;
	du_c(i) = dc_c;

#	hist(difs, 100, 100)
#	pause

end

printf("\\multicolumn{7}{|c|}{Średnia wartości bezwzględnych wielkości $\\delta_{*}$}\t\t\t\t&\t%0.2f\t&\t%0.2f\t\\\\ \\hline\n", mean(abs(du_ab)), mean(abs(du_c)));

mn_d = mean(abs(du_c))
st_d = std(abs(du_c))

