clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

# sampling params
dec = 16;
fs = 48e3;
f0 = 1e3;
fu = fs*dec;

# objects freq params
fa = 320e3;
fb = 650e3;

var_r_s = 2e-5/3;

f_fil_a_cmp = @(x) 1 / (1 + i * (x/fa));
a_amp = @(x) abs(f_fil_a_cmp(x));
f_phi = @(x) atan(imag(f_fil_a_cmp(x))./real(f_fil_a_cmp(x)));

#wf = get_var_for_range(f_amp, @(x) 1, var_r_s, 0, fu-1, fu / 1000)

fh = 15e3;
ah = 0.1;
ph = pi/6;

a_amp(fh);
f_phi(fh);

s1 = a_amp(fh)*ah; a1 = f_phi(fh) + ph;
s2 = -ah;          a2 = ph;

d = [ s1 s2 ];
m = [ 1 cos(a2 - a1); ...
      cos(a2 - a1) 1 ];

w = sqrt(d*m*transpose(d));

vs1 = [ s1*cos(a1) s1*sin(a1) ];
vs2 = [ s2*cos(a2) s2*sin(a2) ];

vs = vs1 + vs2
as = atan(vs(2)/vs(1))
ws = sqrt(vs(1)^2+vs(2)^2)
