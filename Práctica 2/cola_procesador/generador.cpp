#include "generador.h"
void generador::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type


jMin = va_arg(parameters, double);
jMax = va_arg(parameters, double);
tMax = va_arg(parameters, double);

ttl = tMax * rand() / RAND_MAX;
}
double generador::ta(double t) {
//This function returns a double.
return ttl;
}
void generador::dint(double t) {
ttl = tMax * rand() / RAND_MAX;
}
void generador::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

}
Event generador::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

output[0] = jMin + (jMax - jMin) * rand() / RAND_MAX;
return Event(output, 0);
}
void generador::exit() {
//Code executed at the end of the simulation.

}
