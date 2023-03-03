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
set(h, "papersize", [16 11])
set(h, "paperposition", [0, 0, [16 11]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

for i = 1 : length(list)

  subplot(2, 2, i)
  hold on;

  for j = 1 : length(list)

    x = load("-ascii", sprintf("../archiwa/cohers/%s_%s.txt", list(i), list(j)));
    plot(x(:,1), x(:,2), sprintf(";%s;", list(j)));

  end

  hold off;
  legend("location", 'southeast')
  title(sprintf("a) \\rm %s (%s)", names{i}, list(i)))
  ylabel("Współczynnik koherencji");
  xlabel("Współczynnik korelacji");
  xlim([-1 1])
  ylim([-1 1])
  grid on

end

print("../obrazki/cohers.svg", "-svgconvert", dim);

