function [out] = fwt_denoise(wsp, info, type = 'hard')

	lmb = sqrt(2*log(info.Ls)) * median(abs(wsp(info.Lc(info.J + 1) : length(wsp)))) / 0.6745;
	out = wsp;

	if strcmp(type, 'hard')

		parfor i = 1 : info.Ls

			if abs(out(i)) <= lmb

				out(i) = 0;

			end

		end

	else

		for i = 1 : info.Ls

			out(i) = sign(out(i)) * max(0, abs(out(i)) - lmb);

		end

	end

end
