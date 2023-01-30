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

load("../archiwa/simulation_a_static.txt.gzip")
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs, 0.95, 10)

subplot(2, 2, 1)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("a) \\rm\\it U{ =\\rm %0.2f mV}, c{ =\\rm %1.2f}\n", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
ylim([0 0.85])
grid on

load("../archiwa/simulation_a_dynamic.txt.gzip")
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs, 0.95, 10)

subplot(2, 2, 2)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("b) \\rm\\it U{ =\\rm %0.2f mV}, c{ =\\rm %1.2f}\n", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
ylim([0 0.85])
grid on

load("../archiwa/simulation_a_random.txt.gzip")
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs, 0.95, 10)

subplot(2, 2, 3)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("c) \\rm\\it U{ =\\rm %0.2f mV}, c{ =\\rm %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
ylim([0 1.2])
grid on

load("../archiwa/simulation_a_summary.txt.gzip")
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs, 0.95, 10)

subplot(2, 2, 4)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("d) \\rm\\it U{ =\\rm %0.2f mV}, c{ =\\rm %1.2f}", u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
ylim([0 1.2])
grid on

print("../obrazki/hist_part_a.svg", "-svgconvert", dim);

