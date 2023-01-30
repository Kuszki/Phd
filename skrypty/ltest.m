clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

wname = 'db2';
ndec = 3;
nsam = 32;

cnt = 1e5;
sam = 1;

#A = lin_ident(@(x) fwt(x, wname, ndec), nsam);
#R = A(sam,:);

b = [ 0.25 0.5 0.25 ];

#e = randn(1, cnt);
#y = zeros(1, cnt);

x = sin(linspace(0, 2*pi, 256));

y1 = filter(b, 1, x);
y2 = x .^ 2;
y2 = filter(b, 1, y2);
y3 = sqrt(y2);

hold on
plot(x, ";x;")
plot(y1, ";y1;");
plot(y2, ";y2;");
plot(y3, ";y3;");

