import operator
import numpy as np
import math
from numpy import random


class SimulatedAnnealing():
    # standart configuration parameters and functions for Simulated Annealing
    T_MIN = 1e-5
    T_MAX = 1

    def NEIGHBOUR(T, x):
        # return x + random.uniform(-T, T, x.shape)
        return random.normal(x, max(T, 0.1), x.shape)

    def ACCEPT(T, deltaE, k=0.1):
        return math.exp(-(deltaE) / k / T)

    def COOLING(T, best):
        return T * 0.99

    def __init__(self, energy, start, minimize=True, T_min=T_MIN, T_max=T_MAX,
                 neighbour=NEIGHBOUR, accept=ACCEPT, cooling=COOLING):
        self.compare = operator.lt if minimize else operator.gt
        self.T_min = T_min
        self.neighbour = neighbour
        self.energy = energy
        self.accept = accept
        self.cooling = cooling

        self.T = T_max
        self.best = np.array(start)
        self.step = 0

    def iteration(self):
        next = self.neighbour(self.T, self.best)
        deltaE = self.energy(next) - self.energy(self.best)
        if self.compare(deltaE, 0):
            self.best = next
        elif random.random() < self.accept(self.T, deltaE):
            self.best = next

    def cool(self):
        self.T = self.cooling(self.T, self.best)

    def execute(self):
        while self.T > self.T_min:
            self.iteration()
            self.cool()
            # self.log()
            self.step += 1
        print('\nf(' + str(self.best) + ') = ' + str(self.energy(self.best)))
        return self.best

    def log(self):
        if(self.step % 100 == 0):
            print(str(self.step) + " T=" + str(self.T) +
                  "\tf(" + str(self.best) + ") = " +
                  str(self.energy(self.best)))


def rosenbrock_fn(x, y, a=1, b=100):
    return (a - x)**2 + b * (y - x**2)**2


def rosenbrock_energy(vector):
    return rosenbrock_fn(*vector)


def simulated_annealing(fn, start):
    return SimulatedAnnealing(fn, start).execute()
