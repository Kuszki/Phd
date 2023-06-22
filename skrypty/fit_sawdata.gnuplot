set fit limit 1e-100
set fit maxiter 0

f = 5;     w = 31.4131795156890;
#f = 100;   w = 628.299970479762;
#f = 200;   w = 1256.59971602846;
#f = 1000;  w = 6282.99870459596;
#f = 10000; w = 62829.9896535270;

src = sprintf('../pomiary/saw/%d.txt', f);

ADC(x) = 4097.958 * x/1000 + 3.518818;
VIN(x) = 1000*(x - 3.518818) / 4097.958;

det = (1e-6)*(144/12) + 1e-6/5.5;
ts = 1.0 / 48000.0

amp0 = 950 / 2.0
shf0 = 500

amp1 = amp0
shf1 = shf0

f0(x) = ADC((2/pi)*asin(sin((x*ts + det)*w)) * amp0 + shf0)
f1(x) = ADC((2/pi)*asin(sin((x*ts + det)*w)) * amp1 + shf1)

fit f1(x) src via amp1, shf1

# set xrange [ 0.618 : 0.6185 ]
# set xrange [ 0 : 20 ]

plot src, f0(x) t 'ideal', f1(x) t 'fit' #, fa(x), fb(x), fc(x), fd(x)

print 'f =', f
print 'w =', w
print 'amp =', amp1
print 'shf =', shf1
print 'det =', det

print 'd_amp =', 100*(amp1-amp0)/amp0, '%'
print 'd_shf =', 100*(shf1-shf0)/shf0, '%'

pause -1
