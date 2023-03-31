clear
clf

pkg load communications
pkg load ltfat
pkg load parallel
pkg load optim

addpath("~/Projekty/Octave-FWT-Utils");

list = glob("../pomiary/dc/*.txt");
mns = zeros(1, length(list));
dff = zeros(1, length(list));

data = [];
pts = [];

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1});
	dat = load("-ascii", fname);

	mns(i) = mean(dat);
	pts(i) = vcc;

end

F = [ ones(length(pts), 1), pts(:) ];
P = F \ transpose(mns);

fun = @(x) P(1) + P(2)*x;
fpr = @(x) (x - P(1)) / P(2);

y = fun([0 max(pts)]);
x = [0 fpr(y(2))];

for i = 1 : length(list)

	fname = list{i,1};
	[s, e, te, m, t] = regexp(fname, "(\\d+(?:\\.\\d+)?)");
	vcc = str2num(t{1}{1});
	dat = load("-ascii", fname);

	dat = dat - fun(vcc);
	data = [data; dat];

	[u, c, s, w, m] = get_uncertainty(dat);
	dff(i) = m;

end

[u, c, s, w] = get_uncertainty(data)
std(dff)

hold on;
plot(pts, mns, 'x');
plot(x, y);
hold off;

