function [vect] = gen_randu(n, u = 1.0, mode = 'u', c = 1.650, check = false)

	if check
		assert(n > 0, 'n must be greater than zero');
		assert(u > 0, 'u must be greater than zero');
		assert(c > 0, 'c must be greater than zero');
	end

	vect = rand(1, n) - 0.5;

	switch (mode)
		case 'w'
			vect = vect * sqrt(u) / 0.2887;
		case 's'
			vect = vect * u / 0.2887;
		otherwise
			vect = vect * u / c / 0.2887;
	end

end
