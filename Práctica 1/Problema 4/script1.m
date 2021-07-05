% Simulación del apartado 2.
[t, x] = dtsim(@delayed_discrete_seir, [1e6-10, 0, 10, 0, zeros(1, 12)], 1, 300);
plot(t, x(1:4, :));
legend("Susceptibles", "Expuestos", "Infectados", "Recuperados");