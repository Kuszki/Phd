clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

U = [ 1 1 ];

h_uu = 0.3358;
h_un = 0.1338;
h_us = 0.5233;
h_ut = 0.1774;

h_nu = 0.1338;
h_nn = 0.0000;
h_ns = 0.2876;
h_nt = 0.0218;

h_su = 0.5233;
h_sn = 0.2876;
h_ss = 0.7144;
h_st = 0.3502;

h_tu = 0.1774;
h_tn = 0.0218;
h_ts = 0.3502;
h_tt = 0.0408;

R = [ ...
1 h_uu; ...
h_uu 1; ...
];

x1 = gen_randu(1e6, U(1), 'u');
x2 = gen_randu(1e6, U(2), 'u') + 0.5*x1;

x3 = x1 + x2;

w1 = var(x1);
w2 = var(x2);
w3 = var(x3);

corr = (w3 - w1 - w2)/(2*sqrt(w1)*sqrt(w2))
C = [ 1 corr; corr 1 ];
Rc = C*R*C;

#u1 = get_uncertainty(x1)
#u2 = get_uncertainty(x2)
us = get_uncertainty(x3)

uc = sqrt(U*R*transpose(U))
pd = 100*(uc - us)/us
uc = sqrt(U*Rc*transpose(U))
pd = 100*(uc - us)/us

