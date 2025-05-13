clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

list = glob("../pomiary/cal/*.txt");
pth = "../pomiary/cal";

fcolor = "#333333";
ecolor = "#333333";

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 5.65])
set(h, "paperposition", [0, 0, [16 5.65]])

set(0, "defaultaxesposition", [0.105, 0.155, 0.865, 0.825])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	pts(i) = str2num(t{1}{1});

end

data = [];
pts = sort(pts);

for i = 1 : length(pts)

	vcc = pts(i);
	dat = load("-ascii", sprintf("%s/%d.txt", pth, vcc));

	mns(i) = mean(dat);

end

F = [ ones(length(pts), 1), pts(:) / 1000 ];
P = F \ transpose(mns);

fun = @(x) P(1) + P(2)*x;
fpr = @(x) (x - P(1)) / P(2);

y = fun([0 1]);
x = [0 fpr(y(2))];

for i = 1 : length(pts)

	vcc = pts(i);
	dat = load("-ascii", sprintf("%s/%d.txt", pth, vcc));
	mnd = mean(dat);

	obl = fpr(mnd);
	dat = dat - fun(vcc/1000);

	data = [data; dat];

	[u, c, s, w, m] = get_uncertainty(dat);

	dff_v(i) = obl - vcc/1000;
	dff_q(i) = mnd - fun(vcc/1000);

	printf("%0.1f\t%0.1f\t%0.3f\t%0.3f\n", vcc, obl*1000, u, s);

end

printf("ADC(x) = %1.7g * x + %1.7g\n", P(2), P(1))
printf("VIN(x) = (x - %1.7g) / %1.7g\n", P(1), P(2))

[uq, cq, sq, wq] = get_uncertainty(data)
[uv, cv, sv, wv] = get_uncertainty(data / P(2))
std_v = std(dff_v)
std_q = std(dff_q)

subplot(1, 2, 1)
hold on;
plot(pts / 1000, mns, '.');
plot(x, y);
hold off;
title(strrep(sprintf("\\rm{\\itf_{c}}({\\itf_{y}}({\\itx})) = %1.7g{\\itx} + %1.6g", P(2), P(1)), '.', ','));
ylabel("Wyjście układu A/C, LSB");
xlabel("Napięcie na wejściu toru pomiarowego, V");
yticks(0 : 512 : 4096);
xlim([0 1]);
ylim([0 4096]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

subplot(1, 2, 2)
hist(data, 175, 100, "facecolor", fcolor, "edgecolor", ecolor);
title(strrep(sprintf("\\rm{\\itU} = %1.3g LSB, {\\itc} = %1.2f", uq, cq), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, LSB");
xticks([-3 -1.5 0 1.5 3]);
xlim([-3 3]);
ylim([0 5]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

print("../obrazki/static_adcout.svg");
