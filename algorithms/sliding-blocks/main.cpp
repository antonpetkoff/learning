#define DOCTEST_CONFIG_IMPLEMENT
#include "doctest.h"
#include <iostream>
#include <algorithm>
#include <vector>
#include <cmath>
#include <queue>
#include <functional>
#include <unordered_set>
#include <map>
#include <stack>

using namespace std;

template <typename T>
bool contains(const vector<T>& list, const T& item) {
    return find(list.begin(), list.end(), item) != list.end();
}

int tiles_count;

typedef int tile;
struct config {
public:
    vector<tile> tiles;
    int blank_tile_index;

    config() {
        blank_tile_index = -1;
    }

    config(const vector<tile> &_tiles, int _blank_tile_index = -1) : tiles(_tiles) {
        if (_blank_tile_index == -1) {
            auto blank_index = find(tiles.begin(), tiles.end(), 0);
            blank_tile_index = (int) (blank_index - tiles.begin());
        } else {
            blank_tile_index = _blank_tile_index;
        }
    }

    int get_blank_row(int grid_size) const {
        return blank_tile_index == -1 ? -1 : blank_tile_index / grid_size;
    }

    int get_blank_column(int grid_size) const {
        return blank_tile_index == -1 ? -1 : blank_tile_index % grid_size;
    }

    bool operator==(const config& other) const {
        return tiles == other.tiles && blank_tile_index == other.blank_tile_index;
    }

    bool operator!=(const config& other) const {
        return !operator==(other);
    }

    bool operator<(const config& other) const {
        return tiles < other.tiles;
    }

    friend ostream& operator<<(ostream& out, const config& conf) {
        const int n = (int) sqrt(conf.tiles.size());
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

struct config_hash {
    size_t operator()(const config& conf) const {
        std::hash<tile> hash_fn;
        size_t seed = 0;
        for (int tile : conf.tiles) {
            seed ^= hash_fn(tile) + 0x9e3779b9 + (seed<<6) + (seed>>2);
        }
        return seed;
    }
};

// distance is zero
bool is_goal(const config& conf) {
    size_t size = conf.tiles.size();
    for (int i = 0; i < size; ++i) {
        if (conf.tiles[i] != (i + 1) % size) {
            return false;
        }
    }
    return true;
}

int manhattan_distance_to_goal(const config& conf, int grid_size) {
    int size = (int) conf.tiles.size();
    int total_distance = 0;

    for (int pos = 0; pos < size; ++pos) {
        tile t = conf.tiles[pos];
        int target_pos = t == 0 ? size - 1 : t - 1;
        int diffX = abs(target_pos % grid_size - pos % grid_size);  // compare distances from left border
        int diffY = abs(target_pos / grid_size - pos / grid_size);  // compare distances from top border
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
 * @return zero-based row number of blank tile in tiles, counting from the top
 */
int get_blank_tile_row(const vector<tile>& tiles, int grid_size) {
    for (int pos = (int)(tiles.size() - 1); pos >= 0; --pos) {
        if (tiles[pos] == 0) {
            return pos / grid_size;
        }
    }
}

inline bool is_odd(int n) { return n % 2 == 1; }

inline bool is_even(int n) { return !is_odd(n); }

bool is_solvable(const config& conf, int grid_size) {
    int inversions_count = count_inversions(conf.tiles);

    if (is_odd(grid_size)) {
        return is_even(inversions_count);
    }

    int blank_tile_row = get_blank_tile_row(conf.tiles, grid_size);

    return is_odd(blank_tile_row) == is_odd(inversions_count);
}

vector<config> generate_moves(const config& conf, int grid_size) {
    vector<config> moves;

    for (auto offset : {make_pair(-1, 0), make_pair(0, 1), make_pair(1, 0), make_pair(0, -1)}) {
        int row_offset = offset.first;
        int col_offset = offset.second;
        int next_blank_pos = conf.blank_tile_index + grid_size * row_offset + col_offset;

        if (0 <= next_blank_pos && next_blank_pos < conf.tiles.size()) {
            vector<tile> new_tiles(conf.tiles);
            swap(new_tiles[conf.blank_tile_index], new_tiles[next_blank_pos]);
            moves.push_back(config(new_tiles, next_blank_pos));
        }
    }

    return moves;
}

config NULL_CONFIG = config();

string get_transition(const config& from, const config& to, int grid_size) {
    int from_row = from.get_blank_row(grid_size);
    int from_col = from.get_blank_column(grid_size);
    int to_row = to.get_blank_row(grid_size);
    int to_col = to.get_blank_column(grid_size);

    string direction;

    if (from_row < to_row) {
        direction = "up";
    } else if (from_row > to_row) {
        direction = "down";
    } else if (from_col < to_col) {
        direction = "left";
    } else if (from_col > to_col) {
        direction = "right";
    }

    return direction;
}

stack<string> construct_moves(const config& goal, map<config, config>& cameFrom, int grid_size) {
    stack<string> moves;
    config current = goal;
    config previous = cameFrom[current];

    while (previous != NULL_CONFIG) {
        string transition = get_transition(previous, current, grid_size);
        moves.push(transition);
        current = previous; // we move back in time
        previous = cameFrom[previous];
    }

    return moves;
}

stack<config> construct_path(const config& goal, map<config, config>& cameFrom) {
    stack<config> path;
    config previous = goal;

    while (previous != NULL_CONFIG) {
        path.push(previous);
        previous = cameFrom[previous];
    }

    return path;
}

int a_star(const config& start, int grid_size) {
    // distance measures how much changes we made already on the start
    // the heuristic measures how far is the config from the goal
    typedef tuple<int, int, config, config> state;
    unordered_set<config, config_hash> visited;
    priority_queue<state, vector<state>, greater<state>> queue;
    map<config, config> parent;

    queue.push(make_tuple(
        0 + manhattan_distance_to_goal(start, grid_size),
        0,
        start,
        NULL_CONFIG
    ));

    while (!queue.empty()) {
        state current = queue.top(); queue.pop();
        int distance = get<1>(current);
        config conf = get<2>(current);
        visited.insert(conf);

        if (is_goal(conf)) {
            stack<string> moves = construct_moves(conf, parent, grid_size);
            while (!moves.empty()) {
                cout << moves.top() << endl;
                moves.pop();
            }

//            stack<config> path = construct_path(conf, parent);
//            while (!path.empty()) {
//                cout << path.top() << endl;
//                path.pop();
//            }
            return distance;
        }

        for (config next : generate_moves(conf, grid_size)) {
            if (visited.find(next) != visited.end()) {
                continue;
            }

            queue.push(make_tuple(
                distance + 1 + manhattan_distance_to_goal(next, grid_size),
                distance + 1,
                next,
                conf
            ));
            parent[next] = conf;
        }
    }

    return -1;
}

void sliding_blocks() {
    int game_size;
    cin >> game_size;                // e.g. 8-puzzle
    int tiles_count = game_size + 1;  // there are 9 squares
    int grid_size = (int) sqrt(tiles_count);

    vector<tile> tiles((size_t) tiles_count);
    for (tile& t : tiles) {
        cin >> t;
    }
    config start(tiles);

//    cout << start << endl;
//    cout << manhattan_distance_to_goal(start, game_size) << endl;
    a_star(start, grid_size);
}

int main(int argc, const char* const* argv) {
    int run_tests = false;

    if (run_tests) {
        doctest::Context ctx;
        ctx.applyCommandLine(argc, argv);
        return ctx.run();
    } else {
        sliding_blocks();
        return 0;
    }
}

TEST_CASE("manhattan distance to goal configuration") {
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

TEST_CASE("check if puzzle is solvable") {
    CHECK(is_solvable(config(vector<tile>({1, 2, 3,
                                           4, 0, 5,
                                           6, 7, 8})), 3));

    CHECK(!is_solvable(config(vector<tile>({1, 2, 3,
                                            4, 4, 5,
                                            8, 7, 0})), 3));

    CHECK(!is_solvable(config(vector<int>({1  , 2  , 3  , 4  ,
                                           5  , 6  , 7  , 8  ,
                                           9  , 10 , 11 , 15 ,
                                           13 , 14 , 12 , 0})), 4));

    CHECK(!is_solvable(config(vector<int>({1  , 2  , 3  , 4  ,
                                           5  , 6  , 7  , 8  ,
                                           9  , 10 , 11 , 12 ,
                                           13 , 15 , 14 , 0})), 4));

    CHECK(is_solvable(config(vector<int>({1  , 2  , 3  , 4  ,
                                          5  , 6  , 7  , 8  ,
                                          9  , 10 , 11 , 12 ,
                                          13 , 14 , 15 , 0})), 4));
}

TEST_CASE("calculate blank tile index in configuration") {
    CHECK(3 == config(vector<int>({1, 2, 3, 0, 5})).blank_tile_index);
    CHECK(3 == config(vector<int>({1, 2, 3, 0, 5}), 3).blank_tile_index);
    CHECK(1 == config(vector<int>({1, 0, 3, 2, 5})).blank_tile_index);
    CHECK(1 == config(vector<int>({1, 0, 3, 8, 5}), 1).blank_tile_index);
    CHECK(6 == config(vector<int>({1, 2, 3, 12, 5, 10, 0})).blank_tile_index);
}

TEST_CASE("generate next configurations") {
    vector<config> moves = generate_moves(config(vector<int>({1, 2, 3,
                                                              4, 0, 6,
                                                              7, 5, 8})), 3);

    CHECK(4 == moves.size());

    CHECK(contains<config>(moves, config(vector<int>({1, 0, 3,
                                                      4, 2, 6,
                                                      7, 5, 8}))));

    CHECK(contains<config>(moves, config(vector<int>({1, 2, 3,
                                                      0, 4, 6,
                                                      7, 5, 8}))));

    CHECK(contains<config>(moves, config(vector<int>({1, 2, 3,
                                                      4, 6, 0,
                                                      7, 5, 8}))));

    CHECK(contains<config>(moves, config(vector<int>({1, 2, 3,
                                                      4, 5, 6,
                                                      7, 0, 8}))));
}

TEST_CASE("a star finds distance to goal") {
    int distance_to_goal = a_star(config(vector<tile>({1, 2, 3,
                                                       4, 5, 6,
                                                       0, 7, 8})), 3);

    CHECK(distance_to_goal == 2);

    distance_to_goal = a_star(config(vector<tile>({5,1,7,3,
                                                   9,2,11,4,
                                                   13,6,15,8,
                                                   0,10,14,12})), 4);
    // TODO: not sure about the optimiality here
    CHECK(distance_to_goal == 15);
}
