% Simulación del apartado 1.
[t, x] = dtsim(@discrete_seir, [1e6-10, 0, 10, 0], 1, 100);
plot(t, x);
legend("Susceptibles", "Expuestos", "Infectados", "Recuperados");
xlabel("Tiempo");
ylabel("Individuos");