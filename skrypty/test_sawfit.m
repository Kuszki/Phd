clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

saw = @(x) (2/pi)*asin(sin(x));

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

dat = load("../pomiary/freq.dat");

amp = 479.65; # agilent
shf = 505.80;

amp = 479.98; # agilent
shf = 505.80;

det = 144 / 12e6;

u_rw = 0.38;
u_rp = 0*1.65 * (1e-3)*(amp + shf)/sqrt(3);

for i = 1 : length(dat)

	if exist(sprintf("../pomiary/saw/%d.txt", dat(i,1)), "file") != 2; continue;
	elseif dat(i,1) < 100; continue;
	end;

	f = dat(i,1);
	o = dat(i,2);

	fun = @(x) amp*saw(o*x) + shf;

	pts = load(sprintf("../pomiary/saw/%d.txt", f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);

	diff = pts - org;

	[u, c, s, w, m] = get_uncertainty(diff);
	[yv, av, fv] = gen_sawfun(t + det, o, amp, shf, 5);
	[wc, wv, av, pv] = get_filter_var(fv, av);

	cv = sprintf("nu%s", repmat('s',1,length(wv)));
	uv = [ u_rw u_rp 1.41*av/sqrt(2) ];

	[uc, cc, sc, wc, hm] = get_unccalc(uv, cv);

	du_c(i) = 100*(uc-u)/u;
	dw_c(i) = 100*(wc-w)/w;

	printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%+0.2f\t%+0.2f\n", f, wc, w, uc, u, cc, c, dw_c(i), du_c(i));

	a = 1; b = c = length(diff)/4-1;

	w_1 = var(diff(a:b)); a = a + c; b = b + c; w_1 = 100*(w_1-w)/w;
	w_2 = var(diff(a:b)); a = a + c; b = b + c; w_2 = 100*(w_2-w)/w;
	w_3 = var(diff(a:b)); a = a + c; b = b + c; w_3 = 100*(w_3-w)/w;
	w_4 = var(diff(a:b)); a = a + c; b = b + c; w_4 = 100*(w_4-w)/w;

#	printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", f, w_1, w_2, w_3, w_4, sum([w_1 w_2 w_3 w_4]), sum(abs([w_1 w_2 w_3 w_4])));

#	freq(i) = f;
#	vars(i) = w;

#	hold on;
#	plot(org)
#	plot(pts)
#	plot(yv)
#	plot(diff)
#	plotfftreal(fftreal(diff), 48000, 'linabs', 'flog')
#	pause()
#	clf()
#	hold off;

#	return

end

mn_u = mean(abs(du_c))
mn_w = mean(abs(dw_c))
