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

#amp = 950/2;
#shf = 500;

amp = 479.992838173153;
shf = 505.777538611375;

det = 144 / 12e6 + 1e-6/5.5;

printf("f\tw\tu\tc\tw\n")

for i = 1 : length(dat)

	f = dat(i,1);
	o = dat(i,2);

	if exist(sprintf("../pomiary/saw/%d.txt", f), "file") != 2; continue;
#	elseif f != 9000; continue;
	end;

	fun = @(x) amp*saw(o*x) + shf;

	pts = load(sprintf("../pomiary/saw/%d.txt", f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);

	diff = pts - org;

	[u, c, s, w, m] = get_uncertainty(diff);
	[y, av, fv] = gen_sawfun([1], o, amp, shf, 30);

	wc = get_filter_var(fv, av);

	printf("%d\t%f\t%f\t%f\t%f\t%f\t%1.2f\n", f, u, c, s, w, wc, 100*(wc-w)/w);

	mns(i) = m;

#	hold on;
#	plot(org)
#	plot(pts)
#	plot(diff)
#	pause()
#	clf()
#	hold off;

#	return

end

