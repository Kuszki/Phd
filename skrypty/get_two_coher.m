function h = get_two_coher(u1, u2, c1, c2, mode = 'u', num = 1e6)

  switch (c1)
    case 'n'
      g1 = @(x) gen_randn(num, x, mode);
    case 'u'
      g1 = @(x) gen_randu(num, x, mode);
    case 's'
      g1 = @(x) gen_rands(num, x, mode);
    case 't'
      g1 = @(x) gen_randt(num, x, mode);
  end

  switch (c2)
    case 'n'
      g2 = @(x) gen_randn(num, x, mode);
    case 'u'
      g2 = @(x) gen_randu(num, x, mode);
    case 's'
      g2 = @(x) gen_rands(num, x, mode);
    case 't'
      g2 = @(x) gen_randt(num, x, mode);
  end

  x1 = g1(u1); u1 = get_uncertainty(x1);
  x2 = g2(u2); u2 = get_uncertainty(x2);

  u3 = get_uncertainty(x1 + x2);

  h = (u3^2 - u1^2 - u2^2) / (2*u1*u2);

end
