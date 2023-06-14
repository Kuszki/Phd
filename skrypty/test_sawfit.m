clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

saw = @(x) (2/pi)*asin(sin(x));

ADC = @(x) 4095.594 * x/1000 + 4.176439;
VIN = @(x) 1000*(x - 4.176439) / 4095.594;

dat = load("../pomiary/saw/freqs.dat");

#amp = 950/2;
#shf = 500;

amp = 479.97;
shf = 505.85;

det = (5e-06 + 1e-6*((15 + 15)/24));

ts = (1.0 / 48000.0);

printf("f\tw\tu\tc\tw\n")

for i = 1 : length(dat)

#	if i != 2; continue; end;

	f = dat(i,1);
	o = dat(i,2);

	fun = @(x) amp*saw(o*x - det) + shf;

	pts = load(sprintf("../pomiary/saw/%d.txt", f));
	pts = VIN(pts);

	t = 0 : (length(pts)-1);
	org = fun(ts*transpose(t));

	diff = pts - org;

	[u, c, s, w, m] = get_uncertainty(diff);
	[y, av, fv] = gen_sawfun([1], o, amp, shf, 25);

	printf("%d\t%f\t%f\t%f\t%f\t%f\n", f, o, u, c, w, get_filter_var(fv, av));

	mns(i) = m;

#	hold on;
#	plot(org)
#	plot(pts)
#	plot(diff)
#	pause()
#	hold off;

#	return

end

