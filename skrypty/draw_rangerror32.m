clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 7])
set(h, "paperposition", [0, 0, [16 7]])

set(0, "defaultaxesposition", [0.125, 0.225, 0.850, 0.715])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

names = {"+;{\\itS}_{2};", "x;{\\itT}_{2};", "*;{\\itT}_{1};"};

m = load('-ascii', '../archiwa/rerror_db2_2_128_32_fun.dat');
v = load('-ascii', '../archiwa/rerror_db2_2_128_32_plot.dat');
c = lines(rows(m));

x1 = 1 : 1 : 9;
x2 = 0 : 0.1 : 10;

hold on;

for i = 1:length(names)

	y1 = v(:,i);
	y2 = m(i,1)*x2.^2 + m(i,2)*x2;

	plot(x1, y1, names{i}, "Color", [c(i,:)]);
	plot(x2, y2, "HandleVisibility", "off", "Color", [c(i,:)]);

end

hold off;
legend("location", 'northwest', 'orientation', 'horizontal')
ylabel("Wariancja błędów zaokrągleń");
xlabel("Zakres wartości wielkości wejściowych \\pm\\itx");
xlim([0 10]);
set_format(gca, 'Title');
set_format(gca, 'Y', '%0.1g');
set_format(gca, 'X');
grid on;
grid minor off;
box on;

print("../obrazki/rerror_db2_2_128_32_pl.svg");
