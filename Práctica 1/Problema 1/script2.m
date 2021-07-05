% Simulación del apartado 4.
[time, P] = population_environment(1, 0.1, 0.01, 100);
plot(time, P);
ylim([0, 15]);
xlabel("Tiempo");
ylabel("Población");
