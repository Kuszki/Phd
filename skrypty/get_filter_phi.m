function [phi] = get_filter_phi(w)

	rin = 1.0e+2;
	cin = 4.8e-10;

	win = (2*pi)/(rin*cin);

	rac = 6.0e+3;
	cac = 7.0e-12;

	wac = (2*pi)/(rac*cac);

	phi = -6.215e-14*w^2-4.325e-7*w;
	phi = phi + 0*atan(-w/win) + atan(-w/wac);

end
