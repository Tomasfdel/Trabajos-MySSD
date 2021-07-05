//CPP:tp_discrete/filtro.cpp
#if !defined filtro_h
#define filtro_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class filtro: public Simulator { 
// Declare the state,
// output variables
// and parameters

#define INF 1e20

// Probabilidad de filtro.
double filterProb;

// Valor del trabajo de entrada.
double job;

// Tiempo de vida del estado actual. 
double ttl;

// Valor de salida.
double output[10];



public:
	filtro(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
