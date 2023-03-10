clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

dim = "-r300";

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3])
set(h, "paperposition", [0, 0, [16 11.3]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

[g,a] = wfbt2filterbank({'db2', 3, 'dwt'});
subplot(2, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka db2, 3 iteracje")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'db8', 3, 'dwt'});
subplot(2, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka db8, 3 iteracje")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'db2', 6, 'dwt'});
subplot(2, 2, 3)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("c) \\rm falka db2, 6 iteracji")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'db8', 6, 'dwt'});
subplot(2, 2, 4)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("d) \\rm falka db8, 6 iteracji")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1])
ylim([0 1])
grid on
box on

print("bank_db_demo.svg", "-svgconvert", dim);

[g,a] = wfbt2filterbank({'ana:spline2:4', 3, 'dwt'});
subplot(2, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka spline2:4, 3 iteracje")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'ana:spline4:4', 3, 'dwt'});
subplot(2, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka spline4:4, 3 iteracje")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'ana:spline2:4', 6, 'dwt'});
subplot(2, 2, 3)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("c) \\rm falka spline2:4, 6 iteracji")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'ana:spline4:4', 6, 'dwt'});
subplot(2, 2, 4)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("d) \\rm falka spline4:4, 6 iteracji")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1])
ylim([0 1])
grid on
box on

print("bank_spline_demo.svg", "-svgconvert", dim);

[g,a] = wfbt2filterbank({'dden2', 3, 'dwt'});
subplot(2, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka dden2, 3 iteracje")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'dden6', 3, 'dwt'});
subplot(2, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka dden6, 3 iteracje")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'dden2', 6, 'dwt'});
subplot(2, 2, 3)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("c) \\rm falka dden2, 6 iteracji")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1])
ylim([0 1])
grid on
box on

[g,a] = wfbt2filterbank({'dden6', 6, 'dwt'});
subplot(2, 2, 4)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("d) \\rm falka dden6, 6 iteracji")
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1])
ylim([0 1])
grid on
box on

print("bank_dden_demo.svg", "-svgconvert", dim);

