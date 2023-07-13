function [phi] = get_filter_phi(w)

	wac = (2*pi)/(6.0e+3*7.0e-12);

	phi = 1.995e-17*w^3 - 3.118e-12*w^2 - 5.029e-7*w;
	phi = phi + atan(-w/wac);

end
