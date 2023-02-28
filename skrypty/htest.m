clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

num = 1e6;

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

N = 8;

sq2_4 = 4*sqrt(2); sq3 = sqrt(3);
A = [ ...
(5-sq3)/16 (5+sq3)/16 (3+3*sq3)/16 (5+3*sq3)/16 (3+sq3)/16 (3-sq3)/16 (5-3*sq3)/16 (3-3*sq3)/16; ...
(3+sq3)/16 (3-sq3)/16 (5-3*sq3)/16 (3-3*sq3)/16 (5-sq3)/16 (5+sq3)/16 (3+3*sq3)/16 (5+3*sq3)/16; ...
-(1+sq3)/16 (1-sq3)/16 (3-3*sq3)/16 -(1+sq3)/16 -(3-5*sq3)/16 (3+5*sq3)/16 (1-sq3)/16 -(3+3*sq3)/16; ...
-(3-5*sq3)/16 (3+5*sq3)/16 (1-sq3)/16 -(3+3*sq3)/16 -(1+sq3)/16 (1-sq3)/16 (3-3*sq3)/16 -(1+sq3)/16; ...
(1-sq3)/sq2_4 -(3-sq3)/sq2_4 (3+sq3)/sq2_4 -(1+sq3)/sq2_4 0 0 0 0; ...
0 0 (1-sq3)/sq2_4 -(3-sq3)/sq2_4 (3+sq3)/sq2_4 -(1+sq3)/sq2_4 0 0; ...
0 0 0 0 (1-sq3)/sq2_4 -(3-sq3)/sq2_4 (3+sq3)/sq2_4 -(1+sq3)/sq2_4; ...
(3+sq3)/sq2_4 -(1+sq3)/sq2_4 0 0 0 0 (1-sq3)/sq2_4 -(3-sq3)/sq2_4; ];

[h, f] = freqz(A(N,:), [], [1000, 5000, 15000], 48000);

amp = abs(h);
sta = sum(A(N,:));
ran = sqrt(sum(A(N,:).^2));

W = [ 2 107.01*sta^2 154.68*ran^2 42.60*amp(1)^2 266.34*amp(2)^2 266.11*amp(3)^2 ];
R = [ ...
  gen_randu(num, W(1), 'w'); ...
  gen_randt(num, W(2), 'w'); ...
  gen_randn(num, W(3), 'w'); ...
  gen_rands(num, W(4), 'w'); ...
  gen_rands(num, W(5), 'w'); ...
  gen_rands(num, W(6), 'w'); ...
];
A = zeros(1, num);

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
    if i == j; coh(i,j) = h(i,j) = k(i,j) = 1;
    elseif coh(i,j) == 0

      uc = get_uncertainty(R(j,:) + R(i,:));

      h(i,j) = h(j,i) = (uc^2 - U(i)^2 - U(j)^2)/(2*U(i)*U(j));
      k(i,j) = k(j,i) = (U(i)^2 + U(j)^2)/sum(U .^ 2);

      coh(i,j) = coh(j,i) = h(i,j) * k(i,j);

    end
  end
end

W1 = sum(W)
Ua = sqrt(W1)*1.96
Ub = sqrt(U*coh*transpose(U))
Cb = Ub / sqrt(W1)

#U2 = get_uncertainty(A)
#100*(U1-U2)/U2
