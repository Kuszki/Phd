clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

C = "uunu";
R = diag(ones(1, length(C)));

x1 = gen_randu(1e6, 1.5, 'u');
x2 = gen_randu(1e6, 1.0, 'u') + 1 * x1;
x3 = gen_randu(1e6, 1.5, 'u');
x4 = gen_randt(1e6, 1.5, 'u') + 0.1 * x2 + 0.2*x3;

errs = x1 + x2 + x3 + x4;

U = [ get_uncertainty(x1) get_uncertainty(x2) get_uncertainty(x3) get_uncertainty(x4) ];

[h12, r12] = get_corelation(x1, x2); h12 = get_round(h12, 2); r12 = get_round(r12, 2);
[h13, r13] = get_corelation(x1, x3); h13 = get_round(h13, 2); r13 = get_round(r13, 2);
[h14, r14] = get_corelation(x1, x4); h14 = get_round(h14, 2); r14 = get_round(r14, 2);
[h23, r23] = get_corelation(x2, x3); h23 = get_round(h23, 2); r23 = get_round(r23, 2);
[h24, r24] = get_corelation(x2, x4); h24 = get_round(h24, 2); r24 = get_round(r24, 2);
[h34, r34] = get_corelation(x3, x4); h34 = get_round(h34, 2); r34 = get_round(r34, 2);

Rh = [ 1 h12 h13 h14; h12 1 h23 h24; h13 h23 1 h34; h14 h24 h34 1 ];
Rr = [ 1 r12 r13 r14; r12 1 r23 r24; r13 r23 1 r34; r14 r24 r34 1 ];

Rh = Rh .* (Rr != 0.0);

[H, S, k1, k2] = get_cohermatrix(C, U, Rh);

us = get_uncertainty(errs)

uc = sqrt(U*H*transpose(U))
pd = 100*(uc - us)/us

