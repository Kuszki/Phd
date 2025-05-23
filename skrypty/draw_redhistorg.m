clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");

fcolor = "#333333";
ecolor = "#333333";
nbins = 300;
xran = [0 5.5];

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 11.3])
set(h, "paperposition", [0, 0, [16 11.3]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

load('../archiwa/rederr_org_1_3.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, false)

subplot(2, 2, 1)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("a) \\rm {\\itU_{\\rm-}} = %1.2f, {\\itU_{\\rm+}} = %1.2f", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
xlim([-10 10]);
ylim([0 3]);
set_format(gca, 'Title');
set_format(gca, 'Y', '%0.1f');
set_format(gca, 'X');
grid on;
box on;

load('../archiwa/rederr_org_1_6.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, false)

subplot(2, 2, 2)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("b) \\rm {\\itU_{\\rm-}} = %1.2f, {\\itU_{\\rm+}} = %1.2f", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
xlim([-10 10]);
ylim([0 3]);
set_format(gca, 'Title');
set_format(gca, 'Y', '%0.1f');
set_format(gca, 'X');
grid on;
box on;

load('../archiwa/rederr_org_1_10.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, false)

subplot(2, 2, 3)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("\nc) \\rm {\\itU_{\\rm-}} = %1.2f, {\\itU_{\\rm+}} = %1.2f", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
xlim([-10 10]);
ylim([0 3]);
set_format(gca, 'Title');
set_format(gca, 'Y', '%0.1f');
set_format(gca, 'X');
grid on;
box on;

load('../archiwa/rederr_org_1_20.txt.gz');
[up, um, s, w] = get_uncertainty(errs, 95, false)

subplot(2, 2, 4)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("\nd) \\rm {\\itU_{\\rm-}} = %1.2f, {\\itU_{\\rm+}} = %1.2f", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
xlim([-10 10]);
ylim([0 3]);
set_format(gca, 'Title');
set_format(gca, 'Y', '%0.1f');
set_format(gca, 'X');
grid on;
box on;

print("../obrazki/hist_redorginal.svg");
