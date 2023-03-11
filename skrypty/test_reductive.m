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

u_max = [ 3 6 10 20 ];

for i = 1 : length(u_max)

  rn = randi([n_min n_max], 5e3, 1);
  fn = @(x) gen_redtest(x, 1.0, u_max(i));

  tic
  errs = pararrayfun(nproc-1, fn, rn);
  toc

  hist(errs, 100);
  m(i) = mean(errs);
  s(i) = std(errs);

  #save('-z', sprintf('../archiwa/rederr_org_1_%d.txt.gz', u_max(i)), 'errs');

end

u_max, m, s

