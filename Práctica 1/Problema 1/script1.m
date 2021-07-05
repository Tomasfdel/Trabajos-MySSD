% Simulación del apartado 2.
[time, P] = population(1, 0.1, 0.02, 100);
plot(time, P);
xlabel("Tiempo");
ylabel("Población");