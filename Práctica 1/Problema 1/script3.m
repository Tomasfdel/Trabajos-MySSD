% Población con limitaciones ambientales y vaor inicial mayor a 10.
[time, P] = population_environment(14, 0.1, 0.01, 100);
plot(time, P);
ylim([0, 15]);
xlabel("Tiempo");
ylabel("Población");