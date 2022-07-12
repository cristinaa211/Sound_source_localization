import serial
import time as t
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import scipy
from scipy import signal
from scipy.fftpack import rfft, irfft, fftfreq, fft, ifft
import datetime
from datetime import datetime
import timeit
from scipy.interpolate import interp1d
import smtplib
from scipy.signal import butter, lfilter
#import pywt
#import pywt.data

def butter_bandpass(lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    b, a = butter(order, [low, high], btype='band')
    return b, a


def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    b, a = butter_bandpass(lowcut, highcut, fs, order=order)
    y = lfilter(b, a, data)
    return y



def wavelet(s1):
    coeffs2 = pywt.dwt2(s1, 'bior1.3')
    LL, (LH, HL, HH) = coeffs2
    for i, a in enumerate([LL, LH, HL, HH]):
        ax = fig.add_subplot(1, 4, i + 1)
        ax.imshow(a, interpolation="nearest", cmap=plt.cm.gray)
        ax.set_title(titles[i], fontsize=10)
        ax.set_xticks([])
        ax.set_yticks([])

    fig.tight_layout()
    plt.show()
def plot_spectrogram(spec,sample_rate, L, starts, mappable = None):
    plt.figure()
    #plt_spec = plt.imshow(spec)
    Nyticks = 10
    ks = np.linspace(0,spec.shape[0],Nyticks)
    ksHz = get_Hz_scale_vec(ks,sample_rate,len(ts))
    plt.yticks(ks,ksHz)
    plt.ylabel("Frequency (Hz)")
    Nxticks = 10
    ts_spec = np.linspace(0,spec.shape[1],Nxticks)
    ts_spec_sec  = ["{:4.2f}".format(i) for i in np.linspace(0,total_ts_sec*starts[-1]/len(ts),Nxticks)]
    plt.xticks(ts_spec,ts_spec_sec)
    plt.xlabel("Time (sec)")
    plt.title("Spectrogram L={} Spectrogram.shape={}".format(L,spec.shape))
    plt.colorbar(mappable,use_gridspec=True)
    plt.show()
    return(plt_spec)

def spectrograma(s1,s2,s3,s4,fs):
    f1,t1,Sxx1 = signal.spectrogram(s1,fs)
    f2,t2,Sxx2 = signal.spectrogram(s2,fs)
    f3,t3,Sxx3 = signal.spectrogram(s3,fs)
    f4,t4,Sxx4 = signal.spectrogram(s4,fs)
    fig, axs = plt.subplots(2, 2)
    axs[0, 0].plt.pcolormesh(t1,f1,Sxx1)
    axs[0, 0].set_title('Spectrograma 1 ')
    axs[0, 1].plt.pcolormesh(t2,f2,Sxx2)
    axs[0, 1].set_title('Spectrograma 2')
    axs[1, 0].plt.pcolormesh(t3,f3,Sxx3)
    axs[1, 0].set_title('Spectrograma 3')
    axs[1, 1].plt.pcolormesh(t4,f4,Sxx4)
    axs[1, 1].set_title('Spectrograma 4')
    for ax in axs.flat:
        ax.set(xlabel='Timp[sec]', ylabel='Frecventa[Hz]')
    plt.show()

def email():
    sender = "popovici.cristina211@gmail.com"
    rec="cristina.popovici211@gmail.com"
    passw = "scoala.21"
    msg = "S-a detectat o sursa acustica la coordonatele"
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(sender, passw)
    print('Login success')
    server.sendmail(sender,rec, msg)
    print('Email has been sent to rec')
    return 1
def bytes_to_int(caractere):
    result = 0
    for b in caractere:
        result = result * 256 + ord((b))
    return result
def tdoa(td1,td2,td3):
        x=[0,0.17,0.17,0.72]
        y=[0,0,0.85,0.61]
        z=[0,0,0,0.13]
        v=343
        time_delays=[0,td1,td2,td3]
        len=4
        Amat = np.zeros((len, 1))
        Bmat = np.zeros((len, 1))
        Cmat = np.zeros((len, 1))
        Dmat = np.zeros((len, 1))
        for i in range(2, len):
    
            Amat[i] = (1/(v*time_delays[i]))* (-2 * x[0] + 2 * x[i]) - (1/(v*time_delays[1]))* (
                -2 * x[1] + 2 * x[2])
            Bmat[i] = (1/(v*time_delays[i]))* (-2 * y[0] + 2 * y[i]) - (1/(v*time_delays[1])) * (
                -2 * y[1] + 2 * y[2])
            Cmat[i] = (1/(v*time_delays[i])) * (-2 * z[0] + 2 * z[i]) - (1/(v*time_delays[1]))* (
                -2 * z[1] + 2 * z[2])
            Sum1 = (x[0] ** 2) + (y[0] ** 2) + (z[0] ** 2) - (x[i] ** 2) - (y[i] ** 2) - (z[i] ** 2)
            Sum2 = (x[0] ** 2) + (y[0] ** 2) + (z[0] ** 2) - (x[1] ** 2) - (y[1] ** 2) - (z[1] ** 2)
            Dmat[i] = v* (time_delays[i] - time_delays[1]) + (1/(v*time_delays[i])) * Sum1 - (1/(v*time_delays[1]))* Sum2

        M = np.zeros((len + 1, 3))
        D = np.zeros((len + 1, 1))
        for i in range(len):
            M[i, 0] = Amat[i]
            M[i, 1] = Bmat[i]
            M[i, 2] = Cmat[i]
            D[i] = Dmat[i]

        M = np.array(M[2:len, :])
        D = np.array(D[2:len])

        D = np.multiply(-1, D)

        Minv = np.linalg.pinv(M)
    
        T = np.dot(Minv, D)
        xs = T[0]
        ys = T[1]
        zs = T[2]
        print('Pozitia sursei acustice este la coordonatele: x=')
        print(xs)
        print('y=')
        print(ys)
        print('z=')
        print(zs)
        return xs, ys, zs
def figura(xs,ys,zs):
    x=[0,5,0,5]
    y=[0,0,5,5]
    z=[0,0,0,0]
    fig = plt.figure()
    ax = fig.add_subplot(111, projection='3d')
    xa=[x[0],x[1],x[2],x[3],xs]
    ya=[y[0],y[1],y[2],y[3],ys]
    za=[z[0],z[1],z[2],z[3],zs]
    ax.scatter3D(x, y, z, c=z, cmap='hsv');
    ax.set_xlim(-10,10)
    ax.set_ylim(-10,10)
    ax.set_zlim(-10,10)
    ax.scatter3D(xa, ya, za, c=za);
    ax.set_xlabel('X Label')
    ax.set_ylabel('Y Label')
    ax.set_zlabel('Z Label')
    plt.show()
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
    print('Intarzierile sunt:')
    print(t1)
    print(t2)
    print(t2)
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
ser = serial.Serial('COM6', baudrate=115200)
def draw_fig_real():
    plt.ylim(-5,5)
    plt.title('Semnal audio in timp real')
    plt.grid(True)
    plt.ylabel('Amplitudine')
    plt.xlabel('Timp')
    plt.plot(data)
fs=0.0000226
dateTimeObj=datetime.now()
data = []
t.sleep(2)
secunde=10;
t_end = t.time()+secunde*1 #  secunde *1 minut
print("start")
start = timeit.default_timer()
while True :
    x=ser.readline()
    data.append(x)
    print(x)
    if x[0] in "123" and  x[1] == "." and  x[2] in "0123456789" and  x[3] in "0123456789" and len(x)==6:
        if x > '1.75' and x < '3.3 'and x <'26469':
             print('S-a detectat o sursa acustica la momentul de timp:')
             print(dateTimeObj)
             print(x)
             i=0
             while i < 30:
                 x=ser.readline()
                 data.append(x)
                 print(x)
                 i=i+1
             break
stop = timeit.default_timer()
ser.close()
timp = stop - start
print("stop");
i=0
data2=[]
s1=[]
s2=[]
s3=[]
s4=[]
data1=[]

for el in data:
        if el[0] in "123" and  el[1] == "." and  el[2] in "0123456789" and  el[3] in "0123456789" and len(el)==6:
            data1.append(float(el))
#dataa=[]
#dataa = butter_bandpass_filter(data1, 500, 16000, fs, order=6)
#for el in data1:
 #   if data1.index(el)%4==0:
  #        s4.append(el)
   # if data1.index(el)%4==1:
  #        s1.append(el)
    #if data1.index(el)%4==2:
     #     s2.append(el)
    #if data1.index(el)%4==3:
     #     s3.append(el)
for j in range(len(data1)-3):
    s4.append(data1[j])
    s1.append(data1[j+1])
    s2.append(data1[j+2])
    s3.append(data1[j+3])
s11=np.array(s1)
s22=np.array(s2)
s33=np.array(s3)
s44=np.array(s4)
fes=len(data)/timp
fig, axs = plt.subplots(2, 2)
axs[0, 0].plot(s1)
axs[0, 0].set_title('Semnalul achizitionat de microfonul 1')
axs[0, 1].plot(s2)
axs[0, 1].set_title('Semnalul achizitionat de microfonul 2')
axs[1, 0].plot(s3)
axs[1, 0].set_title('Semnalul achizitionat de microfonul 3')
axs[1, 1].plot(s4)
axs[1, 1].set_title('Semnalul achizitionat de microfonul 4')

for ax in axs.flat:
    ax.set(xlabel='Esantioane', ylabel='Amplitudine')
    ax.set_ylim([0, 3])
plt.show()
(td1,td2,td3)=corelatia(s1,s2,s3,s4,fs)
(xs,ys,zs)=tdoa(td1,td2,td3)
figura(xs,ys,zs)
#email()
#spectrograma(s1,s2,s3,s4,fs)
print('esantionae= ', len(data))
print('Frecventa de esantionare este:' , fes)
write_to_file_path="salvareDate.txt"
output_file1 = open(write_to_file_path, "w+");
file2="coordonate_python.txt"
output_file2 = open(file2, "w+");
for i in range (len(data)):
    output_file1.write(str(data[i]))
    output_file1.write('\n')
output_file2.write('Sursa se afla la coordonatele:\n x = ')
output_file2.write(str(xs))
output_file2.write('\n')
output_file2.write('y = ')
output_file2.write(str(ys))
output_file2.write('\nz=')
output_file2.write(str(zs))
#wavelet(s1)
#plot_spectrogram(s1,fs,256,0,mappable=None)
(td11)=lag_finder(s1, s2, fs)
(td12)=lag_finder(s1, s3, fs)
(td13)=lag_finder(s1, s4, fs)



