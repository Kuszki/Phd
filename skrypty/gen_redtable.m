clear

pkg load communications
pkg load ltfat
pkg load parallel

addpath("../biblioteki");
warning('off', 'Octave:data-file-in-path');

u = [ 3 6 10 20 ];
m = { 'mod', 'org' };

for i = 1 : length(m)

	printf("%s", m{i});

	for j = u

		load(sprintf('../archiwa/rederr_%s_1_%d.txt.gz', m{i}, j));
		[up, um] = get_uncertainty(errs, 95, 'd');

		printf(" & %0.2f & %0.2f", um, up);

	end

	printf(" \\\\ \\hline\n");

end

