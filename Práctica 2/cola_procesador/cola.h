//CPP:tp_discrete/cola.cpp
#if !defined cola_h
#define cola_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"

#include "queue"


class cola: public Simulator { 
// Declare the state,
// output variables
// and parameters

#define INF 1e20

// Cola de trabajos
std::queue <double> jobs;

// Tiempo de vida del estado actual.
double ttl;

// Estado de procesamiento.
bool busyProcessor;

// Valor de salida.
double output[10];
public:
	cola(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
