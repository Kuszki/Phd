set fit limit 1e-100
set fit maxiter 0

w = 31.415
m = 39
a = -1

fun(x) = sin(w*(x + a))/(m*(x + a))
fit fun(x) 'harm_var.dat' using 1:2 via m


set xrange [ -0.5 : 3 ]
set yrange [ -1 : 1 ]

plot 'harm_var.dat' using 1:2 t'pts', fun(x) t'f1'

pause -1
