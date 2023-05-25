set fit limit 1e-100
set fit maxiter 0

data = '../pomiary/freq.dat'

wca = 2*pi*175e3
wcb = 2*pi*175e3
ks = 3.27

pa = -1.667e-26
pb = +1.017e-20
pc = -1.970e-15
pd = +1.156e-10
pe = -4.364e-06

ka = +5.420e-03/0.5
kb = +3.808e-06
kc = +0.125+ks

phi0(x) = atan(-x/wca)
fit phi0(x) data using 2:8 via wca

amp0(x) = ks / sqrt((x**2) / (wcb**2) + 1)
fit amp0(x) data using 2:10 via wcb

phi1(x) = pa*x**5 + pb*x**4 + pc*x**3 + pd*x**2 + pe*x
fit phi1(x) data using 2:8 via pa, pb, pc, pd, pe

amp1(x) = kc - ka*exp(kb*x)
fit amp1(x) data using 2:10 via ka, kb

set logscale x
set yrange [ 1.2 : 3.3 ]

plot data using 2:8 t'data', phi0(x) t 'model a', phi1(x) t 'model b'
#plot data using 2:10 t'data', amp0(x) t 'model a', amp1(x) t 'model b'

print 'fc =', (wca+wcb)/4/pi
print 'ks =', ks

pause -1
