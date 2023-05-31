import numpy as np 

def tdoa(td1,td2,td3, x, y, z, v = 343):
    """

    Args:
        td1 (float): time delay between first and second microphone
        td2 (float): time delay between second and third microphone
        td3 (float): time delay between third and fourth microphone
        x (float):  x coordinate of reference microphone
        y (float):  y coordinate of reference microphone
        z (float):  z coordinate of reference microphone
        v (int, optional): speed of sound under normal temperature conditions. Defaults to 343.

    Returns:
        float: the x, y and z coordinates of the signal source 
    """
        time_delays=[0,td1,td2,td3]
        len = len(time_delays)
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
