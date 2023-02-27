clear;
figure;

sq3 = sqrt(3);

a_S20 = [ (5-sq3), (5+sq3), (3+3*sq3), (5+3*sq3), (3+sq3), (3-sq3), (5-3*sq3), (3-3*sq3) ] / 16;
a_T10 = [ (1-sq3), -(3-sq3), (3+sq3), -(1+sq3) ] / (4*sqrt(2));

H_S20 = @(x) a_S20(1) + a_S20(2)*e^(-i*x) + a_S20(3)*e^(-2*i*x) + a_S20(4)*e^(-3*i*x) + ...
             a_S20(5)*e^(-4*i*x) + a_S20(6)*e^(-5*i*x) + a_S20(7)*e^(-6*i*x) + a_S20(8)*e^(-7*i*x);
A_S20 = @(x) abs(H_S20(x));

H_T10 = @(x) a_T10(1) + a_T10(2)*e^(-i*x) + a_T10(3)*e^(-2*i*x) + a_T10(4)*e^(-3*i*x);
A_T10 = @(x) abs(H_T10(x));

A_S20_f = @(x) A_S20(2*pi*x/48000);
A_T10_f = @(x) A_T10(2*pi*x/48000);

f = linspace(0, 48000/2, 128);
k_S20 = arrayfun(A_S20_f, f);
k_T10 = arrayfun(A_T10_f, f);
f = f / (2*pi);

hold on;
plot(f, k_T10);
plot(f, k_S20);

#ts = 1/48000;
#f_1 = 15000;
#x = ts*[0:1024];
#y = sin(2*pi*f_1*x);
#
#y1 = filter(a_T10, 1, y);
#y2 = filter([-0.1294 -0.2241 0.8365 -0.4830 0 0 0 0], 1, y);
#
#[h1, f1] = freqz([-0.1294 -0.2241 0.8365 -0.4830 0 0 0 0], [], 256);
#[h2, f2] = freqz(a_T10, [], 256);
#
#hold on
#plot(f1, abs(h1))
#plot(f2, abs(h2))
#return
#
#hold on
#plot(y)
#plot(y1)
#plot(y2)
#xlim([1 50])
