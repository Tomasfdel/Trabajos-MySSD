#include "filtro.h"
void filtro::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

ttl = INF;

}
double filtro::ta(double t) {
//This function returns a double.
return ttl;
}
void filtro::dint(double t) {
ttl = INF;
}
void filtro::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

if(x.port == 0){
	ttl = 0;
	job = x.getDouble();
}
else
	filterProb = x.getDouble();


}
Event filtro::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

double probabilityRoll = (double) rand() / RAND_MAX;
output[0] = job;
return Event(output, probabilityRoll >= filterProb);
}
void filtro::exit() {
//Code executed at the end of the simulation.

}
