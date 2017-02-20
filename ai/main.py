from gradient_descent import *
from simulated_annealing import *
from regression import *


def rosenbrock(v, a=1, b=100):
    return (a - v[0])**2 + b * (v[1] - v[0]**2)**2


def matyas(v):
    return 0.26 * (v[0]**2 + v[1]**2) - 0.48 * v[0] * v[1]


def beale(v):
    return (1.5 - v[0] + v[0] * v[1])**2 + (2.25 - v[0] + v[0] * (v[1]**2))**2
    + (2.625 - v[0] + v[0] * (v[1]**3))**2


def test_gradient_descent():
    print('gradient descent:')
    print(estimate_gradient(rosenbrock, [1, 1]))    # global minimum
    print(minimize_gradient_descent(rosenbrock, [1.4, 0.5]))
    print(minimize_gradient_descent(matyas, [4.3, 2.92]))
    print(minimize_gradient_descent(beale, [-1.9, -2.3]))


def test_regression():
    print('\nleast squares regression:')
    nodes_line = [(1, 3), (4, 10), (6, 20), (8, 30), (9, 34),
                  (11, 40), (13, 43)]
    print(optimal_parameters(nodes_line, line, minimize_gradient_descent))

    # simulated annealing works better than gradient descent here
    # gradient descent converges very slow
    nodes_exp = [(1, 1), (2, 2), (3, 5), (4, 9), (5, 18), (6, 34),
                 (7, 70), (8, 132), (9, 264), (10, 537)]
    # TODO: quadratic is a 3D function and we can't yet plot it
    print(optimal_parameters(nodes_exp, exponent, simulated_annealing))

    # quadratic regression with gradient descent for 220187 iterations
    # ends @ point [12.037849628337426, -87.01024837157456, 122.29910782823572]


def test_annealer():
    # minimize the Rosenbrock function with Simulated Annealing
    print(SimulatedAnnealing(rosenbrock_energy, [0.1, 1.4]).execute())
    print(SimulatedAnnealing(matyas, [4.3, 2.92]).execute())
    print(SimulatedAnnealing(beale, [-1.9, -2.3]).execute())


def main():
    # test_gradient_descent()
    test_regression()
    # test_annealer()

if __name__ == '__main__':
    main()
