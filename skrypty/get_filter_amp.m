function [amp] = get_filter_amp(w)

	ka = 0.125;
	kb = 1.789e-6;
	kc = 3.395;

	amp = kc - ka*exp(kb*w);
	amp = amp / (kc - ka);

end
