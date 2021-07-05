model twoPopulationSIR
  discreteSIRimp M1, M2(S.start = M2.N, I.start = 0);
algorithm
  when sample(0, 1) then
    M1.imp := M2.exp;
    M2.imp := M1.exp;
  end when;
annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1));
end twoPopulationSIR;