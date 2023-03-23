clear
clf

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

fun = @(x) 2*sin(x) + 1;
len = 25;

x = linspace(0, 5, len);

y0 = fun(x);
y1 = y0 + 0.25*(rand(1, len) - 0.5);

F = [ ones(len, 1), sin(x(:)) ];
P = LinearRegression(F, y1');

fit = F * P;

hold on;
plot(x, y0)
plot(x, y1, '+')
plot(x, fit)

