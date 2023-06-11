clear;
clf;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

ADC = @(x) 4.0956 * x + 4.1764;
VIN = @(x) (x - 4.1764) / 4.0956

list = glob("../pomiary/dc/*.txt");

data = [];
pts = [];

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1});
	dat = load("-ascii", fname);

	mns(i) = mean(dat);
	pts(i) = vcc;
	out(i) = ADC(vcc);
	err(i) = mns(i) - out(i);

	printf("%d\t%f\t%f\t%f\n", vcc, mns(i), out(i), 100*(mns(i) - out(i))/out(i))

end

F = [ ones(length(pts), 1), pts(:) ];
P = F \ transpose(mns);

printf("\n");

fun = @(x) P(1) + P(2)*x;
fpr = @(x) (x - P(1)) / P(2);

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1});
	dat = load("-ascii", fname);

	obl = fpr(mean(dat));
	dat = dat - fun(vcc);
	data = [data; dat];

	[u, c, s, w, m] = get_uncertainty(dat);
	dff(i) = obl - vcc;
	stds(i) = s;

	printf("%0.1f\t%0.1f\t%0.3f\t%0.3f\n", vcc, obl, u, s);

end

[u, c, s, w] = get_uncertainty(data)

x = [0 1000];
y0 = ADC(x);
y1 = fun(x);

ep = (ADC(1.02*x) - y0)/sqrt(3);
em = (ADC(0.98*x) - y0)/sqrt(3);

hold on;
plot(pts, err, 'x');
plot(x, y1 - y0);
plot(x, ep, '-')
plot(x, em, '-')
hold off;
