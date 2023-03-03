clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");
save_precision(100);

prefix = "../wektory";

wnames = { 'coif5' };

ndec = [1 2 3 4 5 6 7 8 9 10];
nsam = [8 16 32 64 128 256 512 1024 2048 4096];

for i = 1 : length(wnames)
  for j = ndec
    for k = nsam
      if k / 2^j < 1; continue; end;

      A = lin_ident(@(x) fwt(x, wnames{i}, j), k);
      rn = get_fwt_levels(k, j, 'start')(2);
      A = A(rn,:);

      name = sprintf("%s/%s_%d_%d.txt", prefix, wnames{i}, j, k);
      save("-text", name, "A");

    end
  end
end

