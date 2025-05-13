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
set(h, "papersize", [16 6])
set(h, "paperposition", [0, 0, [16 6]])

set(0, "defaultaxesposition", [0.085, 0.11, 0.885, 0.865])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

files = glob('../archiwa/rederr_all_*_*_1_*.txt.gz');

for i = 1 : numel(files)

[~, prefix] = fileparts(files{i});
[~, prefix] = fileparts(prefix);

load(files{i});

[up, um, s, w, m] = get_uncertainty(errs_a, 95, false)

subplot(1, 3, 1)
hist(errs_a, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("{\\bfa)}\\rm {\\itU_{\\delta}} = [%0.2f; %0.2f] %%", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
#xlim([-10 10]);
#ylim([0 3]);
set_format(gca, 'Title', true);
set_format(gca, 'Y', true, '%0.1f');
set_format(gca, 'X', true);
grid on;
box on;

[up, um, s, w, m] = get_uncertainty(errs_b, 95, false)

subplot(1, 3, 2)
hist(errs_b, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("{\\bfb)}\\rm {\\itU_{\\delta}} = [%0.2f; %0.2f] %%", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
#xlim([-10 10]);
#ylim([0 3]);
set_format(gca, 'Title', true);
set_format(gca, 'Y', true, '%0.1f');
set_format(gca, 'X', true);
grid on;
box on;

[up, um, s, w, m] = get_uncertainty(errs_c, 95, false)

subplot(1, 3, 3)
hist(errs_c, nbins, 100, "facecolor", fcolor, "edgecolor", ecolor)
title(strrep(sprintf("{\\bfc)}\\rm {\\itU_{\\delta}} = [%0.2f; %0.2f] %%", um, up), '.', ','));
ylabel("Udział wystąpień, %");
xlabel("Wartość błędu, %");
#xlim([-10 10]);
#ylim([0 3]);
set_format(gca, 'Title', true);
set_format(gca, 'Y', true, '%0.1f');
set_format(gca, 'X', true);
grid on;
box on;

print(sprintf("../obrazki/hist_%s.svg", prefix));
clear("errs_a", "errs_b", "errs_c");

end

