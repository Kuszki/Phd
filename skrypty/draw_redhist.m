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
set(h, "papersize", [16 11.3])
set(h, "paperposition", [0, 0, [16 11.3]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

load('../archiwa/rederr_mod_1_3.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, 'n')

subplot(2, 2, 1)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("a) \\rm\\it U_{-}{\\rm = %1.2f}, U_{+}{\\rm = %1.2f}", um, up))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-10 10])
ylim([0 3])
grid on
box on

load('../archiwa/rederr_mod_1_6.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, 'n')

subplot(2, 2, 2)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("b) \\rm\\it U_{-}{\\rm = %1.2f}, U_{+}{\\rm = %1.2f}", um, up))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-10 10])
ylim([0 3])
grid on
box on

load('../archiwa/rederr_mod_1_10.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, 'n')

subplot(2, 2, 3)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("c) \\rm\\it U_{-}{\\rm = %1.2f}, U_{+}{\\rm = %1.2f}", um, up))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-10 10])
ylim([0 3])
grid on
box on

load('../archiwa/rederr_mod_1_20.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, 'n')

subplot(2, 2, 4)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("d) \\rm\\it U_{-}{\\rm = %1.2f}, U_{+}{\\rm = %1.2f}", um, up))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu");
xlim([-10 10])
ylim([0 3])
grid on
box on

print("../obrazki/hist_reductive.svg", "-svgconvert", dim);

