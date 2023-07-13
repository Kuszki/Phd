function [amp] = get_filter_amp(w)

	wac = (2*pi)/(6.0e+3*4.0e-12);
	amp = 1 / sqrt((w ^ 2) ./ (wac ^ 2) + 1);

end
