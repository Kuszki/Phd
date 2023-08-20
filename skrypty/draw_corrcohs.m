clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

names = {"Rozkład normalny", "Rozkład jednostajny", "Rozkład trójkątny", "Rozkład dwumodalny"};
list = 'nuts';
dim = "-r300";

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3/2])
set(h, "paperposition", [0, 0, [16 11.3/2]])

set(0, "defaultaxesposition", [0.105, 0.255, 0.865, 0.675])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

hold on;
for i = 1 : length(list)

	x = load("-ascii", sprintf("../pomiary/cor/%s.txt", list(i)));
	plot(x(:,1), x(:,2), sprintf(";\\it%s;", list(i)));

end
hold off;

legend("location", 'southeast', 'orient', 'horizontal')
ylabel("Współczynnik koherencji");
xlabel("Współczynnik korelacji");
xlim([-1 1])
ylim([-1 1])
grid on
box on

print("../obrazki/cohers.svg", "-svgconvert", dim);

