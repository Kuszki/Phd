set fit limit 1e-100
set fit maxiter 0

name = '../archiwa/fwterr/rerror_coif5_plot.dat'

val1 = 7.43e-15
amp1 = 2.34e-16
zer1 = 2.70e-16

val2 = 1.38e-14
amp2 = 2.34e-16
zer2 = 5.39e-17

val3 = 2.48e-14
amp3 = 2.34e-16
zer3 = -5.8e-17

val4 = 4.74e-14
amp4 = 2.34e-16
zer4 = -8.6e-16

val5 = 9.20e-14
amp5 = 2.34e-16
zer5 = -2.3e-15

val6 = 1.80e-13
amp6 = 1.69e-16
zer6 = -4.2e-15

fun1(x) = (x > (val1-zer1)/amp1) ? val1 : amp1 * x + zer1
fit fun1(x) name using 1:2 via val1, amp1, zer1

fun2(x) = (x > (val2-zer2)/amp2) ? val2 : amp2 * x + zer2
fit fun2(x) name using 1:3 via val2, amp2, zer2

fun3(x) = (x > (val3-zer3)/amp3) ? val3 : amp3 * x + zer3
fit fun3(x) name using 1:4 via val3, amp3, zer3

fun4(x) = (x > (val4-zer4)/amp4) ? val4 : amp4 * x + zer4
fit fun4(x) name using 1:5 via val4, amp4, zer4

fun5(x) = (x > (val5-zer5)/amp5) ? val5 : amp5 * x + zer5
fit fun5(x) name using 1:6 via val5, amp5, zer5

fun6(x) = (x > (val6-zer6)/amp6) ? val6 : amp6 * x + zer6
fit fun6(x) name using 1:7 via val6, amp6, zer6

#set term pdf size 16cm,10.3cm font "Latin Modern Roman,18"
#set output "../obrazki/dwt_rerror_coif5.pdf"

set logscale x 2
set logscale y 10

set yrange [ 1e-15 : 2e-13 ]
set xrange [ 8 : 4096 ]

set ylabel "Wariancja błędu zaokrągleń"
set xlabel "Liczba wielkości wejściowych algorytmu"

set key right bottom horizontal title 'Liczba iteracji procesu dekompozycji' samplen 1

set grid mytics xtics ytics

plot name using 1:2 t'1' lc rgb '#0072bd' pt 1, [8:4096] fun1(x) t'' lc rgb '#0072bd', \
	name using 1:3 t'2' lc rgb '#d95319' pt 2, [8:4096] fun2(x) t'' lc rgb '#d95319', \
	name using 1:4 t'3' lc rgb '#edb120' pt 3, [8:4096] fun3(x) t'' lc rgb '#edb120', \
	name using 1:5 t'4' lc rgb '#7e2f8e' pt 1, [16:4096] fun4(x) t'' lc rgb '#7e2f8e', \
	name using 1:6 t'5' lc rgb '#77ac30' pt 2, [32:4096] fun5(x) t'' lc rgb '#77ac30', \
	name using 1:7 t'6' lc rgb '#a2142f' pt 3, [64:4096] fun6(x) t'' lc rgb '#a2142f'

print 1, val1, amp1, zer1, 8, 4096
print 2, val2, amp2, zer2, 8, 4096
print 3, val3, amp3, zer3, 8, 4096
print 4, val4, amp4, zer4, 16, 4096
print 5, val5, amp5, zer5, 32, 4096
print 6, val6, amp6, zer6, 64, 4096

pause -1
