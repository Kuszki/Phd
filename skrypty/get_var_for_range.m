function [w] = get_var_for_range(amp1, amp2, w0, start = 0, stop = 1, step = 1e5, mode = 'c')

  if strcmp(mode, 'c')
    steps = linspace(start, stop, len);
    len = step;
  else
    steps = start : step : stop;
    len = length(steps);
  end

  w = 0.0;

  for i = steps
    w = w + w0 * amp1(i)^2 * amp2(i)^2 / len;
  end

end
