//CPP:tp_discrete/muestreador.cpp
#if !defined muestreador_h
#define muestreador_h

#include "simulator.h"
#include "event.h"
#include "stdarg.h"



class muestreador: public Simulator { 
// Declare the state,
// output variables
// and parameters

#define INF 1e20 

// Último valor ingresado.
double lastCount;

// Tiempo de vida del estado actual.
double ttl;

// Valor de salida.
double output[10];

// Frecuencia de emisión.
double T;
public:
	muestreador(const char *n): Simulator(n) {};
	void init(double, ...);
	double ta(double t);
	void dint(double);
	void dext(Event , double );
	Event lambda(double);
	void exit();
};
#endif
