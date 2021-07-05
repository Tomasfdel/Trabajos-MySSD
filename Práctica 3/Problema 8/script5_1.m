% Simulación con h = 0.1.
1;
% Cálculo con Heun.
function dx = resorte(x, t)
  m = 1;
  k = 1;
  b = 1;
  F = 1;
  
  dx1 = x(2);
  dx2 = -k/m * x(1) - b * m * x(2) + F/m;
  dx = [dx1; dx2];
endfunction

x0 = [0; 0];
t0 = 0;
tf = 50;
h = 0.1;
[t, heun_y] = heun(@resorte, x0, t0, tf, h);


% Solución analítica.
m = 1;
k = 1;
b = 1;
F = 1;
A = [0, 1; -k / m, -b * m];
B = [0; F / m];
u = 1;
analytic_y = ltiSolve(A, B, u, x0, t);


% Errores.
error_primer_paso = norm(heun_y(:, 2) - analytic_y(:, 2), 1)
error_maximo = norm(heun_y - analytic_y, 1)