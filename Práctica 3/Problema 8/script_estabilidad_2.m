% Gráfico de los autovalores en función del largo de paso con b = 0.
1;
function y = discrete_A(h, A)
   y = eye(2) + h * A + 0.5 * (h * A)**2; 
endfunction

m = 1;
k = 1;
b = 0;
F = 1;
A = [0, 1; -k / m, -b / m];

h_list = 0.01: 0.01: 0.2;
norms = zeros(2, length(h_list));
for h_index = 1: length(h_list)
  norms(:, h_index) = abs(eig(discrete_A(h_list(h_index), A)));
endfor

plot(h_list, norms(1, :), h_list, norms(2, :));
line ([0 0.2], [1 1], "linestyle", "-", "color", "b");
xlabel("h");
ylabel("λ");
title("b = 0");