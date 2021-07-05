% Simulación con b = 0.
1;
function dx = resorte(x, t)
  m = 1;
  k = 1;
  b = 0;
  F = 1;
  
  dx1 = x(2);
  dx2 = -k/m * x(1) - b / m * x(2) + F/m;
  dx = [dx1; dx2];
endfunction

x0 = [0; 0];
t0 = 0;
tf = 100;
h = 0.01;
[t, y] = feuler(@resorte, x0, t0, tf, h);
plot(t, y(1, :), t, y(2, :));