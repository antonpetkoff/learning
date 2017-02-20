from utils import dot, distance


def partial_difference_quotient(f, v, i, h):
    w = [v_j + (h if j == i else 0) for j, v_j in enumerate(v)]
    return (f(w) - f(v)) / h


def estimate_gradient(f, v, h=1e-8):
    return [partial_difference_quotient(f, v, i, h) for i, _ in enumerate(v)]


def descent_step(x, direction, step_length):
    return [x_i - step_length * d_i for x_i, d_i in zip(x, direction)]


def step_line_search(f, x, gradient, wolfe_const1=0.1, step_max=10, factor=0.3):
    """Backtracking line search which finds a step length,
    satisfying the first condition of Wolfe for sufficient decrease."""
    step = step_max
    while f(descent_step(x, gradient, step)) > \
            f(x) + wolfe_const1 * step * -dot(gradient, gradient):
        step *= factor
    return step


# TODO: domain constraint
def minimize_gradient_descent(f, x0, eps=1e-8):
    step_lengths = [100, 10, 1, 0.1, 0.01, 0.001, 0.0001, 0.00001]
    x = x0
    iterations = 0

    while True:
        iterations += 1
        gradient = estimate_gradient(f, x)
        # x_next = descent_step(x, gradient, 0.01)
        # x_next = descent_step(x, gradient, step_line_search(f, x, gradient))
        x_next = min([descent_step(x, gradient, step)
                      for step in step_lengths], key=f)
        print(iterations, x_next, f(x_next))
        if distance(x, x_next) < eps:
            break
        x = x_next

    print('iterations = ' + str(iterations))
    return x_next
