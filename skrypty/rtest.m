clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

#s1 = 1; a1 = deg2rad(0);
#s2 = 1; a2 = deg2rad(30);
#s3 = 2; a3 = deg2rad(60);
#
#d = [ s1 s2 s3 ]
#m = [ 1 cos(a2 - a1) cos(a3 - a1); ...
#      cos(a2 - a1) 1 cos(a2 - a3); ...
#      cos(a3 - a1) cos(a3 - a2) 1 ]
#
#w = d*m*transpose(d)
#
#vs1 = [ s1*cos(a1) s1*sin(a1) ]
#vs2 = [ s2*cos(a2) s2*sin(a2) ]
#vs3 = [ s3*cos(a3) s3*sin(a3) ]
#
#vs = vs1 + vs2 + vs3
#as = rad2deg(atan(vs(2)/vs(1)))
#ws = vs(1)^2+vs(2)^2


x1 = gen_randu(1e5, 1, 'w');
x2 = gen_rands(1e5, 1, 'w') - 0.2*x1;
x3 = gen_randt(1e5, 1, 'w') + 0.3*x2;

xs = x1 + x2 + x3;

[u1, c1, s1, w1] = get_uncertainty(x1);
[u2, c2, s2, w2] = get_uncertainty(x2);
[u3, c3, s3, w3] = get_uncertainty(x3);
[us, cs, ss, ws] = get_uncertainty(xs);

#r_12 = get_corelation(x1, x2, 'w')
#r_13 = get_corelation(x1, x3, 'w')
#r_23 = get_corelation(x2, x3, 'w')

vu = [ u1 u2 u3 ];

r_12 = get_coherence(x1, x2, 1, 2, vu)
r_13 = get_coherence(x1, x3, 1, 3, vu)
r_23 = get_coherence(x2, x3, 2, 3, vu)

#r_12 = get_coherence(x1, x2)
#r_13 = get_coherence(x1, x3)
#r_23 = get_coherence(x2, x3)

vr = [ 1    r_12 r_13; ...
       r_12    1 r_23; ...
       r_13 r_23    1 ];

u1, u2, u3, us
uo = sqrt(vu*vr*transpose(vu))

100*(uo - us)/us

