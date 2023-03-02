function [h, r] = get_two_coher(p1, p2, c1, c2, mode = 'u', num = 1e6, cor = 0.0)

  switch (c1)
    case 'n'
      x1 = gen_randn(num, p1, mode);
    case 'u'
      x1 = gen_randu(num, p1, mode);
    case 's'
      x1 = gen_rands(num, p1, mode);
    case 't'
      x1 = gen_randt(num, p1, mode);
  end

  switch (c2)
    case 'n'
      x2 = gen_randn(num, p2, mode);
    case 'u'
      x2 = gen_randu(num, p2, mode);
    case 's'
      x2 = gen_rands(num, p2, mode);
    case 't'
      x2 = gen_randt(num, p2, mode);
  end

  if cor > 0.0
    x2 = sqrt(1-cor)*x2 + sqrt(cor)*x1;
  elseif cor < 0.0
    x2 = sqrt(cor+1)*x2 - sqrt(-cor)*x1;
  end

  [u1, c1, s1, w1] = get_uncertainty(x1);
  [u2, c2, s2, w2] = get_uncertainty(x2);
  [u3, c3, s3, w3] = get_uncertainty(x1 + x2);

  h = (u3^2 - u1^2 - u2^2) / (2*u1*u2);
  r = (w3 - w1 - w2) / (2*s1*s2);

end

