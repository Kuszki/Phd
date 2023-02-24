clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

# iterations params
iters_a = 1e4;#2e4;
iters_b = 1e1;#5e1;

# wavelet params
wname = 'db2';
ndec = 2;
nsam = 8;
num = get_fwt_levels(nsam, ndec, 'midd')(1);

# output settings
calc_in_uc = 1;
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

# objects randoms
var_s_t = (3*t_diff^2)/(18);
var_r_s = 2e-5/3;
var_r_a = 1e-5/3;

# adc settings
nq = 256;
vp =  3.0;
vn = -3.0;
aq = (vp - vn) / nq;

# timing evals
ns = nsam * iters_b;
Ts = 1/fs;
T0 = 1/f0;

# input signal
f_in_1 = @(x, fi) am_1*sin(2*pi*f_1*x + ph_1 + fi);
f_in_2 = @(x, fi) am_2*sin(2*pi*f_2*x + ph_2 + fi);
f_in_3 = @(x, fi) am_3*sin(2*pi*f_3*x + ph_3 + fi);
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

A = lin_ident(@(x) fwt(x, wname, ndec), nsam);
R = A(num,:);

elen_m = iters_a * iters_b;
elen_v = iters_a * ns;

temp = gen_randt(iters_a, var_s_t, 'w') + t_exp;
phi = (rand(1, iters_a) - 0.5) * T0 * 10;

out_E = zeros(elen_m, nsam);
errs = zeros(1, elen_v);

step = floor(iters_a*iters_b / 10);
errs = [];
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
  ys = y + gen_randn(ns, var_r_s, 'w');

  # perform converter part tasks
  ya = ys;
  ya = ya + f_tm_a(temp(i));
  ya = ya + gen_randu(ns, var_r_a, 'w');
  ya = ya ...
       + f_err_1(x, f_fil_a_amp(f_1), f_fil_a_phi(f_1)) ...
       + f_err_2(x, f_fil_a_amp(f_2), f_fil_a_phi(f_2)) ...
       + f_err_3(x, f_fil_a_amp(f_3), f_fil_a_phi(f_3)) ...
  ;

  # perform amplifier part tasks
  yb = ya;
  yb = yb ...
       + f_err_1(x, f_fil_b_amp(f_1), f_fil_b_phi(f_1)) ...
       + f_err_2(x, f_fil_b_amp(f_2), f_fil_b_phi(f_2)) ...
       + f_err_3(x, f_fil_b_amp(f_3), f_fil_b_phi(f_3)) ...
  ;
  yb = amp_b * yb;
  yb = yb + f_tm_b(temp(i));

  # perform adc tasks
  yc = yb;
  yc = f_adc(yc);

  # calc input error
  errs(ns*(i-1)+1:ns*i) = yc - yi;

  for j = 1 : nsam : ns

    part_I = yi(j:j+nsam-1);
    part_T = yc(j:j+nsam-1);

    out_E(curr,:) = A*transpose(part_T - part_I);

    curr = curr + 1;

  end

end; toc;

#errs = (errs / amp_b);

if calc_in_uc
  [u_in, c_in, s_in, w_in] = get_uncertainty(errs);
  u_in = u_in * 1000
  c_in
  s_in = s_in * 1000
  w_in = w_in * 1000000
else
  w_in = var(errs/amp_b)
  s_in = sqrt(w_in)
  u_in = s_in * 1.96
end

hist(errs, 100);

#  plot(x, ea)
#  plotfft(fft(y), fs, 'posfreq', 'flog', 'linabs')
#  plot(xw, et)

#  hold on
#  plot(x, y)
#  plot(xw, yw)
#  xlim([0 2*T0])
