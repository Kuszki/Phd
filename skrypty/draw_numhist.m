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
set(h, "papersize", [16 5.65])
set(h, "paperposition", [0, 0, [16 5.65])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

x = load("-ascii", "../archiwa/fwterr/f16_coif5_6_2048.dat");
[u, c, s, w] = get_uncertainty(x)

subplot(2, 2, 1)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("a) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-0.015 0.015])
ylim([0 6])
grid on
box on

x = load("-ascii", "../archiwa/fwterr/f16_coif5_6_256.dat");
[u, c, s, w] = get_uncertainty(x)

subplot(2, 2, 2)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("b) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-0.01 0.01])
ylim([0 6])
grid on
box on

x = load("-ascii", "../archiwa/fwterr/f32_coif5_6_2048.dat");
[u, c, s, w] = get_uncertainty(x)

subplot(2, 2, 3)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("\nc) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-2e-6 2e-6])
ylim([0 6])
grid on
box on

x = load("-ascii", "../archiwa/fwterr/f32_coif5_6_256.dat");
[u, c, s, w] = get_uncertainty(x)

subplot(2, 2, 4)
hist(x, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("\nd) \\rm\\it N{\\rm = 2^{11}}, U{\\rm = %0.2e}, c{\\rm = %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-1e-6 1e-6])
ylim([0 6])
grid on
box on

print("../obrazki/hist_numerr_coif5.svg", "-svgconvert", dim);

