function [pd, po, pg] = gen_redtest(num, u_min, u_max)

  vc = char(zeros(0, num));
  u_df = (u_max - u_min);
  shapes = 'unst';

  rc = randi([1 4], num, 1);
  vu = rand(1, num) * u_df + u_min;

  for j = 1 : num
    vc(j) = char(shapes(rc(j)));
  end

  vr = gen_randm(1e5, vc, vu);
  us = get_uncertainty(sum(vr));

  for j = 1 : num
    [vu(j), ~, vs(j)] = get_uncertainty(vr(j,:));
  end

  [hm, sm, k1, k2] = get_cohermatrix(vc, vu);

  uc = sqrt(vu*hm*transpose(vu));
  pd = 100 * (uc - us) / us;

  uc = sqrt(vu*(hm ./ k2)*transpose(vu));
  po = 100 * (uc - us) / us;

  uc = 1.96 * sqrt(sum(vs .^ 2));
  pg = 100 * (uc - us) / us;

end

