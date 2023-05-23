set fit limit 1e-100
set fit maxiter 0

f = 5; w = 31.413179515689; src = '../pomiary/sin/5.txt';
#f = 100; w = 628.300073967; src = '../pomiary/sin/100.txt';
#f = 300; w = 1884.89856506; n = 9;
#f = 600; w = 3769.79937398; n = 13;
#f = 1000; w = 6283.0012178; n = 17;
#f = 3000; w = 18848.980283; n = 21;
#f = 6000; w = 37697.957507; n = 25;
#f = 10000; w = 62829.93185; n = 29;
#f = 20000; w = 125659.8632; n = 33;

ADC(x) = 4.0956 * x + 4.1764
VIN(x) = (x - 4.1764) / 4.0956

det = 6e-6
ts = 1.0 / 48000.0

amp0 = ADC(950 / 2.0)
shf0 = ADC(500)

amp0 = amp0
shf0 = shf0

f0(x) = sin(x*ts*w - det) * amp0 + shf0
f1(x) = sin(x*ts*w - det) * amp1 + shf1

#fa(x) = sin(x*ts*w - det) * ADC((0.99*950-1) / 2.0) + ADC(0.995*500-2)
#fb(x) = sin(x*ts*w - det) * ADC((0.99*950-1) / 2.0) + ADC(1.005*500+2)
#fc(x) = sin(x*ts*w - det) * ADC((1.01*950+1) / 2.0) + ADC(0.995*500-2)
#fd(x) = sin(x*ts*w - det) * ADC((1.01*950+1) / 2.0) + ADC(1.005*500+2)

fit f1(x) src via amp1, shf1

# set xrange [ 0.618 : 0.6185 ]
# set xrange [ 0 : 64 ]

plot src, f0(x) t 'ideal', f1(x) t 'fit' # fa(x), fb(x), fc(x), fd(x)

print 'f =', f
print 'w =', w
print 'amp =', amp1
print 'shf =', shf1
print 'det =', det

pause -1
