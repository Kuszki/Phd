clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

wname = 'db2';
ndec = 2;
nsam = 8;

num = 1e6;
from = 5;
to = 5;

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
#A = lin_ident(@(x) fwt(x, wname, ndec), nsam);

rw = [ 0.974 1.01 1.21 0.973 0.699 0.587 0.585 0.541 ];

printf("n\twc\tua\tub\tcb\tus\n")

r = [ ...
1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   1.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   1.0   1.0   0.0   0.0   0.0   0.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0   0.0 ; ...
0.0   0.0   0.0   0.0   0.0   0.0   0.0   0.0   1.0   0.0   0.0   1.0 ];

c = [ 2.16 1.96 1.96 1.96 1.90 1.90 1.41 1.41 1.41 1.41 1.41 1.41 ];

for N = from : to

  [h, f] = freqz(A(N,:), [], [1000, 5000, 15000], 48000);

  amp = abs(h);
  sta = sum(A(N,:));
  ran = sqrt(sum(A(N,:).^2));

  W = [ rw(N) 45.78*ran^2 36.26*ran^2 72.64*ran^2 36.75*sta^2 18.38*sta^2 ...
        19.14*amp(1)^2 119.62*amp(2)^2 119.44*amp(3)^2 ...
        4.64*amp(1)^2 29.00*amp(2)^2 28.99*amp(3)^2];

  tr = gen_randt(num, 1, 'w');
  s1 = gen_rands(num, 1, 'w');
  s2 = gen_rands(num, 1, 'w');
  s3 = gen_rands(num, 1, 'w');

  R = [ ...
    gen_randn(num, W(1), 'w'); ...
    gen_randn(num, W(2), 'w'); ...
    gen_randn(num, W(3), 'w'); ...
    gen_randn(num, W(4), 'w'); ...
    tr*sqrt(W(5)); ...
    tr*sqrt(W(6)); ...
    s1*sqrt(W(7)); ...
    s2*sqrt(W(8)); ...
    s3*sqrt(W(9)); ...
    s1*sqrt(W(10)); ...
    s2*sqrt(W(11)); ...
    s3*sqrt(W(12)); ...
  ];

  len = length(W);
  coh = zeros(len, len);
  k = zeros(len, len);
  h = zeros(len, len);

  for i = 1 : len
    U(i) = get_uncertainty(R(i,:));
  end

  for i = 1 : len
    for j = 1 : len
      if i == j; coh(i,j) = h(i,j) = k(i,j) = 1;
      elseif coh(i,j) == 0

        uc = get_uncertainty(R(j,:) + R(i,:));

        h(i,j) = h(j,i) = (uc^2 - U(i)^2 - U(j)^2)/(2*U(i)*U(j));
        k(i,j) = k(j,i) = (U(i)^2 + U(j)^2)/sum(U .^ 2);

        if h(i,j) > 0.9
          ko = 1;
        else
          ko = k(i,j);
        end

        coh(i,j) = coh(j,i) = h(i,j) * ko;

      end
    end
  end

  sw = sqrt(W);

  W1 = sw*r*transpose(sw)
  Uw = sw .* c;
  Ua = sqrt(W1)*1.96;
  Ub = sqrt(U*coh*transpose(U));
  Cb = Ub / sqrt(W1);
  Us = get_uncertainty(sum(R));

  printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", N, W1, Ua, Ub, Cb, Us);

end