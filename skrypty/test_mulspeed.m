pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

i = 16;

while i <= 8192

  printf("%d : ", i);

  x = rand(i, i);
  y = rand(i, i);

  tic;

  for j = 1:1000
    z = x * y;
  end

  t = toc;
  i = i * 2;

  printf("%f\n", t);

end
