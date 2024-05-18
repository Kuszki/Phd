function [vect] = gen_randn(n, u = 1.0, mode = 'u', c = 1.960, check = false)

	if check
		assert(n > 0, 'n must be greater than zero');
		assert(u > 0, 'u must be greater than zero');
		assert(c > 0, 'c must be greater than zero');
	end

	vect = randn(1, n);

	switch (mode)
		case 'w'
			vect = vect * sqrt(u);
		case 's'
			vect = vect * u;
		otherwise
			vect = vect * u / c;
	end

end
