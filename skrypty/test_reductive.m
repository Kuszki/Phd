clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");

shapes = 'unst';

n_min = 2;
n_max = 5;

u_max = [ 3 5 10 20 ];

for i = 1 : length(u_max)

  rn = randi([n_min n_max], 1e5, 1);
  fn = @(x) gen_redtest(x, 1.0, u_max(i));

  tic
  [errs_a, errs_b, errs_c] = pararrayfun(nproc-1, fn, rn);
  toc

  save('-z', sprintf('../archiwa/rederr_all_%d_%d_1_%d.txt.gz', n_min, n_max, u_max(i)), 'errs_a', 'errs_b', 'errs_c');

end
