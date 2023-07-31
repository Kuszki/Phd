function [phi] = get_filter_phi(w)

	wac = (2*pi)/(6.0e+3*7.0e-12);

	phi = -6.821e-13*w^2 - 5.462e-7*w;
	phi = phi + atan(-w/wac);

end
