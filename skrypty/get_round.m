function y = get_round(x, n)

  f = 10 .^ n;
  y = round(f*x)/f;

end
