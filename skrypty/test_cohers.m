clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils");
warning('off', 'Octave:data-file-in-path');

wname = 'db2';
ndec = 2;
nsam = 8;

U = [ 2.13 39.31 24.38 18.39 37.42 3.50 ];
C = 'rtnsss';

[H, S, k1, k2] = get_cohermatrix(C, U);
uc = sqrt(U*H*transpose(U))
