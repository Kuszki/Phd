clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

dat = load("../pomiary/freq.dat");

amp = 479.98; # agilent
shf = 505.80;

#amp = 478.604282509783;
#shf = 505.802230319947;

#shf = 506.105303655713;

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

for i = 1 : length(dat)

	if exist(sprintf("../pomiary/%s/%d.txt", src_path, dat(i,1)), "file") != 2; continue;
	elseif dat(i,1) < 100; continue;
	end;

	f = dat(i,1);
	o = dat(i,2);

#	amp = dat(i,3);
#	shf = dat(i,4);

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

	printf("%d\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%0.2f\t&\t%+0.2f\t&\t\\\\ \\hline\n", f, wc_c, w, uc_c, u, cc_c, c, dc_c);

	a = 1; b = c = length(diff)/4-1;

	w_1 = var(diff(a:b)); a = a + c; b = b + c; w_1 = 100*(w_1-w)/w;
	w_2 = var(diff(a:b)); a = a + c; b = b + c; w_2 = 100*(w_2-w)/w;
	w_3 = var(diff(a:b)); a = a + c; b = b + c; w_3 = 100*(w_3-w)/w;
	w_4 = var(diff(a:b)); a = a + c; b = b + c; w_4 = 100*(w_4-w)/w;

#	printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", f, w_1, w_2, w_3, w_4, sum(abs([w_1 w_2 w_3 w_4])));

	freq(i) = f;
	vars(i) = w;
	du_ab(i) = dc_ab;
	du_c(i) = dc_c;

#	werr(i) = 100*(o-2*pi*f)/(2*pi*f);
#	phi(i) = asin((pts(1) - shf)/amp);
#	cph(i) = get_filter_phi(o);
#	sph(i) = det*o;

#	hold on;
#	plot(org)
#	plot(pts)
	plot(diff)
#	plotfftreal(fftreal(diff), 48000, 'linabs', 'flog')
#	pause()
#	clf()
#	hold off;

#	return

end

#printf("\\multicolumn{7}{|c|}{Średnia wartość bezwzględna błędu oszacowania}\t&\t%+0.2f\t%+0.2f\t\\\\ \\hline\n", mean(abs(du_ab)), mean(abs(du_c)));

#clf
#hold on
#plot(freq, vars)
#plot(freq, werr)
#plot(freq, phi)
#plot(freq, -cph)
#plot(freq, phi-sph)
#hold off

#plot(freq, du_c)

mn_d = mean(abs(du_c))
st_d = std(abs(du_c))
