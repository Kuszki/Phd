clear;
h = figure('visible', ifelse(isguirunning(), 'on', 'off'));

pkg load communications
pkg load ltfat
pkg load parallel
pkg load statistics

addpath("../biblioteki");

set(h, "paperunits", "centimeters")
set(h, "papersize", [8 6])
set(h, "paperposition", [0, 0, [8 6]])

set(0, "defaultaxesposition", [0.185, 0.225, 0.755, 0.705])
set(0, "defaulttextfontsize", 11)
set(0, "defaultaxesfontsize", 11)
set(0, "defaulttextfontname", "Latin Modern Roman")
set(0, "defaultaxesfontname", "Latin Modern Roman")
set(0, "defaulttextcolor", "black")

nbins = 81;

x = gen_randn(1e4, 0.55) + gen_rands(1e4, 0.7);
u = get_uncertainty(x, 95);

[nn, xx] = hist(x, nbins);

n1 = []; x1 = []; i1 = 1;
n2 = []; x2 = []; i2 = 1;

for i = 1 : length(nn)

	if abs(xx(i)) > u
		n1(i1) = nn(i);
		x1(i1) = xx(i);
		i1 = i1 + 1;
	else
		n2(i2) = nn(i);
		x2(i2) = xx(i);
		i2 = i2 + 1;
	end
end

n1(:) = n1(:) / length(x) * 100;
n2(:) = n2(:) / length(x) * 100;

hold on
bar(x1, n1, "hist", "facecolor", 0.6*[1 1 1])
bar(x2, n2, "hist", "facecolor", 0.3*[1 1 1])
hold off
xlabel("Wartość realizacji sygnału błędu")
ylabel("Udział wystąpień, %")
ylim([0 6])
xlim([-2 2])
draw_brace([-u 4.25], [u 4.25], 10, 'Color', 'black');
text(-1.25, 5.25, "$1 - \\alpha$ wszystkich realizacji", "interpreter", "latex")
line([-u -u], [3 0], "color", "black", "linestyle", "--")
text(-u-0.25, 3.5, "−\\itU")
line([u u], [3 0], "color", "black", "linestyle", "--")
text(u-0.25, 3.5, "+\\itU");
set_format(gca, 'Title');
set_format(gca, 'XY');
grid on
box on

print("../obrazki/hist_test.svg");
