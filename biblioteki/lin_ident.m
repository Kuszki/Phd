function [wsp] = lin_ident(f, n, parallel = "auto")

	if strcmp(parallel, "auto")
		parallel = n > 128;
	end

	if parallel

		col = f(gen_ones(n, 1));
		len = length(col);

		fun = @(i) f(gen_ones(n, i));
		par = pararrayfun(nproc, fun, 2:n, 'UniformOutput', false);

		wsp = zeros(len, n);
		wsp(:,1) = col;

		parfor i = 2 : n

			wsp(:,i) = cell2mat(par(i-1));

		end

	else

		col = f(gen_ones(n, 1));
		len = length(col);

		wsp = zeros(len, n);
		wsp(:,1) = col;

		for i = 2 : n

			wsp(:,i) = f(gen_ones(n, i));

		end

	end

end
