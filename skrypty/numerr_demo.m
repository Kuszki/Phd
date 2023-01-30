clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

dim = "-r300";

fcolor = "#333333";
ecolor = "#333333";
nbins = 300;
xran = [0 5.5];

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11])
set(h, "paperposition", [0, 0, [16 11]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

x = load("-ascii", "f16_coif5_6_2048.dat");
[u, c, s, w] = get_uncertainty(x, 0.95, 10)

subplot(2, 2, 1)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("a) \\rm\\it N{ =\\rm 2^{11}}, U{ =\\rm %0.2g}, c{ =\\rm %1.2f}\n", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-s*5 s*5])
ylim([0 5.5])
grid on

x = load("-ascii", "f16_coif5_6_256.dat");
[u, c, s, w] = get_uncertainty(x, 0.95, 10)

subplot(2, 2, 2)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("b) \\rm\\it N{ =\\rm 2^{9}}, U{ =\\rm %0.2g}, c{ =\\rm %1.2f}\n", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-s*5 s*5])
ylim([0 5.5])
grid on

x = load("-ascii", "f32_coif5_6_2048.dat");
[u, c, s, w] = get_uncertainty(x, 0.95, 10)

subplot(2, 2, 3)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("c) \\rm\\it N{ =\\rm 2^{11}}, U{ =\\rm %0.2g}, c{ =\\rm %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-s*5 s*5])
ylim([0 5.5])
grid on

x = load("-ascii", "f32_coif5_6_256.dat");
[u, c, s, w] = get_uncertainty(x, 0.95, 10)

subplot(2, 2, 4)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("d) \\rm\\it N{ =\\rm 2^{9}}, U{ =\\rm %0.2g}, c{ =\\rm %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-s*5 s*5])
ylim([0 5.5])
grid on

print("../obrazki/hist_numerr_coif5.svg", "-svgconvert", dim);

