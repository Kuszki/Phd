clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd")(1);
A = lin_ident(@(x) fwt(x, "spline4:4", 5), 128)(num,:);

dat = load("../pomiary/freq.dat");

amps = freqz(A, [], dat(:,1), 48000);
amps = abs(amps);

#amp = 950/2;
#shf = 500;

amp = 479.520163129546;
shf = 505.924018640675;

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

	difs = zeros(1, length(pts)-128);
	diff = pts - org;

	for j = 1 : length(pts)-127

		difs(j) = A * diff(j : j+127);

	end

	[u, c, s, w, m] = get_uncertainty(difs);
	wc = get_filter_var(o, amps(i)*amp);

	printf("%d\t%f\t%f\t%f\t%f\t%f\t%1.2f\n", f, u, c, s, w, wc, 100*(wc-w)/w);

	freq(i) = f;
	vars(i) = w;

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
#hold off

