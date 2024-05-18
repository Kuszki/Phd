function [lvls] = get_fwtlevels(n, decn, mode = 'range', check = true)

	if check
		assert(n / 2^decn >= 1, 'too many decomposition levels for given input length');
	end

	lst = n;

	for i = decn+1 : -1 : 2

		n = floor(n / 2);
		lvls(i,:) = [n+1 lst];
		lst = n;

	end

	lvls(1,:) = [1 lst];

	if strcmp(mode, "start")
		for i = 1 : length(lvls)
			n_lvls(i) = lvls(i, 1);
		end
	elseif strcmp(mode, "stop")
		for i = 1 : length(lvls)
			n_lvls(i) = lvls(i, 1);
		end
	elseif strcmp(mode, "midd")
		for i = 1 : length(lvls)
			n_lvls(i,:) = floor(mean(lvls(i,:)));
		end
	elseif strcmp(mode, "list")
		for i = 1 : length(lvls)
			n_lvls(i,:) = lvls(i, 1) : lvls(i, 2);
		end
	end

	if exist("n_lvls")
		lvls = n_lvls;
	end

end

