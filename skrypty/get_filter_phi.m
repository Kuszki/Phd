function [phi] = get_filter_phi(w)

	wac = (1)/(6.0e+3*7.0e-12);

	phi = -6.76e-13*w^2 - 5.23e-7*w;
	phi = phi + atan(-w/wac);

end
