set fit limit 1e-100
set fit maxiter 0

#f = 100; w = 628.298788105; n = 5;
#f = 300; w = 1884.89856506; n = 9;
f = 600; w = 3769.79937398; n = 13;
#f = 1000; w = 6283.0012178; n = 17;
#f = 3000; w = 18848.980283; n = 21;
#f = 6000; w = 37697.957507; n = 25;
#f = 10000; w = 62829.93185; n = 29;
#f = 20000; w = 125659.8632; n = 33;

det = 0.000389161369826207
vpp = 4001.90
vdd = 107.80
ts = 1.0 / 48000.0

amp = 1945.15558093725 # (vpp - vdd) / 2.0
shf = 2057.47285211783 # amp + vdd

data = '../pomiary/sin.dat'

fun(x) = sin(x*ts*w - det) * amp + shf
fit fun(x) data using 1:n via det

# set xrange [ 0.618 : 0.6185 ]
set xrange [ 0 : 64 ]

plot data using 1:n t'', fun(x) t ''

print 0, amp, shf, det
print f, w

pause -1
