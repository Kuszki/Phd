clear;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

ADC = @(x) 4097.958 * x/1000 + 3.518818;
VIN = @(x) 1000*(x - 3.518818) / 4097.958;

list = glob("../pomiary/gen/*.txt");

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	pts(i) = str2num(t{1}{1});

end

data = [];
pts = sort(pts);

for i = 1 : length(pts)

	vcc = pts(i);
	dat = load("-ascii", sprintf("../pomiary/gen/%d.txt", vcc));

	mns(i) = mean(dat);
	out(i) = VIN(mns(i));
	err(i) = out(i) - vcc;

	diff = VIN(dat) - vcc;
	data = [data; diff];

	[u, c, s, w] = get_uncertainty(diff);

	printf("%d\t%f\t%f\t%f\t%f\n", vcc, u, c, s, err(i))

end

F = [ ones(length(pts), 1), pts(:) ];
P = F \ transpose(mns);

fun = @(x) P(1) + P(2)*x;
fpr = @(x) (x - P(1)) / P(2);

printf("ADC(x) = %1.7g * x + %1.7g\n", P(2), P(1))
printf("VIN(x) = (x - %1.7g) / %1.7g\n", P(1), P(2))

[u, c, s, w, m] = get_uncertainty(data)

plot(pts, err)
