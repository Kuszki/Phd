clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");

list = {'uu', 'ss', 'tt', 'un', 'us', 'ut', 'ns', 'nt', 'st'};
list = {'ut'};

for i = 1 : length(list)

  name = list{i};

  fun = @(x) gen_coherence(5, 5, name(1), name(2), 'u', 1e5);
  [h, r] = pararrayfun(nproc-1, fun, 1:1000);

  hm = mean(h);, hs = std(h);
  rm = mean(r);, rs = std(r);

  printf("%s\t%0.5f\n", name, hm)

end

