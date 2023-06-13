function [w] = get_filter_var(w, amp)

	[a, p] = get_dynparams([-amp amp*get_filter_amp(w)], [0 get_filter_phi(w)]);

	w = (a^2) / 2;

end
