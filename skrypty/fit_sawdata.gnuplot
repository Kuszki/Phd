set fit logfile '/dev/null'
set fit limit 1e-100
set fit maxiter 0
set fit quiet

f = int(ARGV[1])
w = ARGV[2]

wac = (2*pi)/(6.0e+3*7.0e-12);

phi = 1.995e-17*w**3 - 3.118e-12*w**2 - 5.029e-7*w;
phi = phi + atan(-w/wac);

src = sprintf('../pomiary/saw/%d.txt', f);

ADC(x) = 4097.958 * x/1000 + 3.518818;
VIN(x) = 1000*(x - 3.518818) / 4097.958;

det = 144 / 12e6;
ts = 1.0 / 48000.0;

amp = 950 / 2.0
shf = 500

f(x) = ADC((2/pi)*asin(sin((x*ts + det)*w + phi)) * amp + shf)
fit f(x) src via amp, shf

# set xrange [ 0.618 : 0.6185 ]
# set xrange [ 0 : 20 ]

#plot src, f(x)

print f, w, amp, shf

#pause -1
