clear;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

ADC = @(x) 4095.594 * x/1000 + 4.176439;
VIN = @(x) 1000*(x - 4.176439) / 4095.594;

list = glob("../pomiary/gen/*.txt");
data = [];

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1});
	dat = load("-ascii", fname);

	mns(i) = mean(dat);
	pts(i) = vcc;
	out(i) = VIN(mns(i));
	err(i) = VIN(mns(i)) - vcc;

	diff = VIN(dat) - vcc;
	data = [data; diff];

	[u, c, s, w] = get_uncertainty(diff);

	printf("%d\t%f\t%f\t%f\t%f\n", vcc, u, c, s, err(i))

end

[u, c, s, w] = get_uncertainty(data)

