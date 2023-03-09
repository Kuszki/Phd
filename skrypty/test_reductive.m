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
u_max = 3.0e0;
u_df = (u_max - u_min);

rn = randi([n_min n_max], 1e5, 1);
fn = @(x) gen_redtest(x, u_min, n_max);

tic
pd = pararrayfun(nproc-1, fn, rn);
toc

hist(pd);
m = mean(pd)
s = std(pd)

