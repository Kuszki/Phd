function [phi] = get_filter_phi(w)

	pa = -1.70052e-30;
	pb = 6.51751e-24;
	pc = -7.93226e-18;
	pd = 2.92126e-12;
	pe = -6.92367e-07;

	phi = pa*w^5 + pb*w^4 + pc*w^3 + pd*w^2 + pe*w;

end
