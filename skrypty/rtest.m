clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

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

U = [ 1.87 4.68 4.67 ];
R = [ ...
1 h_ss h_ss; ...
h_ss 1 h_ss; ...
h_ss h_ss 1; ...
];
C = zeros(length(U), length(U));

for i = 1 : length(U)
  for j = 1 : length(U)
    if i == j; C(i,j) = 1;
    elseif C(i,j) == 0

      C(i,j) = C(j,i) = (U(i)^2 + U(j)^2)/sum(U .^ 2);

    end
  end
end

CR = C .* R;

x1 = gen_rands(1e6, U(1), 'u');
x2 = gen_rands(1e6, U(2), 'u');
x3 = gen_rands(1e6, U(3), 'u');

xs = x1 + x2 + x3;

us = get_uncertainty(xs)
uc = sqrt(U*CR*transpose(U))
pd = 100*(uc - us)/us

