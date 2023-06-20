function [phi] = get_filter_phi(w, model = 1)

	wc = 1079795;

	pa = 0; #-1.70052e-30;
	pb = 0; #6.51751e-24;
	pe              = -4.3042e-07;#      +/- 5.423e-09    (1.26%)
	pd              = 2.12031e-13;#      +/- 5.655e-14    (26.67%)
	pc              = -7.55523e-19;#     +/- 1.365e-19    (18.07%)


	rin = 1.488e+2;
	cin = 4.780e-10;

	win = (2*pi)/(rin*cin);

	rac = 6e+3;
	cac = 7e-12;

	wac = (2*pi)/(rac*cac);

	if model == 1
		#phi = pa*w^5 + pb*w^4 + pc*w^3 + pd*w^2 + pe*w;
		phi = -4.20146e-07*w;
	else
		phi = atan(-w/wc);
	end


	phi = phi + atan(-w/win) + atan(-w/wac);


end
