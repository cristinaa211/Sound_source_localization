import matplotlib.pyplot as plt
from tools import get_Hz_scale_vec
import numpy as np 
from scipy import signal


def spectrogram(s1,s2,s3,s4,fs):
    """_summary_

    Args:
        s1 (_type_): time variant signal : numeric
        s2 (_type_): time variant signal : numeric
        s3 (_type_): time variant signal : numeric
        s4 (_type_): time variant signal : numeric
        fs (int): sampling frequency
    """
    f1,t1,Sxx1 = signal.spectrogram(s1,fs)
    f2,t2,Sxx2 = signal.spectrogram(s2,fs)
    f3,t3,Sxx3 = signal.spectrogram(s3,fs)
    f4,t4,Sxx4 = signal.spectrogram(s4,fs)
    fig, axs = plt.subplots(2, 2)
    axs[0, 0].plt.pcolormesh(t1,f1,Sxx1)
    axs[0, 0].set_title('Spectrogram 1 ')
    axs[0, 1].plt.pcolormesh(t2,f2,Sxx2)
    axs[0, 1].set_title('Spectrogram 2')
    axs[1, 0].plt.pcolormesh(t3,f3,Sxx3)
    axs[1, 0].set_title('Spectrogram 3')
    axs[1, 1].plt.pcolormesh(t4,f4,Sxx4)
    axs[1, 1].set_title('Spectrogram 4')
    for ax in axs.flat:
        ax.set(xlabel='Time [sec]', ylabel='Frequency [Hz]')
    plt.show()