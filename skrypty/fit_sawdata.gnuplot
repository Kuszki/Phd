set fit limit 1e-100
set fit maxiter 0

f = 5; w = 31.413179515689; src = '../pomiary/saw/5.txt';
#f = 100; w = 628.300073967; src = '../pomiary/saw/100.txt';

det = 6e-6
vpp = 3997.4
vdd = 106.57
ts = 1.0 / 48000.0

amp = 1945.4 # (vpp - vdd) / 2.0 # 1965.52484526667 #
shf = 2052.0 # amp + vdd # 2076.99344608306 #

fun(x) = (2/pi)*asin(sin(x*ts*w - det)) * amp + shf
#fit fun(x) src via amp, shf, w

# set xrange [ 0.618 : 0.6185 ]
# set xrange [ 0 : 64 ]

plot src, fun(x) t ''

print 'f =', f
print 'w =', w
print 'amp =', amp
print 'shf =', shf
print 'det =', det

pause -1
