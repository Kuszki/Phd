load kobe

plot((1:numel(kobe))./60,kobe)
xlabel("Czas, min")
ylabel("Przyspieszenie, nm/s^2")
grid on
axis tight
set(gca,'FontSize', 12)
set(gca,'FontName', 'Latin Modern Math')
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 16 8.25])
print('cobe_time','-dsvg')

cwt(kobe, 1)
title("")
xlabel("Czas, min")
ylabel("Częstotliwość, mHz")
set(gca,'FontSize', 12)
set(gca,'FontName', 'Latin Modern Math')
set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 16 8.25])
% print('cobe_cwt','-dsvg')

