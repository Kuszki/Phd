function [amp] = get_filter_amp(w, model = 1)

	wc = 1079795;

	ka = 0.125;
	kb = 1.789e-6;
	kc = 3.395;

	rin = 1.488e+2;
	cin = 4.780e-10;

	win = (2*pi)/(rin*cin);

	rac = 6e+3;
	cac = 7e-12;

	wac = (2*pi)/(rac*cac);

	out = 1 / sqrt((w ^ 2) ./ (win ^ 2) + 1);
	adc = 1 / sqrt((w ^ 2) ./ (wac ^ 2) + 1);

	if model == 1
		amp = kc - ka*exp(kb*w);
		amp = amp / (kc - ka);
	else
		amp = 1 / sqrt((w ^ 2) ./ (wc ^ 2) + 1);
	end

	amp = amp * out * adc;

end
