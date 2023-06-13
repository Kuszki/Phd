clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

#a1 = a2 = 0.6;
#ph1 = -3.13e-3;
#ph2 = pi;

a1 = a2 = 0.6;
ph1 = -3.13e-3;
ph2 = pi;

[a, p] = get_dynparams ([0.6 0.6]*1000, [-3.13e-3 pi]);

w = a^2 / 2;
u = 1.41*a/sqrt(2);

printf("a = %1.2f\np = %1.2f\nw = %1.2f\nu = %1.2f\n", a, p, w, u)
