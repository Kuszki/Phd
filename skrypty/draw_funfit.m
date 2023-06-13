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

fcolor = "#333333";
ecolor = "#333333";

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 5.65])
set(h, "paperposition", [0, 0, [16 5.65]])

set(0, "defaultaxesposition", [0.105, 0.155, 0.865, 0.825])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1}) / 1000;
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
	vcc = str2num(t{1}{1}) / 1000;
	dat = load("-ascii", fname);
	mnd = mean(dat);

	obl = fpr(mnd);
	dat = dat - fun(vcc);
	data = [data; dat];

	[u, c, s, w, m] = get_uncertainty(dat);

	dff_v(i) = obl - vcc;
	dff_q(i) = mnd - fun(vcc);

	printf("%0.1f\t%0.1f\t%0.3f\t%0.3f\n", vcc, obl, u, s);

end

printf("ADC(x) = %1.7g * x + %1.7g\n", P(2), P(1))
printf("VIN(x) = (x - %1.7g) / %1.7g\n", P(1), P(2))

[uq, cq, sq, wq] = get_uncertainty(data)
[uv, cv, sv, wv] = get_uncertainty(data / P(2))
std_v = std(dff_v)
std_q = std(dff_q)

subplot(1, 2, 1)
hold on;
plot(pts, mns, '+');
plot(x, y);
hold off;
title(sprintf("\\rm{\\itf_{c}}({\\itf_{y}}({\\itx})) = %1.7g\\cdot{\\itx} + %1.6g", P(2), P(1)))
ylabel("Wyjście przetwornika A/C");
xlabel("Napięcie na wejściu toru pomiarowego, V");
yticks(0 : 512 : 4096);
xlim([0 1])
ylim([0 4096])
grid on
box on

subplot(1, 2, 2)
hist(data, 300, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("\\rm\\itU{\\rm = %1.3g}, c{\\rm = %1.2f}", uq, cq))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, liczba kwantów");
xlim([-8 8])
ylim([0 6])
grid on
box on

print("../obrazki/static_adcout.svg", "-svgconvert", "-r300");
