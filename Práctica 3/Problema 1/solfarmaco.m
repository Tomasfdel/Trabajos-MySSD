function y = solfarmaco(a, x0, t)
    y = zeros(1, length(t));
    for index = 1 : (length(t))
      y(index) = exp(-a * t(index)) * x0;
    endfor  
endfunction