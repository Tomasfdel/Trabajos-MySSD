% Simulación del apartado 3.
a = 1;
x0 = 1;
time = 0:0.5:10;
concentration = solfarmaco(a, x0, time);
plot(time, concentration);
xlabel("Tiempo");
ylabel("Concentración");
