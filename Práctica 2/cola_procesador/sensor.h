//CPP:tp_discrete/sensor.cpp
#if !defined sensor_h
#define sensor_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class sensor: public Simulator { 
// Declare the state,
// output variables
// and parameters

#define INF 1e20 

// Contador de trabajos.
double count;

// Tiempo de vida del estado actual.
double ttl;

// Valor de salida.
double output[10];

public:
	sensor(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
