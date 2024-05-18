function [r] = get_pearcorr(w12, w1, w2)

	r = (w12 - w1 - w2) / (2*sqrt(w1)*sqrt(w2));

end
