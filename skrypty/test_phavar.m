clear;

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

n_a = 1e5;
n_b = 1e3;

fs = 48e3;
f0 = 5e3;

T0 = 1/f0;
Ts = 1/fs;

phi = rand(1, n_a) * T0;
err = (rand(1, n_a)-0.5) * 0.02*T0;

errs = zeros(1, n_a*n_b);

for i = 1 : n_a

	x = Ts*(0 : n_b-1) + phi(i);

	y1 = sin(2*pi*f0*x);
	y2 = sin(2*pi*f0*x+err(i));

	start = n_b*(i-1)+1;
	stop = n_b*i;

	errs(start:stop) = y2 - y1;

end

[u, c, s, w] = get_uncertainty(errs)

hist(errs, 150, 100);
