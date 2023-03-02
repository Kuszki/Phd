clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

list = "nust";

m = linspace(-1, 1, 50) .^ 3;

for a = list
  for b = list

    hv = rv = zeros(1, length(m));

    for i = 1 : length(m)

      fun = @(x) get_two_coher(1, 1, a, b, 's', 1e5, m(i));
      [h, r] = pararrayfun(nproc-1, fun, 1:500);

      hv(i) = mean(h);
      rv(i) = mean(r);
    end

    v = transpose([ [rv]; [hv] ]);
    save('-ascii', sprintf("../archiwa/cohers/%s_%s.txt", a, b), "v")

  end
end

