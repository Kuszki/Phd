set fit limit 1e-100
set fit maxiter 0

data = '../pomiary/freq.dat'

fc = 145e3
ks = 3.17

phi(x) = 180*atan(-x/fc)/pi
fit phi(x) data using 1:5 via fc

amp(x) = ks / sqrt((x**2) / (fc**2) + 1)
fit amp(x) data using 1:6 via ks, fc

#plot data using 1:5 t'', phi(x) t ''
plot data using 1:6 t'', amp(x) t ''

print 'fc =', fc
print 'ks =', ks

pause -1
