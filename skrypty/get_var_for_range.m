function [w] = get_var_for_range(amp1, amp2, w0, start = 0, stop = 1, step = 1e-2)

  steps = start : step : stop;
  len = length(steps);

#  mr = zeros(len, len);
#  wd = zeros(len, 1);
#
#  d0 = sqrt(w0);
#  i = 1;
#
#  for f = steps
#    wd(i) = d0 * amp1(f) * amp2(f);
#    wd(i) = wd(i) / len;
#
#    i = i + 1;
#  end
#
#  for i = 1 : len
#    for j = 1 : len
#      mr(i,j) = cos(fi1(steps(i)) - fi2(steps(j)));
#    end
#  end
#
#  w = transpose(wd) * mr * wd;

  w = 0.0;

  for i = steps
    w = w + w0 * amp1(i)^2 * amp2(i)^2;
  end

  w = w / length(steps);

end
