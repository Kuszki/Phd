function draw_wtlevels(wsp, info)

	mag_label = "Wzmocnienie";
	smp_label = "Numer próbki";

	dec_size = size(info.Lc)(1);
	newplot();

	if (iscell(wsp))

		for i = 1 : dec_size

			x = 1 : info.Ls / size(wsp{i})(1) : info.Ls;

			subplot(dec_size, 1, i);
			plot(x, wsp{i});

			xlim([0 info.Ls]);
			ylabel(mag_label);
			xlabel(smp_label);
			title(gen_plot_name(i, dec_size));
			grid on;

		end

	elseif (ismatrix(wsp))

		start = 1;

		for i = 1 : size(info.Lc)(1)

			x = 1 : info.Ls / info.Lc(i) : info.Ls;

			subplot(dec_size, 1, i);
			plot(x, wsp(start : start + info.Lc(i) - 1));

			xlim([0 info.Ls]);
			ylabel(mag_label);
			xlabel(smp_label);
			title(gen_plot_name(i, dec_size));
			grid on;

			start = start + info.Lc(i);

		end

	end

end

function [name] = gen_plot_name(step, count)

	if step == 1

		if count > 2

			name = cstrcat('Aproksymacja sygnału (cA_{', num2str(count - 1), '})');

		else

			name = cstrcat('Aproksymacja sygnału (cA)');

		end

	else

		if count > 2

			name = cstrcat('Szczegóły sygnału (cD_{', num2str(count - step + 1), '})');

		else

			name = cstrcat('Szczegóły sygnału (cD)');

		end

	end

end
