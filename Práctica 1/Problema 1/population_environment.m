function [time, P] = population_environment(initial_P, b, a, final_time)
%    Argumentos:
%      initial_P: Población inicial.
%      b: Tasa de natalidad.
%      a: Tasa de mortalidad.
%      final_time: Tiempo final de la simulación.
%    Valores de retorno:
%      time: Arreglo de 1 a final_time.
%      P: Arreglo de valores de población en cada unidad de tiempo.
  
    P = zeros(1, final_time);
    P(1) = initial_P;
    for k = 1 : (final_time - 1)
      P(k + 1) = (1 + b - a * P(k)) * P(k);
    endfor
    time = [1 : final_time];
endfunction