a = [1 0 0 0 0 -1 0 0 0 0 0 0]; # przyspieszenie
v = [ 0 ]; # predkosc
s = [ 0 ]; # miejsce

dt = 1; # okres probkowania

for i = 1 : length(a)
  v(i+1) = v(i) + a(i)*dt;
  s(i+1) = s(i) + v(i)*dt;
end

subplot(3,1,1);
plot(a);
title("przyspieszenie");
subplot(3,1,2);
plot(v);
title("predkosc");
subplot(3,1,3);
plot(s);
title("przemieszczenie");
