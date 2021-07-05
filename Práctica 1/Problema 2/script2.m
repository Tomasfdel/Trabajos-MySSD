% Simulación del apartado 2.
[t, x] = dtsim(@discrete_sir_2, [1e6-10, 10, 0], 1, 50);
plot(t, x);
legend("Susceptibles", "Infectados", "Recuperados");
xlabel("Tiempo");
ylabel("Individuos");