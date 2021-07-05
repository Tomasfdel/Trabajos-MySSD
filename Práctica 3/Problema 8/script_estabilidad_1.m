% Gráfico de los autovalores en función del largo de paso con b = 1.
1;
function y = discrete_A(h, A)
   y = eye(2) + h * A + 0.5 * (h * A)**2; 
endfunction

m = 1;
k = 1;
b = 1;
F = 1;
A = [0, 1; -k / m, -b / m];

h_list = 0.1: 0.1: 3;
norms = zeros(2, length(h_list));
for h_index = 1: length(h_list)
  norms(:, h_index) = abs(eig(discrete_A(h_list(h_index), A)));
endfor

plot(h_list, norms(1, :), h_list, norms(2, :));
line ([0 3], [1 1], "linestyle", "-", "color", "b");
ylim([0, 3]);
xlabel("h");
ylabel("λ");
title("b = 1");