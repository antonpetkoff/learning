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

int manhattan_distance_to_goal(const config& conf) {
    int size = (int) conf.tiles.size();
    int total_distance = 0;

    for (int pos = 0; pos < size; ++pos) {
        tile t = conf.tiles[pos];
        int target_pos = t == 0 ? size - 1 : t - 1;
        int diffX = abs(target_pos % size - pos % size);  // compare distances from left border
        int diffY = abs(target_pos / size - pos / size);  // compare distances from top border
        total_distance += diffX + diffY;
    }

    return total_distance / 2;  // remove duplicates
}

void sliding_blocks() {
    int game_size;
    cin >> game_size;                // e.g. 8-puzzle
    tiles_count = game_size + 1;  // there are 9 squares

    vector<tile> tiles((size_t) tiles_count);
    for (tile& t : tiles) {
        cin >> t;
    }
    config start(tiles);

    cout << start << endl;
    cout << manhattan_distance_to_goal(start) << endl;
}

int main(int argc, const char* const* argv) {
    sliding_blocks();

    cout << "Running tests..." << endl;
    doctest::Context ctx;
    ctx.applyCommandLine(argc, argv);
//    int test_results = ctx.run();
//    return test_results;
    return 0;
}

TEST_CASE("manhattan distance example from wikipedia") {
    // https://en.wikipedia.org/wiki/Admissible_heuristic
    vector<tile> tiles = {
            4, 6, 3, 8,
            7, 12, 9, 14,
            15, 13, 1, 5,
            2, 10, 11, 0
    };
    config conf(tiles);
    int distance = manhattan_distance_to_goal(conf);
    CHECK(distance == 36);
}
