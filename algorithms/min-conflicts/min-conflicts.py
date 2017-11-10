# state representation - list of N integers (columns),
#   each integer is the row of the queen in that column
# initial state - each queen in its own column on a random row
# only one operator - move queen in her own column
# conflict calculation - TODO

# MinConflicts algorithm
# pick a queen randomly from all N queens
# move that queen in a better position with less conflicts
#   if there are multiple equally better positions, break the tie randomly
#   if there isn't a better row position for that queen, choose another queen
# repeat
import random


def stringify(state, n):
    def stringify_row(position):
        return ('_' * position) + '*' + ('_' * (n - position - 1))
    return '\n'.join(map(stringify_row, state))


def neighbour_hits(state, n, queen_row, queen_col):
    def is_row_hit(col):
        return state[col] == queen_row

    def is_diagonal_hit(col):
        return abs(col - queen_col) == abs(state[col] - queen_row)

    def is_hit(col):
        return is_row_hit(col) or is_diagonal_hit(col)

    return sum(map(lambda q: 1 if is_hit(q) else 0,
                   [col for col in range(n) if col != queen_col]))


def pick_index(state, predicate, n):
    return random.choice(filter(
        lambda col: predicate(state[col]), range(n)))


def generate_next_conflicts(state, n, column):
    # we can stay in the current row
    return [neighbour_hits(state, n, row, column) for row in range(n)]


def min_conflicts(n, iterations=1000):
    solution = range(n)
    random.shuffle(solution)

    for i in range(iterations):
        conflicts = [neighbour_hits(solution, n, solution[col], col)
                     for col in range(n)]

        if sum(conflicts) == 0:
            return solution

        # pick a column with conflicts
        column = pick_index(conflicts, lambda conflicts: conflicts > 0, n)

        # generate next possible row moves for the queen in that column
        next_move_conflicts = generate_next_conflicts(solution, n, column)

        # find move with minimal conflicts, we can stay at current solution
        optimal_move = min(next_move_conflicts)

        # move queen in row with minimal conflicts
        solution[column] = pick_index(next_move_conflicts,
                                      lambda x: x == optimal_move, n)

    raise Exception('Solution not found. Try again!')


def main():
    # n = input('Enter N: ')
    n = 8
    try:
        solution = min_conflicts(n)
        print(stringify(solution, n))
    except Exception as e:
        print e.message


if __name__ == '__main__':
    main()
