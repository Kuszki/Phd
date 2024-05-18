clear;

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");


parts = {"a", "b", "c", "T", "S"};
nrows = [ 2 2 1 2 2 ];
lims = [ ...
	0.8 1.0 1.4 1.2; ...
	0.8 1.0 1.4 1.0; ...
	0.5 1.2 0.5 1.2; ...
	8e0 1.2 1.2 0.8; ...
	0.8 1.2 1.4 1.0; ...
]

ticks = [ ...
	0.2 0.2 0.2 0.2; ...
	0.2 0.2 0.2 0.2; ...
	0.1 0.2 0.1 0.2; ...
	2e0 0.2 0.2 0.2; ...
	0.2 0.2 0.2 0.2; ...
]

fcolor = "#333333";
ecolor = "#333333";
nbins = 300;

for j = 1 : length(parts)

part = parts{j};
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));
nr = nrows(j);
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
title(strrep(sprintf("%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}", char('a'+pos-1), u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
ylim([0 lims(j,pos)]);
yticks([0 : ticks(j,pos) : lims(j,pos)]);
set_comma(gca, 'Y', '%0.1f');
set_comma(gca, 'X');
grid on;
box on;
pos = pos + 1;
end;

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_dynamic.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_dynamic.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}", char('a'+pos-1), u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
ylim([0 lims(j,pos)]);
yticks([0 : ticks(j,pos) : lims(j,pos)]);
set_comma(gca, 'Y', '%0.1f');
set_comma(gca, 'X');
grid on;
box on;
pos = pos + 1;
end;

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_random.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_random.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("\n%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}", char('a'+pos-1), u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
ylim([0 lims(j,pos)]);
yticks([0 : ticks(j,pos) : lims(j,pos)]);
set_comma(gca, 'Y', '%0.1f');
set_comma(gca, 'X');
grid on;
box on;
pos = pos + 1;
end;

if pos <= tot && exist(sprintf("../archiwa/simulation_%s_summary.txt.gzip", part))
load(sprintf("../archiwa/simulation_%s_summary.txt.gzip", part))
errs = errs * 1000;

[u, c, s, w] = get_uncertainty(errs)

subplot(nr, nc, pos)
hist(errs, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("\n%s) \\rm\\it U{\\rm = %0.2f mV}, c{\\rm = %1.2f}", char('a'+pos-1), u, c), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, mV");
ylim([0 lims(j,pos)]);
yticks([0 : ticks(j,pos) : lims(j,pos)]);
set_comma(gca, 'Y', '%0.1f');
set_comma(gca, 'X');
grid on;
box on;
pos = pos + 1;
end;

print(sprintf("../obrazki/hist_part_%s.svg", part));

end
