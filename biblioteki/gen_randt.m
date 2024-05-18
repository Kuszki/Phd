function [vect] = gen_randt(n, u = 1.0, mode = 'u', c = 1.900, check = false)

	if check
		assert(n > 0, 'n must be greater than zero');
		assert(u > 0, 'u must be greater than zero');
		assert(c > 0, 'c must be greater than zero');
	end

	vect = (rand(1, n) + rand(1, n)) - 1.0;

	switch (mode)
		case 'w'
			vect = vect * sqrt(u) / 0.4083;
		case 's'
			vect = vect * u / 0.4083;
		otherwise
			vect = vect * u / c / 0.4083;
	end

end
