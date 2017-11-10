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


def main():
    n = 8
    state = range(n)
    print(stringify(state, n))
    state = range(n)
    print(state)
    print(neighbour_hits(state, n, 3, 3))


if __name__ == '__main__':
    main()
