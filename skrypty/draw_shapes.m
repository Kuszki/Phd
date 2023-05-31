clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

names = {"Rozkład normalny", "Rozkład jednostajny", "Rozkład trójkątny", "Rozkład dwumodalny"};
list = 'nuts';
dim = "-r300";
yl = [ 0.5 0.8 0.6 1.0 ];

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3])
set(h, "paperposition", [0, 0, [16 11.3]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

for i = 1 : length(list)

  subplot(2, 2, i)
  hold on;

  num = char('a'+i-1);

  for j = 1 : length(list)

    x = load("-ascii", sprintf("../archiwa/shapes/%s_%s.txt", list(i), list(j)));
    plot(x(:,1), x(:,2), sprintf(";\\it%s;", list(j)));

  end

  if i > 2
     num = sprintf("\n%s", num);
  end

  hold off;
  legend("location", 'north', 'orient', 'horizontal')
  title(sprintf("%s) \\rm %s ({\\it%s})", num, names{i}, list(i)))
  ylabel("Współczynnik kształtu");
  xlabel(sprintf("Stosunek wartości{\\it U/U_{%s}}", list(i)));
  xlim([1 10])
  ylim([0 yl(i)])
  yticks(0 : 0.2 : yl(i))
  grid on
  box on

end

print("../obrazki/shapes.svg", "-svgconvert", dim);

