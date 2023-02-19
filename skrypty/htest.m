clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

num = 5e2;
#u = linspace(1, 10, 30);
#c = "nust";

#for i = 1 : length(c)
#  for j = 1 : length(c)
#    src = sprintf("h_%s_%s = h;", c(i), c(j));
#    fun = @(x) get_two_coher(1, x, c(i), c(j), 'u', num);
#
#    h = pararrayfun(nproc, fun, u);
#
#
#    plot(u, h);
#    eval(src);
#  end
#end
#
#save("-z", "../archiwa/coher.txt.gzip", "u", "h_*");
#
#return

W = [ 3.38 3.33 6.67 1.77 11.0 10.95 ];
R = [ ...
  gen_randt(num, W(1), 'w'); ...
  gen_randu(num, W(2), 'w'); ...
  gen_randn(num, W(3), 'w'); ...
  gen_rands(num, W(4), 'w'); ...
  gen_rands(num, W(5), 'w'); ...
  gen_rands(num, W(6), 'w'); ...
];

len = length(W);
coh = zeros(len, len);
k = zeros(len, len);
h = zeros(len, len);

for i = 1 : len
  U(i) = get_uncertainty(R(i,:));
  A = A + R(i,:);
end

for i = 1 : len
  for j = 1 : len
    if i == j
      coh(i,j) = 1;
      h(i,j) = 1;
      k(i,j) = 1;
    elseif coh(i,j) == 0

      uc = get_uncertainty(R(j,:) + R(i,:));

      h(i,j) = (uc^2 - U(i)^2 - U(j)^2)/(2*U(i)*U(j));
      k(i,j) = (U(i)^2 + U(j)^2)/sum(U .^ 2);

      coh(i,j) = h(i,j) * k(i,j);

    end
  end
end

U1 = sqrt(U*coh*transpose(U))
U2 = get_uncertainty(A)
100*(U1-U2)/U2
