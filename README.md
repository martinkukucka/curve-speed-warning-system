# curve-speed-warning-system
### MATLAB Simulink implementation of Curve Speed Warning System. 
System warns driver when current speed of the vehicle exceeds recommended speed. Recommended speed is based on input data calculation (latitude, longitude, speed, time). Input data are processed by computation logic, which predicts future trajectory of vehicle, from which the recommended speed is obtained.

Repository contains 4 folders:
- csws - Library for MATLAB Simulink
- matlab_solution - Script implemented in MATLAB
- scripts - Python script to parse NMEA / TXT file containing NMEA-0183 data

- examples - Example Simulink models for both offline and online data