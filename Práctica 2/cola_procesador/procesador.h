//CPP:tp_discrete/procesador.cpp
#if !defined procesador_h
#define procesador_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class procesador: public Simulator { 
// Declare the state,
// output variables
// and parameters

#define INF 1e20;

// Estado de procesamiento.
bool busy;

// Tiempo de vida del estado actual. 
double ttl;

double output[10];


public:
	procesador(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
