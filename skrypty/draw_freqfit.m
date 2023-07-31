clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

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

data = load("-ascii", "../pomiary/dynp.dat");

wc = 175e+4; #(1.0659e+06 + 1.09369e+06) / 2.0;
ks = 3.28;

fv = data(:,1);
av = data(:,10);
pv = data(:,8);

phi0 = @(x) atan(-x/wc);
amp0 = @(x) ks ./ sqrt((x .^ 2) ./ (wc .^ 2) + 1);

phi1 = @(x) -2.121e-13*x.^2 - 5.862e-7*x;
amp1 = @(x) ks*ones(rows(x), columns(x));

xv = logspace(2, log10(50000), 50);
aa = amp0(xv*2*pi);
ab = amp1(xv*2*pi);
pa = phi0(xv*2*pi);
pb = phi1(xv*2*pi);

subplot(1, 2, 1)
hold on;
semilogx(fv, av, 'x;;');
semilogx(xv, aa, ';Model "a";');
semilogx(xv, ab, ';Model "b";');
hold off;
ylabel("Wzmocnienie, V/V");
xlabel("Częstotliwość sygnału, Hz");
legend("location", 'northwest')
xlim([0.1 50]*1000)
ylim([-0.03 0.03]+ks)
grid on
box on

subplot(1, 2, 2)
hold on;
semilogx(fv, pv, 'x;;');
semilogx(xv, pa, ';Model "a";');
semilogx(xv, pb, ';Model "b";');
hold off;
ylabel("Przesunięcie fazowe, rad");
xlabel("Częstotliwość sygnału, Hz");
legend("location", 'southwest')
xlim([0.1 50]*1000)
ylim([-0.15 0])
grid on
box on

print("../obrazki/dynamic_ampout.svg", "-svgconvert", "-r300");

