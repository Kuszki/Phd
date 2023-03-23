clear
clf

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

dat = load("../pomiary/dc.dat");
mns = zeros(1, columns(dat)-1);
dff = zeros(1, columns(dat)-1);

pts = [ 25 : 50 : 975 ];
#pts = [25, 150 : 150 : 3150, 3250];
data = [];

for i = 2 : columns(dat)

	col = dat(:,i);
	mns(i-1) = mean(col);

end

F = [ ones(length(pts), 1), pts(:) ];
P = F \ transpose(mns);

fun = @(x) P(1) + P(2)*x;
fpr = @(x) (x - P(1)) / P(2);

y = fun([0 1000]);
x = [0 fpr(y(2))];

for i = 2 : columns(dat)

	col = dat(:,i) - fun(pts(i-1));
	data = [data; col];

	[u, c, s, w, m] = get_uncertainty(col);
	dff(i-1) = m;

	printf("%d\t%f\t%f\t%f\t%f\t%f\n", pts(i-1), u, c, s, w, m);

end

[u, c, s, w] = get_uncertainty(data)
std(dff)

hold on;
plot(pts, mns, 'x');
plot(x, y);
hold off;

