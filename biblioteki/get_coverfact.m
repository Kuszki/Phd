function [c] = get_coverfact(cv)

	for i = 1 : length(cv)
		switch cv(i)
			case 'n'
				c(i) = 1.96;
			case 'u'
				c(i) = 1.65;
			case 't'
				c(i) = 1.90;
			case 's'
				c(i) = 1.41;
			case 'r'
				c(i) = 2.16;
			otherwise
				c(i) = 0.00;
		end
	end

end
