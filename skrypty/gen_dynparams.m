clear

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("../biblioteki");

fa = 320e3;
fb = 650e3;

f_fil_a_cmp = @(x) 1 / (1 + i * (x/fa));
f_fil_a_amp = @(x) abs(f_fil_a_cmp(x));
f_fil_a_phi = @(x) atan(imag(f_fil_a_cmp(x))./real(f_fil_a_cmp(x)));
f_fil_b_cmp = @(x) 1 / (1 + i * (x/fb));
f_fil_b_amp = @(x) abs(f_fil_b_cmp(x));
f_fil_b_phi = @(x) atan(imag(f_fil_b_cmp(x))./real(f_fil_b_cmp(x)));

fc = 1000;

a1 = 600;
a2 = 600;
ac = 3.3;

p1 = f_fil_b_phi(fc)
p2 = pi
pc = 0;

[a, p] = get_dynparams([a1 a2] * ac, [p1 p2] + pc);

w = a^2 / 2;
u = 1.41*a/sqrt(2);

printf("a = %1.2f\np = %1.2f\nw = %1.2f\nu = %1.2f\n", a, p, w, u)

#a = 3.3*a
#p = p + f_fil_b_phi(fc)
