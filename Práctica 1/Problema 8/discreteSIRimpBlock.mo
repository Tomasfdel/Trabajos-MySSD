model discreteSIRimpBlock
  parameter Real N = 1e6, I0 = 10, alpha = 1, gamma = 0.5, m = 0.01;
  Modelica.Blocks.Math.Product SxI annotation(
    Placement(visible = true, transformation(origin = {-48, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add(k2 = -alpha / N)  annotation(
    Placement(visible = true, transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k1 = +gamma)  annotation(
    Placement(visible = true, transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.UnitDelay S(samplePeriod = 1, y_start = N - I0)  annotation(
    Placement(visible = true, transformation(origin = {50, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.UnitDelay I(samplePeriod = 1, y_start = I0)  annotation(
    Placement(visible = true, transformation(origin = {50, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Discrete.UnitDelay R(samplePeriod = 1, y_start = 0)  annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput imp annotation(
    Placement(visible = true, transformation(origin = {-108, 10}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-98, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Math.Add3 add3(k1 = alpha / N, k3 = 1 - gamma - m)  annotation(
    Placement(visible = true, transformation(origin = {4, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = m)  annotation(
    Placement(visible = true, transformation(origin = {100, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput exp annotation(
    Placement(visible = true, transformation(origin = {140, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(add.y, S.u) annotation(
    Line(points = {{22, 50}, {38, 50}}, color = {0, 0, 127}));
  connect(add2.y, R.u) annotation(
    Line(points = {{22, -30}, {38, -30}}, color = {0, 0, 127}));
  connect(S.y, add.u1) annotation(
    Line(points = {{62, 50}, {80, 50}, {80, 80}, {-20, 80}, {-20, 56}, {-2, 56}}, color = {0, 0, 127}));
  connect(S.y, SxI.u1) annotation(
    Line(points = {{62, 50}, {80, 50}, {80, 80}, {-80, 80}, {-80, 38}, {-60, 38}}, color = {0, 0, 127}));
  connect(I.y, SxI.u2) annotation(
    Line(points = {{62, 10}, {80, 10}, {80, -10}, {-80, -10}, {-80, 26}, {-60, 26}}, color = {0, 0, 127}));
  connect(SxI.y, add.u2) annotation(
    Line(points = {{-37, 32}, {-20, 32}, {-20, 44}, {-2, 44}}, color = {0, 0, 127}));
  connect(R.y, add2.u2) annotation(
    Line(points = {{62, -30}, {80, -30}, {80, -50}, {-20, -50}, {-20, -36}, {-2, -36}}, color = {0, 0, 127}));
  connect(I.y, add2.u1) annotation(
    Line(points = {{62, 10}, {80, 10}, {80, -10}, {-12, -10}, {-12, -24}, {-2, -24}}, color = {0, 0, 127}));
  connect(imp, add3.u2) annotation(
    Line(points = {{-108, 10}, {-8, 10}}, color = {0, 0, 127}));
  connect(add3.y, I.u) annotation(
    Line(points = {{15, 10}, {38, 10}}, color = {0, 0, 127}));
  connect(SxI.y, add3.u1) annotation(
    Line(points = {{-36, 32}, {-20, 32}, {-20, 18}, {-8, 18}}, color = {0, 0, 127}));
  connect(I.y, add3.u3) annotation(
    Line(points = {{62, 10}, {80, 10}, {80, -10}, {-12, -10}, {-12, 2}, {-8, 2}}, color = {0, 0, 127}));
  connect(I.y, gain.u) annotation(
    Line(points = {{62, 10}, {88, 10}}, color = {0, 0, 127}));
  connect(gain.y, exp) annotation(
    Line(points = {{112, 10}, {140, 10}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "3.2.3")),
    experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.1));
end discreteSIRimpBlock;