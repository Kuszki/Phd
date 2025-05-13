clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");


set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3])
set(h, "paperposition", [0, 0, [16 11.3]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

[g,a] = wfbt2filterbank({'db2', 3, 'dwt'});
subplot(2, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka db2, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'db8', 3, 'dwt'});
subplot(2, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka db8, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'db2', 6, 'dwt'});
subplot(2, 2, 3)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("\nc) \\rm falka db2, 6 iteracji");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'db8', 6, 'dwt'});
subplot(2, 2, 4)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("\nd) \\rm falka db8, 6 iteracji");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

print("../obrazki/bank_db_demo.svg");

[g,a] = wfbt2filterbank({'ana:spline2:4', 3, 'dwt'});
subplot(2, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka spline2:4, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'ana:spline4:4', 3, 'dwt'});
subplot(2, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka spline4:4, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'ana:spline2:4', 6, 'dwt'});
subplot(2, 2, 3)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("\nc) \\rm falka spline2:4, 6 iteracji");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'ana:spline4:4', 6, 'dwt'});
subplot(2, 2, 4)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("\nd) \\rm falka spline4:4, 6 iteracji");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

print("../obrazki/bank_spline_demo.svg");

[g,a] = wfbt2filterbank({'dden2', 3, 'dwt'});
subplot(2, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka dden2, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'dden6', 3, 'dwt'});
subplot(2, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka dden6, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'dden2', 6, 'dwt'});
subplot(2, 2, 3)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("\nc) \\rm falka dden2, 6 iteracji");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'dden6', 6, 'dwt'});
subplot(2, 2, 4)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("\nd) \\rm falka dden6, 6 iteracji");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

print("../obrazki/bank_dden_demo.svg");

set(h, "papersize", [18 7])
set(h, "paperposition", [0, 0, [18 7]])

[g,a] = wfbt2filterbank({'db2', 3, 'dwt'});
subplot(1, 2, 1)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("a) \\rm falka db2, 3 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

[g,a] = wfbt2filterbank({'db8', 4, 'dwt'});
subplot(1, 2, 2)
filterbankfreqz(g, a, 2048, 'linabs', 'posfreq', 'plot', 'inf', 'flog');
title("b) \\rm falka db8, 4 iteracje");
ylabel("Wzmocnienie");
xlabel("Częstotliwość znormalizowana\n");
xlim([0.01 1]);
ylim([0 1]);
set_format(gca, 'Title', true);
set_format(gca, 'XY', true);
grid on;
box on;

print("../obrazki/bank_db_short.svg");
