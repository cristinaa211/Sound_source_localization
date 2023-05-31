import serial
import datetime
from datetime import datetime
import timeit
import compute_correlation
from tdoa import tdoa
from data_visualization import draw_fig_real_time, plot_3d_coordinates
import numpy as np
import matplotlib.pyplot as plt

if __name__ == "__main__":
    data = []
    # Reference microphone
    x=[0,0.17,0.17,0.72]
    y=[0,0,0.85,0.61]
    z=[0,0,0,0.13]
    print("start")
    ser = serial.Serial('COM6', baudrate=115200)
    dateTimeObj=datetime.now()
    start = timeit.default_timer()
    # Read data until you find a signal amplitude value greater than 1.75 V
    while True :
        x = ser.readline()
        data.append(x)
        draw_fig_real_time(data)
        print(x)
        if x[0] in "123" and  x[1] == "." and  x[2] in "0123456789" and  x[3] in "0123456789" and len(x)==6:
            if x > '1.75' and x < '3.3':
                print('We detected a signal source at time: {} and the signal amplitude value is: {}.'.format(dateTimeObj,x))
                i=0
                while i < 50:
                    "Continue reading data 50 iterations after the source is detected. "
                    x=ser.readline()
                    data.append(x)
                    print(x)
                    i=i+1
                break
    ser.close()
    stop = timeit.default_timer()
    time = stop - start
    print("stop");
    s1, s2, s3, s4 = [], [], [], []
    for j in range(len(data)-3):
        s4.append(data[j])
        s1.append(data[j+1])
        s2.append(data[j+2])
        s3.append(data[j+3])
    s11 = np.array(s1)
    s22 = np.array(s2)
    s33 = np.array(s3)
    s44 = np.array(s4)
    fes = len(data)/time
    fig, axs = plt.subplots(2, 2)
    axs[0, 0].plot(s1)
    axs[0, 0].set_title('signal purchased by microphone 1')
    axs[0, 1].plot(s2)
    axs[0, 1].set_title('signal purchased by microphone 2')
    axs[1, 0].plot(s3)
    axs[1, 0].set_title('signal purchased by microphone 3')
    axs[1, 1].plot(s4)
    axs[1, 1].set_title('signal purchased by microphone 4')
    for ax in axs.flat:
        ax.set(xlabel='Samples', ylabel='Amplitude')
        ax.set_ylim([0, 3])
    plt.show()
    (td1,td2,td3) = compute_correlation.corelatia(s1,s2,s3,s4,fes)
    (xs,ys,zs)= tdoa(td1,td2,td3)
    plot_3d_coordinates(xs,ys,zs)




