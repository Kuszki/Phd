function [pd] = gen_cortest(num, u_min, u_max, cor = 1)

  warning('off', 'Octave:data-file-in-path');

  vc = char(zeros(0, num));
  u_df = (u_max - u_min);
  shapes = 'unst';

  rc = randi([1 4], num, 1);
  vu = rand(1, num) * u_df + u_min;
  R = diag(ones(1, num));

  for j = 1 : num
    vc(j) = char(shapes(rc(j)));
  end

  vr = gen_randm(1e5, vc, vu);

  for j = 2 : num
    if vc(j) == vc(1)

      vr(j,:) = (vu(j)/vu(1))*vr(1,:);
      R(1,j) = R(j,1) = cor; #break;

    end
  end

  us = get_uncertainty(sum(vr));

  hm = get_cohermatrix(vc, vu, R);
  uc = sqrt(vu*hm*transpose(vu));

  um = vu * R * transpose(vu);
  ss = sum(vu .^ 2);

  uc = uc * (um/ss)^(1/5);

  pd = 100 * (uc - us) / us;

end

