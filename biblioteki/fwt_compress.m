function [data] = fwt_compress(tab, samples)

	assert(ismatrix(tab), 'tab must be a matrix');
	assert(samples > 0, 'samples must be greater than zero');
	assert(samples < length(tab), 'samples must by less then tab size');

	sorted = sort(abs(tab), 'descend');
	min = sorted(samples + 1);
	count = 0;

	data = zeros(1, length(tab));

	for i = 1 : length(tab)

		if count < samples && abs(tab(i)) > min

			data(i) = tab(i);
			count = count + 1;

		end

	end

end
