model delayedDiscreteSEIR
  parameter Real N = 1e6, R0 = 1.5;
  parameter Integer infection_time = 3, recovery_time = 12;
  discrete Real S(start = N-10), E, I(start = 10), R, Ne[recovery_time], new_exposed;
algorithm
  when sample(0, 1) then
    new_exposed := R0 / (recovery_time - infection_time) * I * S / N;
    S := pre(S) - new_exposed;
    E := pre(E) + new_exposed - pre(Ne[infection_time]);
    I := pre(I) + pre(Ne[infection_time]) - pre(Ne[recovery_time]);
    R := pre(R) + pre(Ne[recovery_time]);
    Ne[1] := new_exposed;
    Ne[2 : recovery_time] := pre(Ne[1 : (recovery_time - 1)]);        
  end when;
annotation(
    experiment(StartTime = 0, StopTime = 300, Tolerance = 1e-6, Interval = 0.1));
end delayedDiscreteSEIR;