clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

list = "nust";

m = 1+10*linspace(0, sqrt(0.9), 20).^2;

for a = list
  for b = list

    hv = rv = zeros(1, length(m));

    for i = 1 : length(m)

      fun = @(x) gen_coherence(1, m(i), a, b, 'u', 1e5, 0);
      [h, r] = pararrayfun(nproc-1, fun, 1:100);

      hv(i) = mean(h);
      rv(i) = mean(r);

    end

    v = transpose([ [m]; [hv] ]);
    save('-ascii', sprintf("../archiwa/shapes/%s_%s.txt", a, b), "v")

  end
end

