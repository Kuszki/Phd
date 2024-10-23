clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

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

wc = 165e+4;
ks = 3.28;

flim = 30e3;
c = lines(10);

fv = data(:,1);
av = data(:,10);
pv = data(:,8);

phi0 = @(x) atan(-x/wc);
amp0 = @(x) ks ./ sqrt((x .^ 2) ./ (wc .^ 2) + 1);

phi1 = @(x) -2.121e-13*x.^2 - 5.862e-7*x;
amp1 = @(x) ks*ones(rows(x), columns(x));

xv = logspace(2, log10(flim), 50);
aa = amp0(xv*2*pi);
ab = amp1(xv*2*pi);
pa = phi0(xv*2*pi);
pb = phi1(xv*2*pi);

subplot(1, 2, 1)
hold on;
semilogx(fv, av, 'x;;');
semilogx(xv, aa, ';Model \it{}a;', 'color', [c(2,:)]);
semilogx(xv, ab, ';Model \it{}b;', 'color', [c(5,:)]);
hold off;
ylabel("Wzmocnienie, V/V");
xlabel("Częstotliwość sygnału, Hz");
legend("location", 'northwest');
xlim([100 flim]);
ylim([-0.03 0.03]+ks);
yticks((-0.03 : 0.01 : 0.3)+ks);
set_comma(gca, 'Y', '%0.2f');
set_comma(gca, 'X');
grid on;
box on;

subplot(1, 2, 2)
hold on;
semilogx(fv, pv, 'x;;');
semilogx(xv, pa, ';Model \it{}a;', 'color', [c(2,:)]);
semilogx(xv, pb, ';Model \it{}b;', 'color', [c(5,:)]);
hold off;
ylabel("Przesunięcie fazowe, rad");
xlabel("Częstotliwość sygnału, Hz");
legend("location", 'southwest', 'interpreter', 'tex');
xlim([100 flim]);
ylim([-0.12 0]);
set_comma(gca, 'Y', '%0.2f');
set_comma(gca, 'X');
grid on;
box on;

fvf = fv(1:21);
pvf = pv(1:21);
avf = av(1:21);

std_pa = std(phi0(fvf*2*pi) - pvf)
std_pb = std(phi1(fvf*2*pi) - pvf)

std_aa = std(amp0(fvf*2*pi) - avf)
std_ab = std(amp1(fvf*2*pi) - avf)

print("../obrazki/dynamic_ampout.svg");
