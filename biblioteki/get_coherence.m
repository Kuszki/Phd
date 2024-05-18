function [h, s, k1, k2] = get_coherence(c1, c2, n1 = 0, n2 = 0, uv = [], check = true)

	if check
		assert(n1 + n2 == 0 || n1 + n2 >= 2, 'all or noone indexes must be zero given');
		assert(n1 >= 0 && n1 <= length(uv), 'index n1 must be in range of uncertainty vector');
		assert(n2 >= 0 && n2 <= length(uv), 'index n2 must be in range of uncertainty vector');
	end

	if n1 == n2 && n1 != 0; h = s = k1 = k2 = 1.0;
	else

		if !length(uv); k1 = k2 = 1.0;
		elseif uv(n1) == 0.0 || uv(n2) == 0; k1 = k2 = 0.0;
		else

			u1 = uv(n1); u2 = uv(n2);

			k1 = (u1^2 + u2^2) / sum(uv .^ 2);
			k2 = sqrt(min(u1, u2) / max(u1, u2));

		end

		s = get_shapefact(c1, c2);
		h = s * abs(k1) * abs(k2);

	end

end

