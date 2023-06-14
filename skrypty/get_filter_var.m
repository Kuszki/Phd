function [w, wv] = get_filter_var(w, amp)

	assert(length(w) == length(amp), "vectors must be the same length");

	for i = 1 : length(w)

		[a, p] = get_dynparams([-amp(i) amp(i)*get_filter_amp(w(i))], [0 get_filter_phi(w(i))]);
		wv(i) = (a^2) / 2;

	end

	w = sum(wv);

end
