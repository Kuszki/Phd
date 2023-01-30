clear;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

# [g,a] = wfbt2filterbank({'db1',2,'dwt'})
# [h] = wfilt_db(2)
# wfiltinfo('db2')
# w = fwtinit('db1')

wname = 'db2';
ndec = 3;
nsam = 32;

sam = 5;
fs = 100;

A = lin_ident(@(x) fwt(x, wname, ndec), nsam);
num = get_fwt_levels(nsam, ndec, 'midd')(2);

#[b, a] = butter(1, fc/fs, "low");
#[b,a] = cheby1(1, 3, fc/fs);
#[b, a] = cheby2(1, 3, fc/fs);
#[b] = fir1(11, fc/fs); # fc = 210e3

[h, f] = freqz(A(num,:), [], 256, fs);

amps = abs(h);
amps = amps / max(amps);

semilogx(f, amps);
xlim([0.1 fs])
ylim([0 1])

#h = [-0.1294   0.2241   0.8365   0.4830]; # db2
#g = [-0.4830   0.8365  -0.2241  -0.1294]; # db2
#h = flip(h);
#g = flip(g);

#h = [0.7071   0.7071]; # db1
#g = [-0.7071  0.7071]; # db1

#y = sin(linspace(0, pi, nsam)*5);

#c1 = fwt(y, wname, ndec); # A*transpose(y);
#hc = c1(1:nsam/2); # aproxs
#gc = c1(1+nsam/2:nsam); # detail

#h1 = filter(h, 1, y);
#h1 = h1(2:2:length(h1));
#g1 = filter(g, 1, y);
#g1 = g1(2:2:length(g1));

#subplot(1,2,1)
#hold on;
#plot(gc);
#plot(g1);
#subplot(1,2,2)
#hold on;
#plot(hc);
#plot(h1);

#subplot(1,2,1)
#plot(c1)
#subplot(1,2,2)
#plot(y)

figure();
[g,a] = wfbt2filterbank({wname, ndec, 'dwt'});
filterbankfreqz(g, a, 2048, 100, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.1 fs])
ylim([0 1])
grid on
