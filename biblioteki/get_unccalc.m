function [u, c, s, w, h] = get_unccalc(uv, cv, mode = 'u')

	assert(length(uv) == length(cv), 'cv and uv must be the same length');

	kv = get_coverfact(cv);

	if strcmp(mode, 'w')
		uv = kv .* sqrt(uv);
	elseif strcmp(mode, 's')
		uv = kv .* uv;
	end

	h = get_cohermatrix(cv, uv);
	u = sqrt(uv*h*transpose(uv));
	w = sum((uv ./ kv).^2);
	s = sqrt(w);
	c = u / s;

end
