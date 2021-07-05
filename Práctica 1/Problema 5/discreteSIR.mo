model discreteSIR
  parameter Real N = 1e6, alpha = 1, gamma = 0.5;
  discrete Real S(start = N-10), I(start = 10), R;
algorithm
  when sample(0, 1) then
    S := pre(S) - alpha * pre(S) * pre(I) / N;
    I := pre(I) + alpha * pre(S) * pre(I) / N - gamma * pre(I);
    R := pre(R) + gamma * pre(I);
  end when;
annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1));
end discreteSIR;