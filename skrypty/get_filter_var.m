function [w, wv, av, pv] = get_filter_var(w, amp)

	assert(length(w) == length(amp), "vectors must be the same length");

	for i = 1 : length(w)

		if w(i) > pi*48000; continue; end;

		[a, p] = get_dynparams([-amp(i) amp(i)*get_filter_amp(w(i))], [0 get_filter_phi(w(i))]);

		wv(i) = (a^2) / 2;
		av(i) = a;
		pv(i) = p;

	end

	w = sum(wv);

end
