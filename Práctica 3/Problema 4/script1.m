% Primera simulación.
1;
function dx = farmaco(x, t)
  a = 1;
  dx = -a * x;
endfunction

x0 = 1;
t0 = 0;
tf = 10;
h = 0.1;
[t, y] = feuler(@farmaco, x0, t0, tf, h);
plot(t, y);
title("Absorción de fármaco")
xlabel("Tiempo")
ylabel("Concentración")