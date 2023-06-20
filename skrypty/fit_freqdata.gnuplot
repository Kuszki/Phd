set fit limit 1e-100
set fit maxiter 0

data = '../pomiary/dynp.dat'

fran = 2*pi*50000

wca = 2*pi*175e3
wcb = 2*pi*175e3
ks = 3.27

pa = 0 # -1.70052e-30;
pb = 0 # 6.51751e-24;
pc = -7.93226e-18;
pd = 2.92126e-12;
pe = -2.6935e-6;

ka = 0.125 #+5.420e-03/0.5
kb = 1.789e-6 #+3.808e-06
kc = 3.395 #+0.125+ks

phi0(x) = atan(-x/wca)
fit phi0(x) data using 2:8 via wca

amp0(x) = ks / sqrt((x**2) / (wcb**2) + 1)
fit amp0(x) data using 2:10 via wcb

phi1(x) = pa*x**5 + pb*x**4 + pc*x**3 + pd*x**2 + pe*x
fit[0:fran] phi1(x) data using 2:8 via pe, pd, pc #, pb, pa

amp1(x) = kc - ka*exp(kb*x)
#fit amp1(x) data using 2:10 via ka, kb

set logscale x
#set yrange [ 1.2 : 3.3 ]

plot[1:fran] data using 2:8 t'data', phi0(x) t 'model a', phi1(x) t 'model b'
#plot data using 2:10 t'data', amp0(x) t 'model a', amp1(x) t 'model b'

print 'fc =', (wca+wcb)/4/pi
print 'ks =', ks

pause -1
