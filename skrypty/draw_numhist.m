clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils");
load("../archiwa/f16_coif5_hist.dat");

dim = "-r300";

fcolor = "#333333";
ecolor = "#333333";
nbins = 300;
xran = [0 5.5];

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3])
set(h, "paperposition", [0, 0, [16 11.3]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

[u, c, s, w] = get_uncertainty(x1)

subplot(2, 2, 1)
hist(x1, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("a) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-0.015 0.015]);
ylim([0 6]);
set_comma(gca, 'XY');
grid on;
box on;

[u, c, s, w] = get_uncertainty(x2)

subplot(2, 2, 2)
hist(x2, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("b) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-0.01 0.01]);
ylim([0 6]);
set_comma(gca, 'XY');
grid on;
box on;

[u, c, s, w] = get_uncertainty(x3)

subplot(2, 2, 3)
hist(x3, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("\nc) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-2e-6 2e-6]);
ylim([0 6]);
set_comma(gca, 'XY');
grid on;
box on;

[u, c, s, w] = get_uncertainty(x4)

subplot(2, 2, 4)
hist(x4, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("\nd) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-1e-6 1e-6]);
ylim([0 6]);
set_comma(gca, 'XY');
grid on;
box on;

print("../obrazki/hist_numerr_coif5.svg", "-svgconvert", dim);

