clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

num = get_fwtlevels(128, 5, "midd")(2);
A = lin_ident(@(x) fwt(x, "db2", 5), 128)(num,:);

dat = load("../pomiary/freq.dat");
fitted = true;

amps = freqz(A, [], dat(:,1), 48000);
amps = abs(amps);

if fitted
	amp = 479.520163129546;
	shf = 505.924018640675;

	u_s = 0.0;
	e_d = 0.0;
	p_d = 0.0;
else
	amp = 950/2;
	shf = 500;

	u_s = (1.65/sqrt(3))*(5e-3*shf+2);
	e_d = (1.65/sqrt(3))*(5e-3*amp+0.5);
	p_d = 0.0;
end

det = 144 / 12e6 + 1e-6/5.5;

u_r = 0.62 * get_rowcoef(A, 0, 'r'); # 0.62 1.01
u_s = u_s * get_rowcoef(A, 0, 's');

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

	difs = filter(A, 1, pts - org);
	difs = difs(length(A):length(difs));

	[u, c, s, w, m] = get_uncertainty(difs);
	[a, p, u_d, w_d] = get_dynparams([amp amp e_d], [pi get_filter_phi(o) p_d]);

	uv = [u_s, u_r, u_d*amps(i)];
	cv = "uns";

	[uc, cc, sc, wc] = get_unccalc(uv, cv);

	printf("%d\t%f\t%f\t%f\t%f\t%f\t%f\t%1.2f\n", f, u, uc, c, cc, w, wc, 100*(uc-u)/u);

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

