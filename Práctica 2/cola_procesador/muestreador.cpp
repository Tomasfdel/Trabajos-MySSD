#include "muestreador.h"
void muestreador::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

T = va_arg(parameters, double);

ttl = 0;
}
double muestreador::ta(double t) {
//This function returns a double.
return ttl;
}
void muestreador::dint(double t) {
ttl = T;
}
void muestreador::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

lastCount = x.getDouble();
ttl -= e;
}
Event muestreador::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

output[0] = lastCount;
return Event(output, 0);
}
void muestreador::exit() {
//Code executed at the end of the simulation.

}
