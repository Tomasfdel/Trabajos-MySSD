% Segunda simulación.
1;
function dx = resorte(x, t)
  m = 1;
  k = 1;
  b = 1;
  F = 1;
  
  dx1 = x(2);
  dx2 = -k/m * x(1) - b / m * x(2) + F/m;
  dx = [dx1; dx2];
endfunction

x0 = [0; 0];
t0 = 0;
tf = 30;
h = 0.1;
[t, y] = feuler(@resorte, x0, t0, tf, h);
plot(t, y(1, :), t, y(2, :));
title("Masa-Resorte");
xlabel("Tiempo");
ylabel("Variables de estado");
legend("Posición", "Velocidad");