clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

a = 'u';
b = 'n';

fun = @(x) gen_coherence(1, 1, a, b, 'u', 5e5, 0.0);
[h, r] = pararrayfun(nproc-1, fun, 1:500);

hm = mean(h), hs = std(h);
rm = mean(r), rs = std(r);

printf("%0.8e %0.8e\n", rm, hm)

