from scipy import signal
import numpy as np 
import matplotlib.pyplot as plt 

def corelatia(s1,s2,s3,s4,fs):
    corr1=signal.correlate(s1,s2,'full','auto')
    corr2=signal.correlate(s1,s3,'full','auto')
    corr3=signal.correlate(s1,s4,'full','auto')
    delay1 = len(corr1) - np.argmax(corr1)
    t1 = delay1*fs 
    delay2 = len(corr2) - np.argmax(corr2)
    t2 = delay2*fs 
    delay3 = len(corr3) - np.argmax(corr3)
    t3 = delay3*fs
    print(f'The delays between microphones are {t1}, {t2}, {t3}:')
    return t1,t2,t3

def lag_finder(y1, y2, sr):
    n = len(y1)
    corr = signal.correlate(y2, y1, mode='same') / np.sqrt(signal.correlate(y1, y1, mode='same')[int(n/2)] * signal.correlate(y2, y2, mode='same')[int(n/2)])
    delay_arr = np.linspace(-0.5*n/sr, 0.5*n/sr, n)
    delay = delay_arr[np.argmax(corr)]
    print('y2 is ' + str(delay) + ' behind y1')
    plt.figure()
    plt.plot(delay_arr, corr)
    plt.title('Lag: ' + str(np.round(delay, 3)) + ' s')
    plt.xlabel('Lag')
    plt.ylabel('Correlation coeff')
    plt.show()
    return delay