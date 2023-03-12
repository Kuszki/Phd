clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils");
warning('off', 'Octave:data-file-in-path');

wname = 'db2';
ndec = 2;
nsam = 8;

from = 1;
to = 8;

sq2_4 = 4*sqrt(2); sq3 = sqrt(3);
A = [ ...
(5-sq3)/16 (5+sq3)/16 (3+3*sq3)/16 (5+3*sq3)/16 (3+sq3)/16 (3-sq3)/16 (5-3*sq3)/16 (3-3*sq3)/16; ...
(3+sq3)/16 (3-sq3)/16 (5-3*sq3)/16 (3-3*sq3)/16 (5-sq3)/16 (5+sq3)/16 (3+3*sq3)/16 (5+3*sq3)/16; ...
-(1+sq3)/16 (1-sq3)/16 (3-3*sq3)/16 -(1+sq3)/16 -(3-5*sq3)/16 (3+5*sq3)/16 (1-sq3)/16 -(3+3*sq3)/16; ...
-(3-5*sq3)/16 (3+5*sq3)/16 (1-sq3)/16 -(3+3*sq3)/16 -(1+sq3)/16 (1-sq3)/16 (3-3*sq3)/16 -(1+sq3)/16; ...
(1-sq3)/sq2_4 -(3-sq3)/sq2_4 (3+sq3)/sq2_4 -(1+sq3)/sq2_4 0 0 0 0; ...
0 0 (1-sq3)/sq2_4 -(3-sq3)/sq2_4 (3+sq3)/sq2_4 -(1+sq3)/sq2_4 0 0; ...
0 0 0 0 (1-sq3)/sq2_4 -(3-sq3)/sq2_4 (3+sq3)/sq2_4 -(1+sq3)/sq2_4; ...
(3+sq3)/sq2_4 -(1+sq3)/sq2_4 0 0 0 0 (1-sq3)/sq2_4 -(3-sq3)/sq2_4; ];
#A = lin_ident(@(x) fwt(x, wname, ndec), nsam);

rw = [ 0.974 1.01 1.21 0.973 0.699 0.587 0.585 0.541 ]; R = 0;

printf("n\twc\tua\tub\tcb\n")

#c = [ 2.16 1.96 1.96 1.96 1.90 1.90 1.41 1.41 1.41 1.41 1.41 1.41 ];
#C = 'rnnnttssssss';

Ug = [ 74.73 69.28 56.38 56.42 44.02 44.01 44.01 44.11 ];

c = [ 2.16 1.90 1.96 1.41 1.41 1.41 ];
C = 'rtnsss';

for N = from : to

  [h, f] = freqz(A(N,:), [], [1000, 5000, 15000], 48000);

  amp = abs(h);
  sta = sum(A(N,:))^2;
  ran = sqrt(sum(A(N,:).^2))^2;

#  W = [ rw(N) 45.78*ran 36.26*ran 72.64*ran 36.75*sta 18.38*sta ...
#        19.14*amp(1)^2 119.62*amp(2)^2 119.44*amp(3)^2 ...
#        4.64*amp(1)^2 29.00*amp(2)^2 28.99*amp(3)^2 ];

  W = [ rw(N) 107.12*sta 154.68*ran ...
        42.60*amp(1)^2 266.34*amp(2)^2 266.11*amp(3)^2];

  U = c .* sqrt(W);

  [H, S, k1, k2] = get_cohermatrix(C, U);
  uc = sqrt(U*H*transpose(U));
  wc = sum(W);

  un = sqrt(wc)*1.96;
  cc = uc / sqrt(wc);

  printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", N, wc, un, uc, cc);

end
