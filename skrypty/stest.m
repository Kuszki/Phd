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

A = lin_ident(@(x) fwt(x, wname, ndec), nsam);
R = A(sam,:);

e = randn(1, cnt);
y = zeros(1, cnt);

for i = 1 : cnt
  x = ones(nsam, 1)*e(i);
  y(i) = R * x;
end

vy = var(y)
ve = var(e)

rc = get_rowcoef(R)
hist(y, 100)
