function y = ltiSolve(A, B, u, x0, t)
    y = zeros(length(x0), length(t));
    for index = 1 : length(t)
      matrixExp = expm(A * t(index));
      y(:, index) = matrixExp * x0 + inv(A) * (matrixExp - eye(size(A))) * B * u;
    endfor  
endfunction