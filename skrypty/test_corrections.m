clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

printf("lp\tus\tuc\tdu\n");
pr = "%s\t%0.2f\t%0.2f\t%0.2f\n";

Ua1 = [ 2.13 13.26 11.80 16.70 23.04 16.29 12.32 25.08 2.35 6.07 12.35 1.16 ]; usa1 = 73.21;
Ua2 = [ 1.81 13.26 11.80 16.70 1e-5 1e-5 0.06 3.77 19.16 0.04 1.85 9.44 ]; usa2 = 43.93;

Ca = 'nnnnttssssss';
Ra = [ ...
1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   1.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   1.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0 ];

Ub1 = [ 2.13 39.31 24.38 18.39 37.42 3.5 ]; usb1 = 73.21;
Ub2 = [ 1.81 1e-3 24.38 0.073 5.62 28.6 ]; usb2 = 43.93;
Cb = 'ntnsss';
Rb = 0;

Ux = [ 5 6 7 3 8 4 2 10 ];
Cx = 'ustsnuss';
Rx = 0;

[Ha1] = get_cohermatrix(Ca, Ua1, Ra); ua1 = sqrt(Ua1*Ha1*transpose(Ua1));
[Ha2] = get_cohermatrix(Ca, Ua2, Ra); ua2 = sqrt(Ua2*Ha2*transpose(Ua2));
[Hb1] = get_cohermatrix(Cb, Ub1, Rb); ub1 = sqrt(Ub1*Hb1*transpose(Ub1));
[Hb2] = get_cohermatrix(Cb, Ub2, Rb); ub2 = sqrt(Ub2*Hb2*transpose(Ub2));

[Hx] = get_cohermatrix(Cx, Ux, Rx);
usx = get_uncertainty(sum(gen_randm(1e5, Cx, Ux)));
ux = sqrt(Ux*Hx*transpose(Ux));

#printf(pr, "a1", usa1, ua1, 100*(ua1 - usa1)/usa1);
#printf(pr, "a2", usa2, ua2, 100*(ua2 - usa2)/usa2);
#printf(pr, "b1", usb1, ub1, 100*(ub1 - usb1)/usb1);
#printf(pr, "b2", usb2, ub2, 100*(ub2 - usb2)/usb2);
#
#printf(pr, "a1", usx, ux, 100*(ux - usx)/usx);

printf("%s\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", "c",
       100*(ua1 - usa1)/usa1,
       100*(ua2 - usa2)/usa2,
       100*(ub1 - usb1)/usb1,
       100*(ub2 - usb2)/usb2,
       100*(ux - usx)/usx);

# k2^(1/2)        -4.96   -4.50   2.17    -0.77   1.55
# k2^(1/3)        -4.16   -3.74   3.21    0.17    4.76

