package TPModelica
  package Electrical
    type Voltage = Real(unit = "V");
    type Current = Real(unit = "A");

    connector Pin
      Voltage v;
      flow Current i;
    end Pin;

    model ConstVoltage
      Pin p, n;
      parameter Voltage V = 1;
    equation
      p.v - n.v = V;
      p.i + n.i = 0;
    end ConstVoltage;

    model Ground
      Pin p;
    equation
      p.v = 0;
    end Ground;

    partial model OnePort
      Pin p, n;
      Voltage v;
      Current i;
    equation
      v = p.v - n.v;
      i = p.i;
      i = -n.i;
    end OnePort;

    model Resistor
      extends Electrical.OnePort;
      parameter Real R = 1;
    equation
      v = R * i;
    end Resistor;

    model Inductor
      extends Electrical.OnePort;
      parameter Real L = 1;
    equation
      v = L * der(i);
    end Inductor;

    model RLOpen
      ConstVoltage va(V = 12);
      Resistor ra(R = 1);
      Inductor la(L = 0.001);
      Ground gr;
    equation
      connect(va.p, ra.p);
      connect(ra.n, la.p);
      connect(gr.p, va.n);
    end RLOpen;
  
    model RL
      extends Electrical.RLOpen;
    equation
      connect(la.n, gr.p);
      annotation(
        experiment(StartTime = 0, StopTime = 0.05, Tolerance = 1e-6, Interval = 0.0001));
    end RL;
    
  end Electrical;

  package Rotational
    type Torque = Real(unit="N.m");
    type Angle = Real(unit="rad");
    type AngSpeed = Real(unit="rad/s");
    
    connector Flange
      Angle th;
      flow Torque tau;
    end Flange;
    
    model Inertia
      Flange flange;
      AngSpeed w;
      parameter Real J = 1;
    equation
      J * der(w) = flange.tau;
      der(flange.th) = w;
    end Inertia;
    
    model Friction
      Flange flange;
      AngSpeed w;
      parameter Real b = 1;
    equation
      flange.tau = b * w;
      der(flange.th) = w;
    end Friction;
  
    model ConstTorque
      Flange flange;
      parameter Torque Tau = 1;
    equation
      flange.tau = -Tau;
    end ConstTorque;
  
    model FricInertia
      Inertia inertia;
      Friction friction;
    equation
      connect(inertia.flange, friction.flange);
    end FricInertia;
    
    model FricInertiaTau
      extends Rotational.FricInertia;
      ConstTorque const_torque;
    equation
      connect(inertia.flange, const_torque.flange);
    annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.02));end FricInertiaTau;
  
  end Rotational;

  package ElectroMec
  
    model ElMecConv
      extends Electrical.OnePort;
      Rotational.Flange flange;
      Rotational.AngSpeed w;
      parameter Real K = 1;
    equation
      flange.tau = -K * i;
      v = K * w;
      der(flange.th) = w;
    end ElMecConv;
    
    model DCMotor
      Electrical.RLOpen rl_open;
      Rotational.FricInertia fric_inertia;
      ElMecConv el_mec_conv;  
    equation
      connect(el_mec_conv.p, rl_open.la.n);
      connect(el_mec_conv.n, rl_open.gr.p);
      connect(el_mec_conv.flange, fric_inertia.inertia.flange);  
    annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-6, Interval = 0.001));end DCMotor;
    
  end ElectroMec;

  package Translational
    type Position = Real(unit = "m");
    type Distance = Real(unit = "m");
    type Velocity = Real(unit = "m/s");
    type Force = Real(unit = "N");
    type Mass = Real(unit = "Kg");
    
    model PointMass
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {3, 41}, extent = {{-33, -33}, {33, 33}}, rotation = 0)));
      Position s;
      Velocity v;
      parameter Mass m = 1;
    equation
      s = flange.s;
      v = der(s);
      m*der(v) = flange.f;
    protected
      annotation(
        Icon(graphics = {Rectangle(origin = {6, -41}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.5, extent = {{-68, 57}, {68, -57}})}));
    end PointMass;
  
    connector Flange
      Position s;
      flow Force f;
      annotation(
        Icon(graphics = {Ellipse(origin = {3, -1}, lineThickness = 6, extent = {{-85, 81}, {85, -81}}, endAngle = 360)}));
    end Flange;
  
    model Fixed
    Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {9, -1}, extent = {{-35, -35}, {35, 35}}, rotation = 0)));
      Position s0 = 0;
      
    equation
    flange.s = s0;  
    annotation(
        Icon(graphics = {Rectangle(origin = {-58.01, 0.26}, fillColor = {238, 238, 236}, fillPattern = FillPattern.Backward, lineThickness = 0.2, extent = {{-41.99, 99.74}, {41.99, -99.74}})}));end Fixed;
  
    partial model Compliant
      Translational.Flange flange1 annotation(
        Placement(visible = true, transformation(origin = {-222, 6}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-52, -2}, extent = {{-24, -24}, {24, 24}}, rotation = 0)));
      Translational.Flange flange2 annotation(
        Placement(visible = true, transformation(origin = {-26, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {61, -1}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
      Distance srel;
      Force f;
    equation 
      srel = flange2.s - flange1.s;
      flange2.f = f;
      flange1.f = -f;
    annotation(
        Icon);end Compliant;
  
    model Spring
      extends Translational.Compliant;
      parameter Real k = 1;
      parameter Real srel0 = 0;
    equation
      f = k *(srel - srel0);
    annotation(
        Icon(graphics = {Line(origin = {1.85, 0}, points = {{-33.8536, 0}, {-25.8536, 0}, {-19.8536, 40}, {-13.8536, -40}, {-5.85355, 40}, {4.14645, -40}, {10.1464, 40}, {18.1464, -40}, {24.1464, 0}, {34.1464, 0}, {38.1464, 0}}, thickness = 1.75)}));end Spring;
  
    model SinForce
    Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-8, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-47, -5}, extent = {{-61, -61}, {61, 61}}, rotation = 0)));
     parameter Force F = 1;
     parameter Real f = 1;
    equation
      flange.f = -F*sin(6.2832*f*time);
    annotation(
        Icon(graphics = {Line(origin = {34, -4}, points = {{-32, 0}, {32, 0}}, thickness = 3, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 12)}));end SinForce;
  
    model Damper
      extends Translational.Compliant;
      parameter Real b = 1;
    equation
    f = b*der(srel);
    annotation(
        Icon(graphics = {Line(origin = {-6.14, -3.2}, points = {{-25.2, 3.2}, {16.8, 3.2}, {16.8, 15.2}}, thickness = 1.75), Line(origin = {10.66, -7.33}, points = {{0, 7}, {0, -7}, {0, -5}}, thickness = 1.75), Line(origin = {10.98, 31.02}, points = {{-4.98079, -11.0192}, {9.01921, -11.0192}, {9.01921, -51.0192}, {-4.98079, -51.0192}, {9.01921, -51.0192}}, thickness = 1.75), Line(origin = {23.1287, 40.8393}, points = {{-1.8081, -40.1822}, {18.1919, -40.1822}, {20.1919, -30.1822}, {18.1919, -38.1822}}, thickness = 1.75)}));end Damper;
  
    model SpringDamperMass
    Translational.Fixed fixed annotation(
        Placement(visible = true, transformation(origin = {88, -2}, extent = {{-12, -12}, {12, 12}}, rotation = 180)));
    Translational.Damper damper(b = 100)  annotation(
        Placement(visible = true, transformation(origin = {57, -1}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    Translational.Spring spring(k = 10000)  annotation(
        Placement(visible = true, transformation(origin = {-29, 21}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
    Translational.Damper damper1(b = 100)  annotation(
        Placement(visible = true, transformation(origin = {-31, -33}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
    Translational.PointMass pointMass(m = 0.1)  annotation(
        Placement(visible = true, transformation(origin = {26, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-88, 2}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    equation
      connect(pointMass.flange, damper.flange1) annotation(
        Line(points = {{26, -2}, {48, -2}}));
    connect(damper.flange2, fixed.flange) annotation(
        Line(points = {{68, 0}, {84, 0}, {84, -2}}));
    connect(spring.flange2, pointMass.flange) annotation(
        Line(points = {{-16, 22}, {26, 22}, {26, -2}}));
    connect(damper1.flange2, pointMass.flange) annotation(
        Line(points = {{-18, -32}, {26, -32}, {26, -2}}));
    connect(spring.flange1, damper1.flange1) annotation(
        Line(points = {{-42, 20}, {-60, 20}, {-60, -34}, {-44, -34}}));
    connect(flange, spring.flange1) annotation(
        Line(points = {{-90, -2}, {-76, -2}, {-76, 20}, {-42, 20}}));
    annotation(
        Icon(graphics = {Text(origin = {8, 2}, extent = {{-46, 52}, {46, -52}}, textString = "SDM"), Rectangle(origin = {2, 2}, lineThickness = 1.75, extent = {{-90, 88}, {90, -88}})}));end SpringDamperMass;
  
    model SpringDamperMassForce
    Translational.SpringDamperMass springDamperMass annotation(
        Placement(visible = true, transformation(origin = {-16, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Translational.SinForce sinForce(F = 500)  annotation(
        Placement(visible = true, transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(springDamperMass.flange, sinForce.flange) annotation(
        Line(points = {{-24, 0}, {28, 0}}));
    end SpringDamperMassForce;
  end Translational;

  package Hydraulic
    type Volume = Real (unit = "m^3");
    type Flow = Real (unit = "m^3/s");
    type Pressure = Real (unit = "Pa");
  
    connector FluidPort
      Pressure p;
      flow Flow q;
    annotation(
        Icon(graphics = {Rectangle(origin = {-3, -6}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-49, 54}, {49, -54}})}));
    end FluidPort;
  
    model ConstPressure
    Hydraulic.FluidPort port annotation(
        Placement(visible = true, transformation(origin = {-12, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {48, 0}, extent = {{52, -52}, {-52, 52}}, rotation = 90)));
    parameter Pressure P = 0;
    equation
  port.p=P;
    annotation(
        Icon(graphics = {Line(origin = {-52, 0}, points = {{-36, 0}, {36, 0}}, thickness = 1.25, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 7)}));end ConstPressure;
  
    model SinPressure
    Hydraulic.FluidPort port annotation(
        Placement(visible = true, transformation(origin = {-10, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {29, -3}, extent = {{-45, -45}, {45, 45}}, rotation = 90)));
    parameter Pressure P = 0;
    parameter Real f = 1;
    equation
    port.p = P*sin(6.2832*f*time);
    annotation(
        Icon(graphics = {Line(origin = {-49.19, -3.95}, points = {{-44.8066, -4.05374}, {-28.8066, 19.9463}, {-18.8066, -20.0537}, {1.19338, 19.9463}, {9.19338, -20.0537}, {17.1934, 3.94626}, {31.1934, 3.94626}, {37.1934, 3.94626}, {41.1934, 3.94626}, {45.1934, 3.94626}}, thickness = 1.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 7)}));end SinPressure;
  
    partial model TwoPort
    Pressure prel;
    Flow q;
    Hydraulic.FluidPort port1 annotation(
        Placement(visible = true, transformation(origin = {-28, 22}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, -64}, extent = {{-52, -52}, {52, 52}}, rotation = 0)));
    Hydraulic.FluidPort port2 annotation(
        Placement(visible = true, transformation(origin = {8, -26}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2, 70}, extent = {{-52, -52}, {52, 52}}, rotation = 0)));
    equation
    prel=port1.p-port2.p;
    q=port1.q;
    q=-port2.q;
    end TwoPort;
  
    model Valve
      extends Hydraulic.TwoPort;
    parameter Real R = 1;
    equation
    prel = R*q;
    end Valve;
  
    model OneWayValve
      extends Hydraulic.TwoPort;
    parameter Real R = 1;
    parameter Real Roff = 1e9;
    equation
    prel = if q > 0 then R*q else q*Roff;
    annotation(
        Icon(graphics = {Line(origin = {-4, 20}, points = {{0, 0}}), Line(origin = {-0.351695, 2.2088}, points = {{0, 11}, {0, -37}}, thickness = 1.5), Line(origin = {14.8728, 14.4836}, points = {{-43, 0}, {13, 0}}, thickness = 1.5)}));end OneWayValve;
  
    model WaterColumn
      extends Hydraulic.TwoPort;
      parameter Real h = 1;
      constant Real g = 9.8;
      parameter Real rho = 997;
    equation
    prel = h*g*rho;
    annotation(
        Icon(graphics = {Rectangle(origin = {1, 0},fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, lineThickness = 1.25, extent = {{-39, 82}, {39, -82}})}));end WaterColumn;
  
    model Tank
    Volume vol;
    parameter Real A=1;
    constant Real g=9.8;
    constant Real rho=997;
    Hydraulic.FluidPort port annotation(
        Placement(visible = true, iconTransformation(origin = {2, -70}, extent = {{-48, -48}, {48, 48}}, rotation = 0)));
    equation
    port.p*A=vol*rho*g;
    der(vol)=port.q;
    annotation(
        Icon(graphics = {Rectangle(origin = {1.12, -1.74}, lineThickness = 1.25, extent = {{-77.12, 43.74}, {77.12, -43.74}}), Rectangle(origin = {1, -20}, fillColor = {114, 159, 207}, fillPattern = FillPattern.Solid, extent = {{-77, 26}, {77, -26}})}));end Tank;
  
    model PumpTank
    Hydraulic.FluidPort fluidPort annotation(
        Placement(visible = true, transformation(origin = {-78, -6}, extent = {{8, -8}, {-8, 8}}, rotation = 90), iconTransformation(origin = {-87, -5}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    Hydraulic.OneWayValve valve1(R = 1e5)  annotation(
        Placement(visible = true, transformation(origin = {0, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Hydraulic.ConstPressure constpressure annotation(
        Placement(visible = true, transformation(origin = {0, -88}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
    OneWayValve valve2(R = 1e5)  annotation(
        Placement(visible = true, transformation(origin = {0, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    WaterColumn wc(h = 3)  annotation(
        Placement(visible = true, transformation(origin = {0, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    Tank tank annotation(
        Placement(visible = true, transformation(origin = {0, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(constpressure.port, valve1.port1) annotation(
        Line(points = {{0, -84}, {0, -64}}));
    connect(valve1.port2, valve2.port1) annotation(
        Line(points = {{0, -50}, {0, 8}}));
    connect(fluidPort, valve2.port1) annotation(
        Line(points = {{-78, -6}, {0, -6}, {0, 8}}));
    connect(valve2.port2, wc.port1) annotation(
        Line(points = {{0, 22}, {0, 48}}));
    connect(wc.port2, tank.port) annotation(
        Line(points = {{0, 62}, {0, 84}}));
      annotation(
        Icon(graphics = {Rectangle(origin = {-4, -6}, fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-84, 84}, {84, -84}}), Text(origin = {0, -5}, extent = {{-50, 35}, {50, -35}}, textString = "PumpTank")}));end PumpTank;
  
    model Pumping
    Hydraulic.PumpTank pumpTank annotation(
        Placement(visible = true, transformation(origin = {51, 3}, extent = {{-41, -41}, {41, 41}}, rotation = 0)));
    Hydraulic.SinPressure sinPressure(P = 50000, f = 1)  annotation(
        Placement(visible = true, transformation(origin = {-75, 1}, extent = {{-19, -19}, {19, 19}}, rotation = 0)));
    equation
      connect(sinPressure.port, pumpTank.fluidPort) annotation(
        Line(points = {{-70, 0}, {16, 0}}));
    annotation(
        Icon(graphics = {Rectangle(fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-96, 98}, {96, -98}}), Text(origin = {-4, 4}, extent = {{-70, 56}, {70, -56}}, textString = "Pumping")}));end Pumping;
    
  end Hydraulic;

  package RotoTranslational
    model RodCrank
      Translational.Force F;
      Translational.Position x;
      Rotational.Angle th;
      parameter Real r = 0.1;
      parameter Real l = 1;
      parameter Real x0 = (-r) - l;
      Rotational.Flange flangerot annotation(
        Placement(visible = true, transformation(origin = {-2, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {46, 22}, extent = {{-12, -12}, {12, 12}}, rotation = 0)));
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-2, -34}, extent = {{-12, -12}, {12, 12}}, rotation = 0), iconTransformation(origin = {47, -27}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      th = flangerot.th;
      x + x0 = flange.s;
      r ^ 2 + x ^ 2 = l ^ 2 - 2 * r * l * cos(th);
      flange.f = F * sqrt(1 - (r * sin(th) / l) ^ 2);
      flangerot.tau = -r * x * sin(th) * F;
      annotation(
        Icon(graphics = {Rectangle(origin = {-24, 0}, extent = {{-62, 60}, {62, -60}}), Text(origin = {-24, 1}, extent = {{-58, 43}, {58, -43}}, textString = "RodC"), Text(origin = {65, -29}, extent = {{-7, 7}, {7, -7}}, textString = "Tr"), Text(origin = {65, 23}, extent = {{-7, 7}, {7, -7}}, textString = "Rt")}));
    end RodCrank;
  
    model RodCrankMass
    TPModelica.RotoTranslational.RodCrank rodCrank annotation(
        Placement(visible = true, transformation(origin = {-46, 22}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
    Translational.SpringDamperMass springDamperMass annotation(
        Placement(visible = true, transformation(origin = {46, 14}, extent = {{-30, -30}, {30, 30}}, rotation = 0)));
    TPModelica.Rotational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-17, 29}, extent = {{-7, -7}, {7, 7}}, rotation = 0), iconTransformation(origin = {62, -4}, extent = {{-16, -16}, {16, 16}}, rotation = 0)));
    equation
    connect(rodCrank.flange, springDamperMass.flange) annotation(
        Line(points = {{-33, 14}, {22, 14}}, color = {85, 85, 0}));
    connect(rodCrank.flangerot, flange) annotation(
        Line(points = {{-33, 28}, {-24, 28}, {-24, 29}, {-17, 29}}, color = {170, 85, 0}));
    annotation(
        Icon(graphics = {Rectangle(origin = {-22, -2}, extent = {{-72, 60}, {72, -60}}), Text(origin = {-20, -3}, extent = {{-66, -63}, {66, 63}}, textString = "RodCM")}));end RodCrankMass;
  
    model RodCrankMassTau
      extends RotoTranslational.RodCrankMass;
      Rotational.ConstTorque constTorque(Tau = 0.5)  annotation(
        Placement(visible = true, transformation(origin = {-56, 72}, extent = {{-22, -22}, {22, 22}}, rotation = 0)));
      Rotational.Inertia inertia annotation(
        Placement(visible = true, transformation(origin = {41, 61}, extent = {{-21, -21}, {21, 21}}, rotation = 0)));
    equation
      connect(constTorque.flange, flange) annotation(
        Line(points = {{-40, 72}, {-14, 72}, {-14, 28}}, color = {170, 85, 0}));
      connect(flange, inertia.flange) annotation(
        Line(points = {{-14, 28}, {-14, 72}, {40, 72}}, color = {170, 85, 0}));
    annotation(
        Icon(graphics = {Text(origin = {-25, -42}, extent = {{-47, 16}, {47, -16}}, textString = "Tau")}));end RodCrankMassTau;
    
  end RotoTranslational;

  package HydroMec
    model Piston
      parameter Real A = 1;
      Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-24, 14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-92, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Hydraulic.FluidPort port annotation(
        Placement(visible = true, transformation(origin = {2, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {59, 35}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    equation
      flange.f = port.p * A;
      der(flange.s) * A = -port.q;
      annotation(
        Icon(graphics = {Rectangle(origin = {4, -5}, lineThickness = 1.5, extent = {{-80, 35}, {80, -35}}), Rectangle(origin = {-35, -2}, fillColor = {193, 125, 17}, fillPattern = FillPattern.Solid, extent = {{-49, 4}, {49, -4}}), Rectangle(origin = {18, -5}, fillColor = {193, 125, 17}, fillPattern = FillPattern.Solid, extent = {{-6, 33}, {6, -33}})}));
    end Piston;
  
    model PistonPumpTank
    HydroMec.Piston piston(A = 0.001)  annotation(
        Placement(visible = true, transformation(origin = {-23, -11}, extent = {{-25, -25}, {25, 25}}, rotation = 0)));
    Hydraulic.PumpTank pumpTank annotation(
        Placement(visible = true, transformation(origin = {56, 16}, extent = {{-26, -26}, {26, 26}}, rotation = 0)));
    Translational.Flange flange annotation(
        Placement(visible = true, transformation(origin = {-88, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-93, -1}, extent = {{-17, -17}, {17, 17}}, rotation = 0)));
    equation
      connect(piston.port, pumpTank.fluidPort) annotation(
        Line(points = {{-8, -2}, {-8, 14}, {34, 14}}));
    connect(flange, piston.flange) annotation(
        Line(points = {{-88, -12}, {-46, -12}}));
    annotation(
        Icon(graphics = {Rectangle(fillColor = {211, 215, 207}, fillPattern = FillPattern.Solid, extent = {{-94, 94}, {94, -94}}), Text(origin = {9, 1}, extent = {{-55, 47}, {55, -47}}, textString = "PistonPumpTank")}));end PistonPumpTank;
  
    model PistonPumpTankForce
    HydroMec.PistonPumpTank pistonPumpTank annotation(
        Placement(visible = true, transformation(origin = {-1, -61}, extent = {{-39, -39}, {39, 39}}, rotation = -90)));
    Translational.SinForce sinForce(F = 150)  annotation(
        Placement(visible = true, transformation(origin = {-2, 64}, extent = {{-28, -28}, {28, 28}}, rotation = 90)));
    equation
      connect(pistonPumpTank.flange, sinForce.flange) annotation(
        Line(points = {{-2, -24}, {0, -24}, {0, 50}}));
    end PistonPumpTankForce;
  end HydroMec;

  model CompleteSystem
    ElectroMec.DCMotor motor;
    RotoTranslational.RodCrankMass rodCrankMass;
    HydroMec.PistonPumpTank tank;
  equation
    connect(motor.fric_inertia.inertia.flange, rodCrankMass.flange);
    connect(rodCrankMass.springDamperMass.flange, tank.piston.flange);
  annotation(
      experiment(StartTime = 0, StopTime = 50, Tolerance = 1e-6, Interval = 0.01));
  end CompleteSystem;
end TPModelica;