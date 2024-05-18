function [h, r] = gen_coherence(p1, p2, c1, c2, mode = 'u', num = 1e6)

	assert(sum(c1 == "nuts") == 1, 'c1 must be "n", "u", "t" or "s"');
	assert(sum(c2 == "nuts") == 1, 'c2 must be "n", "u", "t" or "s"');

	switch (c1)
		case 'n'
			x1 = gen_randn(num, p1, mode);
		case 'u'
			x1 = gen_randu(num, p1, mode);
		case 's'
			x1 = gen_rands(num, p1, mode);
		case 't'
			x1 = gen_randt(num, p1, mode);
	end

	switch (c2)
		case 'n'
			x2 = gen_randn(num, p2, mode);
		case 'u'
			x2 = gen_randu(num, p2, mode);
		case 's'
			x2 = gen_rands(num, p2, mode);
		case 't'
			x2 = gen_randt(num, p2, mode);
	end

	[h, r] = get_corelation(x1, x2, false);

end

