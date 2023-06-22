clear;
clf;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

x = linspace(0, 6*pi, 1e4);
[y, av, fv] = gen_sawfun(x, 1, 1, 0, 10);

av
wv = (av .^ 2)/2

sum(wv)
var(y)

plot(x, y)

return

ADC = @(x) 4095.594 * x/1000 + 4.176439;
VIN = @(x) 1000*(x - 4.176439) / 4095.594;

w = 31.413179515689;
ts = 1.0 / 48000.0;
det = 6e-06;

amp0 = ADC(950 / 2.0);
shf0 = ADC(500);

amp1 = 1965.77810383354;
shf1 = 2076.18928401243;

f0 = @(x) sin(x*ts*w - det) * amp0 + shf0;
f1 = @(x) sin(x*ts*w - det) * amp1 + shf1;

x = 0 : 30000;
y0 = f0(x);
y1 = f1(x);

plot(y1 - y0)

