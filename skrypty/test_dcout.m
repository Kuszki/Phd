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

data = rnde = [];
pts = sort(pts);

for i = 1 : length(pts)

	vcc = pts(i);
	dat = load("-ascii", sprintf("../pomiary/gen/%d.txt", vcc));

	mns(i) = mean(dat);
	out(i) = VIN(mns(i));
	err(i) = out(i) - vcc;

	vin = VIN(dat);
	diff = vin - vcc;
	data = [data; diff];
	rnde = [rnde; (vin-mean(vin))];

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
[u, c, s, w, m] = get_uncertainty(rnde)

#plot(pts, err-mean(err))
#std(err)

sx = 475*sin(linspace(0, 2*pi, 10240))+500;
sy = interp1(pts, err-mean(err), sx, "spline");
sy = -1.936e-6*sx.^2 + 5.691e-4*sx + 4e-1;

hist(sy, 100)
[u, c, s, w, m] = get_uncertainty(sy)

