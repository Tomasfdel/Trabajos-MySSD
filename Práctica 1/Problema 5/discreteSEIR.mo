model discreteSEIR
  parameter Real N = 1e6, alpha = 1, gamma = 0.5, mu = 0.5;
  discrete Real S(start = N-10), E, I(start = 10), R;
algorithm
  when sample(0, 1) then
    S := pre(S) - alpha * pre(S) * pre(I) / N;
    E := pre(E) + alpha * pre(S) * pre(I) / N - mu * pre(E);
    I := pre(I) + mu * pre(E) - gamma * pre(I);
    R := pre(R) + gamma * pre(I);
  end when;
annotation(
    experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-6, Interval = 0.1));
end discreteSEIR;