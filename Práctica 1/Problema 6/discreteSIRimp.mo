model discreteSIRimp
  parameter Real N = 1e6, alpha = 1, gamma = 0.5, m = 0.01;
  discrete Real S(start = N - 10), I(start = 10), R, imp, exp;
algorithm
  when sample(0, 1) then
    S := pre(S) - alpha * pre(S) * pre(I) / N;
    I := pre(I) + alpha * pre(S) * pre(I) / N - gamma * pre(I) + pre(imp) - pre(exp);
    R := pre(R) + gamma * pre(I);
    exp:= m * I;
  end when;
end discreteSIRimp;