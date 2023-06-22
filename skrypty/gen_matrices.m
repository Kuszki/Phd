clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("../biblioteki");
save_precision(100);

prefix = "../macierze";

wnames = { ...
  'db1' 'db2' 'db3' 'db4' 'db5' 'db6' 'db7' 'db8' 'db9' 'db10' ...
  'sym2' 'sym3' 'sym4' 'sym5' 'sym6' 'sym7' 'sym8' 'sym9' 'sym10' ...
  'coif1' 'coif2' 'coif3' 'coif4' 'coif5' ...
  'spline1:1' 'spline1:3' 'spline2:2' 'spline2:4' 'spline3:1' 'spline3:3' ...
  'dden1' 'dden2' ...
};

ndec = [1 2 3 4 5 6 7 8 9 10];
nsam = [8 16 32 64 128 256 512 1024 2048 4096];

for i = 1 : length(wnames)
  for j = ndec
    for k = nsam
      if k / 2^j < 2; continue; end;

      A = lin_ident(@(x) fwt(x, wnames{i}, j), k);

      name = sprintf("%s/%s_%d_%d.txt", prefix, wnames{i}, j, k);
      save("-text", name, "A");

    end
  end
end

