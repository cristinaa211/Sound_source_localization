import matplotlib.pyplot as plt 
import numpy as np

def plot_3d_coordinates(xs,ys,zs):
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

def draw_fig_real_time(data):
    plt.ylim(-5,5)
    plt.title('Semnal audio in timp real')
    plt.grid(True)
    plt.ylabel('Amplitudine')
    plt.xlabel('Timp')
    plt.plot(data)


def plot_spectrogram(spec,sample_rate, L, starts, mappable = None):
    plt.figure()
    plt_spec = plt.imshow(spec)
    Nyticks = 10
    ks = np.linspace(0,spec.shape[0],Nyticks)
    plt.ylabel("Frequency (Hz)")
    Nxticks = 10
    ts_spec = np.linspace(0,spec.shape[1],Nxticks)
    plt.xlabel("Time (sec)")
    plt.title("Spectrogram L={} Spectrogram.shape={}".format(L,spec.shape))
    plt.colorbar(mappable,use_gridspec=True)
    plt.show()
    return(plt_spec)