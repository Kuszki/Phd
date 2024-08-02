clear;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

n_a = 1e5;

fs = 48e3;
f0 = 5e3;

T0 = 1/f0;
Ts = 1/fs;

phi = rand(1, n_a) * T0;
err = (rand(1, n_a)-0.5) * 0.05;
val = rand(1, n_a);

errs = zeros(1, n_a);

for i = 1 : n_a

	x = val(i);

	y1 = x;
	y2 = (1+err(i))*x;


	errs(i) = y2 - y1;

end

[u, c, s, w] = get_uncertainty(errs)

hist(errs, 150, 100);
