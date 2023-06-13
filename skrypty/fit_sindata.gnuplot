set fit limit 1e-100
set fit maxiter 0

#f = 5;    w = 31.4131795156; src = '../pomiary/sin/5.txt';
#f = 100;  w = 628.300073967; src = '../pomiary/sin/100.txt';
#f = 200;  w = 1256.59845943; src = '../pomiary/sin/200.txt';
f = 1000; w = 6282.99493480; src = '../pomiary/sin/1000.txt';
#f = 10000; w = 62829.9224255; src = '../pomiary/sin/10000.txt';

ADC(x) = 4095.594 * x/1000 + 4.176439;
VIN(x) = 1000*(x - 4.176439) / 4095.594;

det = 6.5e-05
ts = 1.0 / 48000.0

amp0 = 950 / 2.0
shf0 = 500

amp1 = 479.973167260702
shf1 = 505.89

f0(x) = ADC(sin(x*ts*w + det) * amp0 + shf0)
f1(x) = ADC(sin(x*ts*w + det) * amp1 + shf1)

fa(x) = ADC(sin(x*ts*w + det) * ((0.98*950-2) / 2.0) + (0.98*500-2))
fb(x) = ADC(sin(x*ts*w + det) * ((0.98*950-2) / 2.0) + (1.02*500+2))
fc(x) = ADC(sin(x*ts*w + det) * ((1.02*950+2) / 2.0) + (0.98*500-2))
fd(x) = ADC(sin(x*ts*w + det) * ((1.02*950+2) / 2.0) + (1.02*500+2))

#fit f1(x) src via det #amp1, shf1

# set xrange [ 0.618 : 0.6185 ]
# set xrange [ 0 : 64 ]

plot src, f0(x) t 'ideal', f1(x) t 'fit' #, fa(x), fb(x), fc(x), fd(x)

print 'f =', f
print 'w =', w
print 'amp =', amp1, 100*(amp1-amp0)/amp0, '%'
print 'shf =', shf1, 100*(shf1-shf0)/shf0, '%'
print 'det =', det

pause -1
