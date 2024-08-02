clear;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

n_a = 1e5;
n_b = 1e3;

e_gr = 0.1;

fs = 48e3;
f0 = 5e3;

T0 = 1/f0;
Ts = 1/fs;

phi = rand(1, n_a) * T0;
err = (rand(1, n_a)-0.5) * e_gr;

errs = zeros(1, n_a*n_b);

for i = 1 : n_a

	x = Ts*(0 : n_b-1) + phi(i);

	y1 = sin(2*pi*f0*x);
	y2 = (1 + err(i)) * sin(2*pi*f0*x);

	start = n_b*(i-1)+1;
	stop = n_b*i;

	errs(start:stop) = y2 - y1;

end

Ap = 1 + e_gr;

[u1, c1, s1, w1] = get_uncertainty(errs)

subplot(1, 2, 1)
hist(errs, 150, 100);

errs2 = err .* sin(2*pi*f0*Ts*(0 : n_a-1));

[u2, c2, s2, w2] = get_uncertainty(errs2)

subplot(1, 2, 2)
hist(errs2, 150, 100);

wc = (2*e_gr)^2 / 2
