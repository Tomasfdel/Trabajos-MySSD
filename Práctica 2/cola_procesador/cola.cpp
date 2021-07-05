#include "cola.h"
void cola::init(double t,...) {
//The 'parameters' variable contains the parameters transferred from the editor.
va_list parameters;
va_start(parameters,t);
//To get a parameter: %Name% = va_arg(parameters,%Type%)
//where:
//      %Name% is the parameter name
//	%Type% is the parameter type

ttl = INF;
busyProcessor = false;
}
double cola::ta(double t) {
//This function returns a double.
return ttl;
}
void cola::dint(double t) {
jobs.pop();
ttl = INF;
busyProcessor = true;
}
void cola::dext(Event x, double t) {
//The input event is in the 'x' variable.
//where:
//     'x.value' is the value (pointer to void)
//     'x.port' is the port number
//     'e' is the time elapsed since last transition

if(x.port == 0){
	jobs.push(x.getDouble());
	if(not busyProcessor)
		ttl = 0;
}
else{
	busyProcessor = false;
	if(jobs.empty())
		ttl = INF;
	else
		ttl = 0;
}
}
Event cola::lambda(double t) {
//This function returns an Event:
//     Event(%&Value%, %NroPort%)
//where:
//     %&Value% points to the variable which contains the value.
//     %NroPort% is the port number (from 0 to n-1)

output[0] = jobs.front();
return Event(output, 0);
}
void cola::exit() {
//Code executed at the end of the simulation.

}
