function x = discrete_seir(pre_x, t)
%    Argumentos:
%      pre_x: Arreglo con los valores de individuos susceptibles, expuestos, infectados
%             y recuperados en el instante de tiempo anterior.
%      t: Instante de tiempo actual.
%    Valores de retorno:
%      x: Arreglo con los valores de individuos susceptibles, expuestos, infectados
%      y recuperados en el instante de tiempo actual.

%    Parámetros:
%      N: Población total.
%      al: Tasa de contacto (alfa).
%      gam: Tasa de recuperación (gamma).  
%      mu: Tasa de infección. 
    N = 1e6;
    al = 1;
    gam  = 0.5;
    mu = 0.5;
    
    pre_S = pre_x(1);
    pre_E = pre_x(2);
    pre_I = pre_x(3);
    pre_R = pre_x(4);
    
    S = pre_S - al * pre_S * pre_I / N;
    E = pre_E + al * pre_S * pre_I / N - mu * pre_E;
    I = pre_I + mu * pre_E - gam * pre_I;
    R = pre_R + gam * pre_I;
    x = [S; E; I; R];
end