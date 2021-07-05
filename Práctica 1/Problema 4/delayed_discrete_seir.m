function x = delayed_discrete_seir(pre_x, t)
%   Argumentos:
%     pre_x: Arreglo con los valores de individuos susceptibles, expuestos, infectados
%            y recuperados en el instante de tiempo anterior.
%            Además, luego van los valores de nuevos expuestos de cada uno de los últimos
%            tR instantes de tiempo, ordenados desde el más reciente en la posición 1,
%            al más antiguo en la última posición.
%     t: Instante de tiempo actual.
%   Valores de retorno:
%     x: Arreglo con los valores de individuos susceptibles, expuestos, infectados
%        y recuperados en el instante de tiempo actual, además del arreglo actualizado de 
%        nuevos expuestos.

%   Parámetros:
%     population: Población total (N).
%     r0: Número reproductivo básico.
%     tI: Tiempo hasta la infección.
%     tR: Tiempo hasta la recuperación.
    population = 1e6;
    r0 = 1.5;
    tI = 3;
    tR = 12;
    
    pre_S = pre_x(1);
    pre_E = pre_x(2);
    pre_I = pre_x(3);
    pre_R = pre_x(4);
    pre_N = pre_x(5 : 5 + tR - 1);
    
    
%   Como el arreglo pre_N está ordenado de más reciente a más antiguuo,
%   el valor correspondiente a NE(t - 1) está en pre_N(1), mientras que
%   NE(t - tI) está en pre_N(tI). Un caso análogo ocurre con pre_N(tR).
    new_exposed = r0 / (tR - tI) * pre_I * pre_S / population;
    S = pre_S - new_exposed;
    E = pre_E + new_exposed - pre_N(tI);
    I = pre_I + pre_N(tI) - pre_N(tR);
    R = pre_R + pre_N(tR);
    
%   Para construir el nuevo arreglo N, ubicamos new_exposed, correspondiente a
%   NE(t), en N(1). El resto de las entradas son los valores de pre_N
%   con un corrimiento de una posición a la derecha.
    N = zeros(1, tR);
    N(1) = new_exposed;
    N(2 : tR) = pre_N(1 : (tR - 1));
        
    x = [S, E, I, R, N];
end