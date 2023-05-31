# Sound_source_localization


This projects presents a couple of signal methods for detecting and localizing an acoustic signal source by using an Arduino Board and 4 microphones.
There are two versions : a Python version and a Matlab version which is more complete. 
It has a matlab GUI. 

The main steps are the following:
1. Data acquisition by using an Arduino Board and 4 microphones from which 1 microphone is used as reference.
2. Signal processing (filtering and interpolation).
3. Computing time of arrivals and the delays of the signals for each pair of microphones by using Cross-correlation, Spectogram, Wavelet and Recurrence Plot Analysis methods.
4. Using Time Difference of Arrival for computing the coordinates of the signal source.
5. Send an alarm for source detection and its coordinates by email on a personal device.


The method is effective but it uses classic signal processing methods.
The code needs improvements as well. 
