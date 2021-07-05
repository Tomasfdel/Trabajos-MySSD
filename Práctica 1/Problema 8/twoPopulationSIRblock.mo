model twoPopulationSIRblock
  discreteSIRimpBlock Poblacion1 annotation(
    Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  discreteSIRimpBlock Poblacion2(I0 = 0)  annotation(
    Placement(visible = true, transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Poblacion1.exp, Poblacion2.imp) annotation(
    Line(points = {{-20, 10}, {20, 10}}, color = {0, 0, 127}));
  connect(Poblacion2.exp, Poblacion1.imp) annotation(
    Line(points = {{40, 10}, {60, 10}, {60, -20}, {-60, -20}, {-60, 10}, {-40, 10}}, color = {0, 0, 127}));
annotation(
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1));
end twoPopulationSIRblock;