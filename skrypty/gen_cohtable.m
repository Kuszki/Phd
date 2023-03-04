clear;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

Uv = [ 2 5 10 ];
list = 'nuts';
num = 5e2;

for i = list;
  for j = list

  name = [ i j ];

  printf("$%s$ & %0.3f", name, get_shapefact(name(1), name(2)));

  for k = Uv

    U = [ k 1 ];
    C = name;
    R = 0;

    fun = @(x) get_uncertainty(sum(gen_randm(2e5, C, U)));
    [H, S, k1, k2] = get_cohermatrix(C, U, R);

    us = pararrayfun(nproc-2, fun, 1:num);
    us = mean(us);

    if sum(name == 'n')
      us = us/1.02;
    else
      us = us/1.005;
    end

    uc = sqrt(U*H*transpose(U));
    pdo = 100*(uc - us)/us;
    uc = sqrt(U*(H./k2)*transpose(U));
    pdc = 100*(uc - us)/us;

    printf(" & %0.3f & %+0.2f & %+0.2f", H(1,2), pdc, pdo);

  end

  printf(" \\\\ \\hline\n");

  end
end
