function [a] = get_rowcoef(wsp, i, mode)

	mode = strcmp(mode, 'r');

	if isvector(wsp)

		if mode
			a = sqrt(sum(wsp.^2));
		else
			a = sum(wsp);
		end

	elseif is_matrix(i)

		for j = 1 : length(i)

			if mode
				a(j) = sqrt(sum(wsp(i(j),:).^2));
			else
				a(j) = sum(wsp(i(j),:));
			end

		end

	else

		if mode
			a = sqrt(sum(wsp(i,:).^2));
		else
			a = sum(wsp(i,:));
		end

	end

end
