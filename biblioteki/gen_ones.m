function [vect] = gen_ones(n, x)

	assert(n > 0, 'n must be greater than zero');
	assert(x <= n, 'x must be less or equal n');

	vect = zeros(1, n);
	vect(x) = 1.0;

end
