clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");

texp = [3 : 12];
lab = num2str([2 .^ texp](:), '%d');

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 7])
set(h, "paperposition", [0, 0, [16 7]])

set(0, "defaultaxesposition", [0.120, 0.215, 0.850, 0.725])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

m = load('-ascii', '../archiwa/rerror_coif5_16_fun.dat');
v = load('-ascii', '../archiwa/rerror_coif5_16_plot.dat');
c = lines(rows(m));
p = '+x*+x*';
pl = length(p);

function [x] = fun(x, val, amp, zer)
  for i = 1 : length(x)
    if x(i) > ((val-zer)/amp)
      x(i) = val;
    else
      x(i) = amp * x(i) + zer;
    end
  end
end

hold on

for i = 1 : rows(m)

  x = 2 .^ linspace(log2(m(i,5)), log2(m(i,6)), 128);

  loglog(v(:,1), v(:,i+1), sprintf("%s;%d;", char(p(i)), i), "Color", [c(i,:)]);
  loglog(x, fun(x, m(i,2), m(i,3), m(i,4)), "HandleVisibility", "off", "Color", [c(i,:)]);

end

hold off;
legend("location", 'southeast', 'orientation', 'horizontal')
ylabel("Wariancja błędów zaokrągleń");
xlabel("Liczba wielkości wejściowych");
xticks(2 .^ texp);
xticklabels({lab});
xlim([8 4096]);
ylim([1e-7 1e-5]);
set_format(gca, 'Title');
set_format(gca, 'X');
set_format(gca, 'Y', '%0.1g');
grid on;
grid minor off;
box on;

set (gca, "yminorgrid", "on");

print("../obrazki/dwt_rerror_coif5_16_pl.svg");
