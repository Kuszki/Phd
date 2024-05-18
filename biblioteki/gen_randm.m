function [r] = gen_randm(num, c, u = 1.0, mode = 'u', check = true)

	if length(u) == 1
		u = u * ones(1, length(c));
	end

	if check
		assert(length(c) == length(u), 'c and u must be the same length');
	end

	for i = 1 : length(c)

		switch (c(i))
			case 'u'
				r(i,:) = gen_randu(num, u(i), mode);
			case 'n'
				r(i,:) = gen_randn(num, u(i), mode);
			case 's'
				r(i,:) = gen_rands(num, u(i), mode);
			case 't'
				r(i,:) = gen_randt(num, u(i), mode);
		end

	end

end
