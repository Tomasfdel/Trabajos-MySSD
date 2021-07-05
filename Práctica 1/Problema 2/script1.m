% Simulación del apartado 1.
[t, S, I, R] = discrete_sir(1e6-10, 10, 0, 50);
plot(t, S, t, I, t, R);
legend("Susceptibles", "Infectados", "Recuperados");
xlabel("Tiempo");
ylabel("Individuos");