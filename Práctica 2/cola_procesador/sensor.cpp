#include "sensor.h"
void sensor::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

count = 0;
ttl = INF;
}
double sensor::ta(double t) {
//This function returns a double.
return ttl;
}
void sensor::dint(double t) {
ttl = INF;
}
void sensor::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

ttl = 0;
if(x.port == 0)
	count++;
else
	count--;
}
Event sensor::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

output[0] = count;
return Event(output, 0);
}
void sensor::exit() {
//Code executed at the end of the simulation.

}
