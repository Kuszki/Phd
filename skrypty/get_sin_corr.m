function [r] = get_sin_corr(w1, w2, fi1, fi2)

  m = max(w1, w2) / min(w1, w2);
  ep = 0.005 * 2*pi;

  per1 = 2*pi; o1 = per1;
  per2 = 2*pi/m; o2 = per2;

  while abs(per1 - per2) > ep
    if per1 > per2
      per2 = per2 + o2;
    else
      per1 = per1 + o1;
    end
  end

  x = linspace(-per1, per2, 1024);

  fi1 = deg2rad(fi1);
  fi2 = deg2rad(fi2);

  y1 = sin(1 * x + fi1);
  y2 = sin(m * x + fi2);

  v1 = var(y1); s1 = std(y1);
  v2 = var(y2); s2 = std(y2);

  v_cor = var(y1 + y2);
  r = (v_cor - (v1 + v2)) / (2*s1*s2);
#
#  hold on
#  plot(y1); mean(y1)
#  plot(y2); mean(y2)
#  plot(y1 + y2); mean(y1+y2)
#
#  var(y1)
#  var(y2)
#  var(y1+y2)

end
