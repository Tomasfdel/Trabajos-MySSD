% Simulación del apartado 1.
A = [0, 1; -1, -1];
B = [0; 1];
x0 = [0; 0];
u = 1;
time = 0:0.5:30;
y = ltiSolve(A, B, u, x0, time);
plot(time, y(1, :), time, y(2, :));
xlabel("Tiempo");
ylabel("Función");