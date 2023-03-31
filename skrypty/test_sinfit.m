clear
clf

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

saw = @(x) (2/pi)*asin(sin(x));

dat = load("../pomiary/saw.dat");
x = dat(:,1);

w = 628.299489193742
amp = 1945.15548626686
shf = 2057.47449431667
det = 0.000389161370887997

f = @(x, f) sin((1.0 / 48000.0) * x * f - det) * amp + shf;
f = @(x, f) saw((1.0 / 48000.0) * x * f - det) * amp + shf;

col = dat(:,5);
ide = f(x, w);
dif = col - ide;

hold on;
plot(x, col, 'x');
plot(x, ide);
hold off;

#plot(dif);

[u, c, s, w, m] = get_uncertainty(dif)
