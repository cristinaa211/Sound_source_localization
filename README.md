# Sound_source_localization
PAPER: https://www.researchgate.net/publication/348685093_An_Overview_of_Signal_Processing_Methods_for_Signal_Source_Localization

This projects presents a couple of signal methods for detecting and localizing an acoustic signal source by using an Arduino Board and 4 microphones.
There are two versions : a Python version and a Matlab version which is more complete. 
It has a matlab GUI. 

# The main steps are the following:
1. Data acquisition by using an Arduino Board and 4 microphones from which 1 microphone is used as reference.
2. Signal processing (filtering and interpolation).
3. Computing time of arrivals and the delays of the signals for each pair of microphones by using Cross-correlation, Spectogram, Wavelet and Recurrence Plot Analysis methods.
4. Using Time Difference of Arrival for computing the coordinates of the signal source.
5. Send an alarm for source detection and its coordinates by email on a personal device.


The method is effective but it uses classic signal processing methods.
The code needs improvements as well. 

In the following, there are some generated artificial signals, affected by noise, and also the results using the methods enumerated above:

# The time representations of the signals, corresponding to the 4 microphones:

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/167e6aca-9401-4281-a257-aca31b7f8080)


# The cross-correlation of the signals looks like the following:

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/13e897eb-c3e0-4222-8cfa-f490a89d6760) ![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/a83ee734-4395-4fda-8c98-131ec9fbd6da)



# The scalograms of the signals and the detection curves are represented below:


![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/419ef349-b1fb-4b80-b635-97e9bd885fc1)

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/24a22fcd-e3b6-4ff3-83e1-42f39db82091)





# The spectograms of the signals and the detection curves are represented below:

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/4c10d8f1-c016-4252-ad64-dd2267bf894b)

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/eeabc259-93a9-4ce6-bd0c-62c6757870a3)



# The phase diagram computed by using RPA and their corresponding detection curves:

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/fcfe6907-31f8-4078-98ed-099bc52c166d)



![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/4b30fa81-ac8e-44fb-a579-5122d12628f4)

Given the microphones positions in space, we can estimate the location of the signal source (in this case using the artificial signals) by using triangulation (TDOA).
The red color represents the estimated source position, the purple color represents the real source position. When detected, an e-mail with the estimated source position is transmitted to the owner. 

![image](https://github.com/cristinaa211/Sound_source_localization/assets/61435903/28534ea6-2f12-4061-b88e-2ea618082197)


In a real scenario, lots of noise is added to the signals, like the hardware noise, the background noise, so there should be a good pre-processing. More than that, the system is created for one signal source, so more signal sources can lead to undesired results.
There are lots of possibilities to enhance this code, which  presents only some basic signal processing techniques for source position estimation.

