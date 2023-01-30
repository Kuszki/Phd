clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

wname = 'db3';
ndec = 2;
nsam = 32;

sam = 7;
fs = 100;
fc = 20;
cnt = 1e4;

A = lin_ident(@(x) fwt(x, wname, ndec), nsam);
sam = get_fwt_levels(nsam, ndec, 'midd')(1);

[b, a] = butter(1, fc/fs, "low");

[h1, f1] = freqz(b, a, 256, fs);
[h2, f2] = freqz(A(sam,:), [], 256, fs*2);
[h3, f3] = freqz([1/4 1/2 1/4], [], 256, fs*2);

amps1 = abs(h1);
amp1 = @(x) interp1(f1, amps1, x);
fi1 = @(x) interp1(f1, atan(imag(h1)./real(h1)), x);

amps2 = abs(h2);
amp2 = @(x) interp1(f2, amps2, x);
fi2 = @(x) interp1(f2, atan(imag(h2)./real(h2)), x);

amps3 = abs(h3);
amp3 = @(x) interp1(f3, amps2, x);
fi3 = @(x) interp1(f3, atan(imag(h3)./real(h3)), x);

fun = @(x) 1 / (1 + i * (x/fc));
f4 = linspace(0, fs, 256);
h4 = arrayfun(fun, f4);
amps4 = abs(h4);

#subplot(2,1,1)
#hold on;
#semilogx(f3, amps3, ";butter;");
#semilogx(f4, amps4, ";analog;");
#xlim([1 fs/2])

hold on;
plot(f1, amps1, ";butter;");
plot(f4, amps4, ";analog;");
#xlim([1 fs/2])

#subplot(2,1,2)
#hold on;
#semilogx(f3, imag(h3)./real(h3), ";butter;");
#semilogx(f4, imag(h4)./real(h4), ";analog;");
#xlim([1 fs/2])

return;

vars_f = zeros(cnt, nsam);
vars_y = zeros(cnt, 2);

for i = 1 : cnt

  y1 = rand(1, nsam);
  y2 = filter(b, a, y1);
#  y2 = y2(1:10:length(y2));

  vars_f(i,:) = A * transpose(y2);
  vars_y(i,1) = var(y1);
  vars_y(i,2) = var(y2);

end

vr = var(vars_f);
mn = mean(vars_y)

plot(vr)

wf = get_var_for_range(amp1, @(x) 1, mn(1), 0, 99, 1)

get_var_for_range(amp1, amp2, mn(1), 0, 99, 1)
vr(sam)

#subplot(2,1,1)
#plot(y1);
#subplot(2,1,2)
#plot(y2);

#y1 = randn(1, 1e5);
#y2 = filter(b, a, y1);
#
#subplot(2,1,1)
#plotfft(fft(y1), 'linabs', 'posfreq');
#subplot(2,1,2)
#plotfft(fft(y2), 'linabs', 'posfreq');
#
#var(y1)
#var(y2)

#semilogx(f1, amps1);

#figure();
#[g,a] = wfbt2filterbank({wname, ndec, 'dwt'});
#filterbankfreqz(g, a, 2048, 100, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
#ylabel("Wzmocnienie");
#xlabel("Częstotliwość znormalizowana\n");
#xlim([0.1 fs])
#ylim([0 1])
#grid on
