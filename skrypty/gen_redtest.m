function [pd] = gen_redtest(num, u_min, u_max, check = false)

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

  if check; for j = 1 : num
    vu(j) = get_uncertainty(vr(j,:));
  end; end

  hm = get_cohermatrix(vc, vu);
  uc = sqrt(vu*hm*transpose(vu));

  pd = 100 * (uc - us) / us;

end

