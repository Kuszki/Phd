clear;
figure;

sq3 = sqrt(3);

a_S20 = [ (5-sq3), (5+sq3), (3+3*sq3), (5+3*sq3), (3+sq3), (3-sq3), (5-3*sq3), (3-3*sq3) ] / 16;
a_T10 = [ (1-sq3), -(3-sq3), (+3+sq3), -(1+sq3) ] / 4*sqrt(2);

H_S20 = @(x) a_S20(1) + a_S20(2)*e^(-i*x) + a_S20(3)*e^(-2*i*x) + a_S20(4)*e^(-3*i*x) + ...
    a_S20(5)*e^(-4*i*x) + a_S20(6)*e^(-5*i*x) + a_S20(7)*e^(-6*i*x) + a_S20(8)*e^(-7*i*x);
A_S20 = @(x) abs(H_S20(x));

H_T10 = @(x) a_T10(1) + a_T10(2)*e^(-i*x) + a_T10(3)*e^(-2*i*x) + a_T10(4)*e^(-3*i*x);
A_T10 = @(x) abs(H_T10(x));

f = linspace(0, pi, 128);
k_S20 = arrayfun(A_S20, f);
k_T10 = arrayfun(A_T10, f);
f = f / (2*pi);

hold on;
plot(f, k_T10/max(k_T10));
plot(f, k_S20/max(k_S20));

