clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

list = "nust";

m = linspace(0.05, 0.99, 51) .^ 2;
m = [ -flip(m) 0 m];

for a = list

  hv = rv = zeros(1, length(m));

  for i = 1 : length(m)

    fun = @(x) gen_coherence(1, 1, a, a, 'u', 1e5, m(i));
    [h, r] = pararrayfun(nproc-1, fun, 1:1000);

    hv(i) = mean(h);
    rv(i) = mean(r);

  end

  v = transpose([ [-1 rv 1]; [-1 hv 1] ]);
  save('-ascii', sprintf("../archiwa/cohers/cor_%s.txt", a), "v")

end

