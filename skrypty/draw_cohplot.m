clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

list = 'nuts';
dim = "-r300";

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 8.3])
set(h, "paperposition", [0, 0, [16 8.3]])

set(0, "defaultaxesposition", [0.105, 0.155, 0.865, 0.825])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

hold on;

for j = 1 : length(list)

  x = load("-ascii", sprintf("../archiwa/cohers/cor_%s.txt", list(j)));
  plot(x(:,1), x(:,2), sprintf(";%s;", list(j)));

end

hold off;
legend("location", 'southeast')
ylabel("Współczynnik koherencji");
xlabel("Współczynnik korelacji");
xlim([-1 1])
ylim([-1 1])
xticks([-1 : 0.25 : 1])
yticks([-1 : 0.25 : 1])
grid on
box on

print("../obrazki/cohers.svg", "-svgconvert", dim);

