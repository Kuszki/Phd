clear
figure

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils");
warning('off', 'Octave:data-file-in-path');

shapes = 'unst';

n_min = 3;
n_max = 9;

#u_max = [ 3 6 10 20 ];
u_max = [ 3 ];

for i = 1 : length(u_max)

  rn = randi([n_min n_max], 2e3, 1);
  fn = @(x) gen_redtest(x, 1.0, u_max(i));
#  fn = @(x) gen_cortest(x, 1.0, u_max(i), 1);

  tic
  errs = pararrayfun(nproc, fn, rn);
  toc

  hist(errs, 100);
  m(i) = mean(errs);
  s(i) = std(errs);

#  save('-z', sprintf('../archiwa/rederr_org_1_%d.txt.gz', u_max(i)), 'errs');

end

u_max, m, s