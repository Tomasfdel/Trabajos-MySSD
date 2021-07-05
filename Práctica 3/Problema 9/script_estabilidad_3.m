% Gráfico de los autovalores en función del largo de paso con b = 10.
1;
function y = discrete_A(h, A)
   y = inv(eye(2) - 0.5 * h * A) * (eye(2) + 0.5 * h * A);
endfunction

m = 1;
k = 1;
b = 10;
F = 1;
A = [0, 1; -k / m, -b / m];

h_list = 0.1: 0.1: 100;
norms = zeros(2, length(h_list));
for h_index = 1: length(h_list)
  norms(:, h_index) = abs(eig(discrete_A(h_list(h_index), A)));
endfor

plot(h_list, norms(1, :), h_list, norms(2, :));
line ([0 100], [1 1], "linestyle", "-", "color", "b");
ylim([0, 1.5]);
xlabel("h");
ylabel("λ");
title("b = 10");