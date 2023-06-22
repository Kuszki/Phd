function [amp] = get_filter_amp(w)

	rin = 1.0e+2;
	cin = 4.8e-10;

	win = (2*pi)/(rin*cin);

	rac = 6.0e+3;
	cac = 4.0e-12;

	wac = (2*pi)/(rac*cac);

	out = 1 / sqrt((w ^ 2) ./ (win ^ 2) + 1);
	adc = 1 / sqrt((w ^ 2) ./ (wac ^ 2) + 1);

	amp = out * adc;
	amp = 1;

end
