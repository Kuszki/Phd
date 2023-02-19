clear;
clc;
clf;

pkg load communications;
pkg load ltfat;
pkg load parallel;
pkg load signal;

addpath("~/Projekty/Octave-FWT-Utils");

pul = linspace(1, 2, 256);
shf = linspace(0, 180, 256);
out = zeros(1, length(shf));

for i = 1 : length(out)
  out(i) = get_sin_corr(1, 2, 0, shf(i));
end

plot(shf, out);

ylabel("Corelation factor");
xlabel("Frequency ratio {f_{i}} / {f_{j}}");
xlim([min(shf) max(shf)]);
grid on;

#pul = linspace(1, 2.5, 64);
#shf = linspace(0, 180, 128);
#out = zeros(length(pul), length(shf));
#
#for i = 1 : length(pul)
#  for j = 1 : length(shf)
#    out(i,j) = get_sin_corr(1, pul(i), 0, shf(j));
#  end
#end
#
#mesh(shf, pul, out)
#ylabel("pul");
#xlabel("shf");
#zlabel("out");

