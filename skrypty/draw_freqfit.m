clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

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

data = load("-ascii", "../pomiary/freq.dat");

wc = (1.0659e+06 + 1.09369e+06) / 2.0;
ks = 3.27;
kc = 0.125+ks;

pa              = -1.70052e-30 ;#    +/- 1.225e-31    (7.205%)
pb              = 6.51751e-24  ;#    +/- 4.567e-25    (7.008%)
pc              = -7.93226e-18 ;#    +/- 5.919e-19    (7.462%)
pd              = 2.92126e-12  ;#    +/- 3.119e-13    (10.68%)
pe              = -6.92367e-07 ;#    +/- 5.658e-08    (8.172%)

ka              = 0.12506      ;#    +/- 0.01842      (14.73%)
kb              = 1.78923e-06  ;#    +/- 1.083e-07    (6.055%)

fv = data(:,1);
av = data(:,10);
pv = data(:,8);

phi0 = @(x) atan(-x/wc);
amp0 = @(x) ks ./ sqrt((x .^ 2) ./ (wc .^ 2) + 1);

phi1 = @(x) pa*x.^5 + pb*x.^4 + pc*x.^3 + pd*x.^2 + pe*x;
amp1 = @(x) kc - ka*exp(kb*x);

xv = logspace(2, log10(300000), 50);
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
legend("location", 'southwest')
xlim([0.1 300]*1000)
ylim([1.5 3.3])
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
xlim([0.1 300]*1000)
ylim([-1.2 0])
grid on
box on

print("../obrazki/dynamic_ampout.svg", "-svgconvert", "-r300");

