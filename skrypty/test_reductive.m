clear
figure

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");

shapes = 'unst';

n_min = 3;
n_max = 9;

u_max = [ 10 ];

for i = 1 : length(u_max)

  rn = randi([n_min n_max], 1e3, 1);
  fn = @(x) gen_redtest(x, 1.0, u_max(i));

  tic
  [errs_a, errs_b, errs_c] = pararrayfun(nproc-1, fn, rn);
  toc

  hist(errs_a, 100);
  m(i) = mean(errs_a);
  s(i) = std(errs_a);

  save('-z', sprintf('../archiwa/rederr_all_1_%d.txt.gz', u_max(i)), 'errs_a', 'errs_b', 'errs_c');

end
