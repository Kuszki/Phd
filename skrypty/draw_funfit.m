clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

list = glob("../pomiary/dc/*.txt");
mns = zeros(1, length(list));
dff = zeros(1, length(list));

data = [];
pts = [];

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 8.3])
set(h, "paperposition", [0, 0, [16 8.3]])

set(0, "defaultaxesposition", [0.105, 0.155, 0.865, 0.825])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1});
	dat = load("-ascii", fname);

	mns(i) = mean(dat);
	pts(i) = vcc;

end

F = [ ones(length(pts), 1), pts(:) ];
P = F \ transpose(mns);

fun = @(x) P(1) + P(2)*x;
fpr = @(x) (x - P(1)) / P(2);

y = fun([0 1000]);
x = [0 fpr(y(2))];

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
std(dff)

hold on;
plot(pts, mns, 'x');
plot(x, y);
hold off;
ylabel("Wielkość wyjściowa przetwornika A/C");
xlabel("Napięcie na wejściu toru pomiarowego, mV");
yticks(0 : 512 : 4096);
xlim([0 1000])
ylim([0 4096])
grid on
box on

set (gca, "xminorgrid", "on");

print("../obrazki/static_adcout.svg", "-svgconvert", "-r300");

