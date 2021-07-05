function [time, S, I, R] = discrete_sir(initial_S, initial_I, initial_R, final_time)
%    Argumentos:
%      initial_S: Individuos susceptibles iniciales.
%      initial_I: Individuos infectados iniciales.
%      initial_R: Individuos recuperados iniciales.
%      final_time: Tiempo final de la simulación.
%    Valores de retorno:
%      time: Arreglo de 1 a final_time.
%      S: Arreglo de valores de individuos susceptibles en cada unidad de tiempo.
%      I: Arreglo de valores de individuos infectados en cada unidad de tiempo.
%      R: Arreglo de valores de individuos recuperados en cada unidad de tiempo.

%    Parámetros:
%      population: Población total (N).
%      contact_rate: Tasa de contacto (alfa).
%      recovery_rate: Tasa de recuperación (gamma).  
    population = 1e6;
    contact_rate = 1;
    recovery_rate = 0.5;
  
    time = [1 : final_time];
    S = zeros(1, final_time);
    I = zeros(1, final_time);
    R = zeros(1, final_time);
    
    S(1) = initial_S;
    I(1) = initial_I;
    R(1) = initial_R;
    
    for k = 1 : (final_time - 1)
      S(k + 1) = S(k) - contact_rate * S(k) * I(k)/population;
      I(k + 1) = I(k) + contact_rate * S(k) * I(k)/population - recovery_rate * I(k);
      R(k + 1) = R(k) + recovery_rate * I(k);
    endfor
    
endfunction