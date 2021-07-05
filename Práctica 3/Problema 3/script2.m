% Primera simulación del apartado 2.
m = 1;
k = 1;
b = 0;
F = 1;

A = [0, 1; -k / m, -b / m];
B = [0; F / m];
x0 = [0; 0];
u = 1;
time = 0:0.5:50;
y = ltiSolve(A, B, u, x0, time);
plot(time, y(1, :), time, y(2, :));
title("b = 0");
xlabel("Tiempo");
ylabel("Variables de estado");
legend("Posición", "Velocidad");