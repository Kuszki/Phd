clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

ADC = @(x) 4095.594 * x/1000 + 4.176439;
VIN = @(x) 1000*(x - 4.176439) / 4095.594;

#dat = load("../pomiary/sin/freqs.dat");
dat = load("../pomiary/freq_st.dat");

#amp = 950/2;
#shf = 500;

amp = 479.97;
shf = 505.89;

det = 6.5e-06;
[b, a] = cheby1(5, 3, 0.05);

printf("f\tw\tu\tc\tw\n")

for i = 1 : length(dat)

	f = dat(i,1);
	o = dat(i,2);

#	if f != 1000; continue; end;

	fun = @(x) amp*sin(o*x/48000.0 + det) + shf;

	pts = load(sprintf("../pomiary/sin_28/%d.txt", f));
	pts = pts(1:length(pts));
	pts = VIN(pts);

	t = 0 : (length(pts)-1);
	org = fun(transpose(t));

	diff = pts - org;

	[u, c, s, w, m] = get_uncertainty(diff);

	printf("%d\t%f\t%f\t%f\t%f\t%f\n", f, o, u, c, w, get_filter_var(2*pi*f, amp));

	freq(i) = f;
	vars(i) = w;

#	hold on;
#	plot(org)
#	plot(pts)
#	plot(diff)
#	plot(filter(b, a, diff))
#	pause()
#	clf()
#	hold off;

#	return

end

