function [y, av, fv] = gen_sawfun(x, w, a, dc, n = 25)

	y = zeros(1, length(x)) + dc;
	m = (8/(pi^2));

	for i = 0 : n-1

		k = 2*i + 1;

		av(i+1) = amp = m*a*(k^(-2))*((-1)^i);
		fv(i+1) = frq = k*w;

		y = y + amp*sin(frq*x);

	end

end
