clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils");
warning('off', 'Octave:data-file-in-path');

shapes = 'unst';

n_min = 3;
n_max = 9;

u_min = 1.0e0;
u_max = 1.0e1;

rn = randi([n_min n_max], 1e4, 1);
fn = @(x) gen_redtest(x, u_min, u_max);

tic
pd = pararrayfun(nproc-1, fn, rn);
toc

hist(pd, 100);
m = mean(pd)
s = std(pd)

