% Simulación con b = 0.
1;
function dx = resorte(x, t)
  m = 1;
  k = 1;
  b = 0;
  F = 1;
  
  dx1 = x(2);
  dx2 = -k/m * x(1) - b * m * x(2) + F/m;
  dx = [dx1; dx2];
endfunction


x0 = [0; 0];
t0 = 0;
tf = 100;
reltol = 1e-3;
abstol = 1e-6;
[t, y] = traprulevs(@resorte, x0, t0, tf, reltol, abstol);

subplot (2, 1, 1)
plot(t, y(1, :), t, y(2, :));
title("b = 0");
xlabel("Tiempo");
ylabel("Variables de estado");
subplot (2, 1, 2)
plot(t(1: length(t) - 1), diff(t));
xlabel("Tiempo");
ylabel("Longitud de paso");
