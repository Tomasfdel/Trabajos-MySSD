model threePopulationSIR
  discreteSIRimp M1, M2(S.start = M2.N, I.start = 0), M3(S.start = M3.N, I.start = 0);
algorithm
  when sample(0, 1) then
    M1.imp := M2.exp / 2;
    M2.imp := M1.exp + M2.exp;
    M3.imp := M2.exp / 2;
  end when;
annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1));
end threePopulationSIR;