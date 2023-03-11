clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

list = "stnu";

m = linspace(1, 10, 25);

for a = list
  for b = list

    printf("../archiwa/shapes/%s_%s.txt\n", a, b);
    hv = rv = zeros(1, length(m));

    for i = 1 : length(m)

      fun = @(x) gen_coherence(10, 10*m(i), a, b, 'u', 1e5);
      [h, r] = pararrayfun(nproc-1, fun, 1:1000);

      hv(i) = mean(h);
      rv(i) = mean(r);

    end

    v = transpose([ [m]; [hv] ]);
    save('-ascii', sprintf("../archiwa/shapes/%s_%s.txt", a, b), "v")

  end
end

