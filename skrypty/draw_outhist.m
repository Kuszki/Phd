clear;
h = figure;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("~/Projekty/Octave-FWT-Utils")

dim = "-r300";
part = "T";

fcolor = "#333333";
ecolor = "#333333";
nbins = 300;

nr = 2;
nc = 2;
tot = nr*nc;
pos = 1;

set(h, "paperunits", "centimeters")
set(h, "papersize", [16 5.65*nr])
set(h, "paperposition", [0, 0, [16 5.65*nr]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaultaxesfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_static.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_static.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}\n", char('a'+pos-1), u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
#ylim([0 0.7])
#yticks([0 : 0.1 : 0.7])
grid on
box on
pos = pos + 1;
end;

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_dynamic.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_dynamic.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}\n", char('a'+pos-1), u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
#ylim([0 1.2])
#yticks([0 : 0.2 : 1.2])
grid on
box on
pos = pos + 1;
end;

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_random.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_random.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("\n%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}\n", char('a'+pos-1), u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
#ylim([0 1.2])
#yticks([0 : 0.2 : 1.2])
grid on
box on
pos = pos + 1;
end;

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_summary.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_summary.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(sprintf("\n%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}\n", char('a'+pos-1), u, c))
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
#xlim([-s*5 s*5])
#ylim([0 1.2])
#yticks([0 : 0.2 : 1.2])
grid on
box on
pos = pos + 1;
end;

print(sprintf("../obrazki/hist_part_%s.svg", part), "-svgconvert", dim);

