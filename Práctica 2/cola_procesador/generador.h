//CPP:tp_discrete/generador.cpp
#if !defined generador_h
#define generador_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class generador: public Simulator { 
// Declare the state,
// output variables
// and parameters

// Tiempo hasta la siguiente emisión
double ttl;

// Valor emitido.
double output[10];

// Parámetros.
double jMin, jMax, tMax;






public:
	generador(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
