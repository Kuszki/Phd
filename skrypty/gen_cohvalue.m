clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

list = {'uu', 'ss', 'tt', 'un', 'us', 'ut', 'ns', 'nt', 'st'};
list = {'ut'};

for i = 1 : length(list)
  name = list{i};

  fun = @(x) gen_coherence(5, 5, name(1), name(2), 'w', 1e5, 0.0);
  [h, r] = pararrayfun(nproc-1, fun, 1:1000);

  hm = mean(h);, hs = std(h);
  rm = mean(r);, rs = std(r);

#  printf("%0.8e %0.8e\n", rm, hm)
  printf("%s\t%0.5f\n", name, hm)
end

h = pararrayfun(nproc-1, @(x) get_corelation(tst, gen_randu(length(tst), u, 'u')), 1:300)
