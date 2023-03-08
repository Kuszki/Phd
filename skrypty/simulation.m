clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

#profile clear;
#profile on;

# iterations params
iters_a = 1e5;#2e4;
iters_b = 1e1;#5e1;

# wavelet params
wname = 'db2';
ndec = 2;
nsam = 8;
num = 0;

# output settings
calc_in_uc = 0;
calc_out_uc = 1;
show_prog = 1;

# sampling params
fs = 48e3;
f0 = 1e3;

# objects freq params
fa = 320e3;
fb = 650e3;

# signal settings
am_1 =  6/10; f_1 = 1*f0;  ph_1 = 0;
am_2 = -3/10; f_2 = 5*f0;  ph_2 = pi/8;
am_3 =  1/10; f_3 = 15*f0; ph_3 = pi/6;

# amplifiers settings
amp_b = 3.3;

# temperature settings
t_exp = 20;
t_diff = 3;

# adc settings
nq = 256;
vp =  3.0;
vn = -3.0;
aq = (vp - vn) / nq;

# objects randoms
var_s_t = (3*t_diff^2)/(18);
var_r_s = 2e-5/3;
var_r_a = 1e-5/3;
var_r_c = (aq^2)/12;

# timing evals
ns = nsam * iters_b;
Ts = 1/fs;
T0 = 1/f0;
pi2 = 2*pi;

# input signal
f_in_1 = @(x, fi) am_1*sin(pi2*f_1*x + ph_1 + fi);
f_in_2 = @(x, fi) am_2*sin(pi2*f_2*x + ph_2 + fi);
f_in_3 = @(x, fi) am_3*sin(pi2*f_3*x + ph_3 + fi);
f_in = @(x) f_in_1(x, 0) + f_in_2(x, 0) + f_in_3(x, 0);

# error signals
f_err_1 = @(x, am, fi) am*f_in_1(x, fi) - f_in_1(x, 0);
f_err_2 = @(x, am, fi) am*f_in_2(x, fi) - f_in_2(x, 0);
f_err_3 = @(x, am, fi) am*f_in_3(x, fi) - f_in_3(x, 0);

# adc function
f_adc = @(x) aq * floor(x/aq + 0.5);

# temp functions
f_tm_a = @(x) (3e-3/2) * (x - 20);
f_tm_b = @(x) (7e-3/2) * (x - 20);

# filter functions
f_fil_a_cmp = @(x) 1 / (1 + i * (x/fa));
f_fil_a_amp = @(x) abs(f_fil_a_cmp(x));
f_fil_a_phi = @(x) atan(imag(f_fil_a_cmp(x))./real(f_fil_a_cmp(x)));
f_fil_b_cmp = @(x) 1 / (1 + i * (x/fb));
f_fil_b_amp = @(x) abs(f_fil_b_cmp(x));
f_fil_b_phi = @(x) atan(imag(f_fil_b_cmp(x))./real(f_fil_b_cmp(x)));

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

rw = [ 0.974 1.01 1.21 0.973 0.699 0.587 0.585 0.541 ] * 1e-6;

elen_m = iters_a * iters_b;
elen_v = iters_a * ns;

temp = gen_randt(iters_a, var_s_t, 'w') + t_exp;
phi = rand(1, iters_a) * T0;

errs = zeros(elen_v, 1);
out_E = zeros(elen_m, nsam);

step = floor(iters_a*iters_b / 10);
curr = 1;

tic; for i = 1 : iters_a

  if show_prog && mod(i*iters_b, step) == 0
    printf("%d/%d (%d percnet)\n", i*iters_b, iters_a*iters_b, (i / iters_a) * 100);
  end

  # generate long input vector
  x = Ts*(0 : ns-1);
  x = x + phi(i);
  y = f_in(x);

  # get ideal output vector
  yi = amp_b * y;

  # inject signal noise
  ys = y;
#  ys = y + gen_randn(ns, var_r_s, 'w');

  # perform converter part tasks
  ya = ys;
#  ya = ya + f_tm_a(temp(i));

#  ya = ya + gen_randu(ns, var_r_a, 'w');
  ya = ya ...
#       + f_err_1(x, f_fil_a_amp(f_1), f_fil_a_phi(f_1)) ...
       + f_err_2(x, f_fil_a_amp(f_2), f_fil_a_phi(f_2)) ...
#       + f_err_3(x, f_fil_a_amp(f_3), f_fil_a_phi(f_3)) ...
  ;

  # perform amplifier part tasks
  yb = ya;
  yb = yb ...
#       + f_err_1(x, f_fil_b_amp(f_1), f_fil_b_phi(f_1)) ...
       + f_err_2(x, f_fil_b_amp(f_2), f_fil_b_phi(f_2)) ...
#       + f_err_3(x, f_fil_b_amp(f_3), f_fil_b_phi(f_3)) ...
  ;
  yb = amp_b * yb;
#  yb = yb + f_tm_b(temp(i));

  # perform adc tasks
  yc = yb;
#  yc = f_adc(yc);

  # calc input error
  cerr = transpose(yc - yi);

  if calc_out_uc
    for j = 1 : nsam : ns

      out_E(curr,:) = A*cerr(j:j+nsam-1);
      curr = curr + 1;

    end
  end

  if calc_in_uc
    errs(ns*(i-1)+1:ns*i) = cerr;
  end

end; toc;

for j = 1 : nsam
#  out_E(:,j) = out_E(:,j) + transpose(gen_randn(elen_m, rw(j), 'w'));
end

if calc_in_uc || calc_out_uc
  printf("n\tu\tc\ts\tw\n");
end

if calc_in_uc
  [u_in, c_in, s_in, w_in] = get_uncertainty(errs);
  printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", 0, ...
         u_in * 1000, c_in, s_in * 1000, w_in * 1000000);
end

if calc_out_uc
  for i = 1 : nsam
    if num == i || num == 0
      [u_in, c_in, s_in, w_in] = get_uncertainty(out_E(:,i));
      printf("%d\t%0.2f\t%0.2f\t%0.2f\t%0.2f\n", i, ...
             u_in * 1000, c_in, s_in * 1000, w_in * 1000000);
    end
  end
end

if num > 0
  hist(out_E(:,num), 100);
else
  hist(errs, 100);
end

#profile off;
#profshow();

