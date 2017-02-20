import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
from math import sqrt


def dot(a, b):
    return sum([a_i * b_i for a_i, b_i in zip(a, b)])


def distance(a, b):
    return sqrt(sum([(a_i - b_i)**2 for a_i, b_i in zip(a, b)]))


# TODO: animation of the optimization method
def plot(fn, step, x_range, y_range):
    i1 = np.arange(x_range[0], x_range[1], step)
    i2 = np.arange(y_range[0], y_range[1], step)
    X, Y = np.meshgrid(i1, i2)
    Z = fn(X, Y)

    fig = plt.figure()
    ax = Axes3D(fig)

    Gx, Gy = np.gradient(Z)     # gradients with respect to x and y
    G = (Gx**2 + Gy**2)**.5     # gradient magnitude
    N = G / G.max()             # normalize 0..1

    ax.plot_surface(X, Y, Z, facecolors=plt.cm.jet(N))
    plt.show()
