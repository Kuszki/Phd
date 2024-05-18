function [vect] = gen_rands(n, u = 1.0, mode = 'u', c = 1.415, check = false)

	if check
		assert(n > 0, 'n must be greater than zero');
		assert(u > 0, 'u must be greater than zero');
		assert(c > 0, 'c must be greater than zero');
	end

	vect = (rand(1, n) - 0.5) * 6.2832;

	switch (mode)
		case 'w'
			vect = sin(vect) * sqrt(u) * 1.415;
		case 's'
			vect = sin(vect) * u * 1.415;
		otherwise
			vect = sin(vect) * u * c / 1.415;
	end

end
