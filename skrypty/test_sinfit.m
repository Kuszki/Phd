clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

dat = load("../pomiary/freq.dat");

#amp = 950/2;
#shf = 500;

amp = 479.6147015593;
shf = 505.9448594743;

det = 144 / 12e6 + 1e-6/5.5;

printf("f\tw\tu\tc\tw\n")

for i = 1 : length(dat)

	f = dat(i,1);
	o = dat(i,2);

	if exist(sprintf("../pomiary/sin/%d.txt", f), "file") != 2; continue;
#	elseif f != 3000; continue;
	end;

	ofin = o;

	fun = @(x) amp*sin(o*x) + shf;

	pts = load(sprintf("../pomiary/sin/%d.txt", f));
	pts = VIN(pts);

	t = (0 : (length(pts)-1)) / 48000.0;
	org = fun(transpose(t) + det);

	diff = pts - org;

	[u, c, s, w, m] = get_uncertainty(diff);
	wc = get_filter_var(o, amp);

	printf("%d\t%f\t%f\t%f\t%f\t%f\t%1.2f\n", f, u, c, s, w, wc, 100*(wc-w)/w);

	freq(i) = f;
	vars(i) = w;
	werr(i) = 100*(o-2*pi*f)/(2*pi*f);

	phi(i) = asin((pts(1) - shf)/amp);
	cph(i) = get_filter_phi(o);
	sph(i) = det*o;

#	hold on;
#	plot(org)
#	plot(pts)
#	plot(diff)
#	pause()
#	clf()
#	hold off;

#	return

end

#clf
#hold on
#plot(freq, vars)
#plot(freq, werr)
#plot(freq, phi)
#plot(freq, -cph)
#plot(freq, phi-sph)
#hold off

