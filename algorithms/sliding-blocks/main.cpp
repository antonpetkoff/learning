#define DOCTEST_CONFIG_IMPLEMENT
#include "doctest.h"
#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

// check if puzzle is solvable
// implement a*
// define heuristic

int tiles_count;
int game_side;

typedef int tile;
struct config {
public:
    vector<tile> tiles;

    config(const vector<tile> &_tiles) : tiles(_tiles) {}

    friend ostream& operator<<(ostream& out, const config& conf) {
        const int n = sqrt(tiles_count);
        for (int row = 0; row < n; ++row) {
            for (int col = 0; col < n; ++col) {
                if (col > 0) {
                    out << ' ';
                }
                out << conf.tiles[n * row + col];
            }
            out << endl;
        }
        return out;
    }
};

// distance is zero
bool isGoal(const config& conf) {
    size_t size = conf.tiles.size();
    for (int i = 0; i < size; ++i) {
        if (conf.tiles[i] != (i + 1) % size) {
            return false;
        }
    }
    return true;
}

int manhattan_distance_to_goal(const config& conf, int game_side) {
    int size = (int) conf.tiles.size();
    int total_distance = 0;

    for (int pos = 0; pos < size; ++pos) {
        tile t = conf.tiles[pos];
        int target_pos = t == 0 ? size - 1 : t - 1;
        int diffX = abs(target_pos % game_side - pos % game_side);  // compare distances from left border
        int diffY = abs(target_pos / game_side - pos / game_side);  // compare distances from top border
        total_distance += diffX + diffY;
    }

    return total_distance;
}

int count_inversions(const vector<tile>& tiles) {
    int count = 0;
    for (int i = 0; i < tiles.size() - 1; ++i) {
        for (int j = i + 1; j < tiles.size(); ++j) {
            if (tiles[i] > tiles[j]) {
                count++;
            }
        }
    }
    return count;
}

/**
 * @param tiles
 * @return zero-based row number of blank tile in tiles
 */
int get_blank_tile_row(const vector<tile>& tiles, int game_side) {
    for (int pos = (int)(tiles.size() - 1); pos >= 0; --pos) {
        if (tiles[pos] == 0) {
            return pos / game_side;
        }
    }
}

bool is_solvable(const config& conf) {

}

void sliding_blocks() {
    int game_size;
    cin >> game_size;                // e.g. 8-puzzle
    tiles_count = game_size + 1;  // there are 9 squares
    game_side = (int) sqrt(tiles_count);

    vector<tile> tiles((size_t) tiles_count);
    for (tile& t : tiles) {
        cin >> t;
    }
    config start(tiles);

    cout << start << endl;
    cout << manhattan_distance_to_goal(start, game_size) << endl;
}

int main(int argc, const char* const* argv) {
    int run_tests = true;

    if (run_tests) {
        doctest::Context ctx;
        ctx.applyCommandLine(argc, argv);
        return ctx.run();
    } else {
        sliding_blocks();
        return 0;
    }
}

TEST_CASE("manhattan distance") {
    // https://en.wikipedia.org/wiki/Admissible_heuristic
    CHECK(36 == manhattan_distance_to_goal(config(vector<tile>({4, 6, 3, 8,
                                                                7, 12, 9, 14,
                                                               15, 13, 1, 5,
                                                                2, 10, 11, 0})), 4));

    CHECK(0 == manhattan_distance_to_goal(config(vector<tile>({1, 2, 3,
                                                               4, 5, 6,
                                                               7, 8, 0})), 3));


    CHECK((2 + 2 + 1 + 1) == manhattan_distance_to_goal(config(vector<tile>({1, 2, 3,
                                                                             4, 0, 6,
                                                                             5, 7, 8})), 3));
}


TEST_CASE("count inversions") {
    CHECK(0 == count_inversions({1, 2, 3, 4, 5, 6}));
    CHECK(3 == count_inversions({3, 2, 1, 4, 5, 6}));
    CHECK(10 == count_inversions({5, 4, 3, 2, 1}));
    CHECK(4 == count_inversions({2, 4, 1, 5, 3}));
}

TEST_CASE("get zero-based row number of blank tile") {
    CHECK(1 == get_blank_tile_row({1, 2, 3,
                                   4, 0, 5,
                                   6, 7, 8}, 3));
    CHECK(2 == get_blank_tile_row({1, 2, 3,
                                   4, 8, 5,
                                   6, 7, 0}, 3));
    CHECK(3 == get_blank_tile_row({1, 2, 3, 10,
                                   4, 9, 5, 11,
                                   6, 7, 8, 12,
                                   13, 14, 15, 0}, 4));
}
