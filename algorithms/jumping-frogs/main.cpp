#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_set>
#include <stack>
#include <map>

using namespace std;

typedef uint8_t position;    // must fit all frogs in a configuration

typedef int8_t frog;

static const frog EMPTY = 0;
static const frog LEFT_MOVING_FROG = -1;
static const frog RIGHT_MOVING_FROG = 1;

typedef vector<frog> frogs_config;

size_t n;

struct config {
    frogs_config frogs;
    position empty_index;

    config() : frogs(frogs_config()), empty_index(0) {}

    config(const frogs_config& _frogs, position _empty_index)
            : frogs(_frogs), empty_index(_empty_index) {}

    bool operator==(const config& other) const {
        return empty_index == other.empty_index && frogs == other.frogs;
    }

    bool operator!=(const config& other) const {
        return !(*this == other);
    }

    bool is_goal() const {
        return empty_index == n && all_of(frogs.cbegin(), frogs.cbegin() + n, [](frog _frog) {
            return _frog == LEFT_MOVING_FROG;
        });
    }

    vector<config> generate_next() const {
        vector<config> result;  // at most 4 configs can be generated
        position start = static_cast<position>(max(empty_index - 2, 0));
        position end = static_cast<position>(min(empty_index + 2, (int)frogs.size()));

        for (position pos = start; pos <= end; ++pos) {
            position distance_to_empty = (position) abs(empty_index - pos);
            position frog_landing_spot = pos + frogs[pos] * distance_to_empty; // the frog jumps

            if (pos != empty_index && frog_landing_spot == empty_index) {
                config next = *this;
                next.empty_index = pos;
                next.frogs[frog_landing_spot] = frogs[pos];
                next.frogs[pos] = EMPTY;
                result.push_back(next);
            }
        }

        return result;
    }

    friend ostream& operator<<(ostream& out, const config& configuration) {
        for (auto frog : configuration.frogs) {
            switch (frog) {
                case LEFT_MOVING_FROG:
                    out << '<';
                    break;
                case RIGHT_MOVING_FROG:
                    out << '>';
                    break;
                case EMPTY:
                    out << '_';
                    break;
                default: break;
            }
        }
        return out;
    }
};

class config_comparator {
public:
    bool operator()(const config& c1, const config& c2) const {
        for (int pos = 0; pos < c1.frogs.size(); ++pos) {
            if (c1.frogs[pos] < c2.frogs[pos]) {
                return true;
            } else if (c1.frogs[pos] > c2.frogs[pos]) {
                return false;
            }
        }
        return false;
    }
};

map<config, config, config_comparator> parent;

config dfs(config start) {
//    unordered_set<config> visited;
    stack<config> configurations;
    configurations.push(start);

    while (!configurations.empty()) {
        config configuration = configurations.top(); configurations.pop();
        if (configuration.is_goal()) {
            return configuration;
        }

//        visited.insert(configuration);
        vector<config> next_moves = configuration.generate_next();
        for (const config& next: next_moves) {
            parent[next] = configuration;
            configurations.push(next);
        }
    }
}

int main() {
    cin >> n;

    frogs_config start = vector<frog>();

    for (int i = 0; i < n; ++i) {
        start.push_back(1);
    }
    start.push_back(0);
    for (int i = 0; i < n; ++i) {
        start.push_back(-1);
    }

    config initial(start, n);
    config goal = dfs(initial);

    stack<config> path;
    config p = goal;
    while (p != initial) {
        path.push(p);
        p = parent[p];
    }
    path.push(initial);

    while (!path.empty()) {
        cout << path.top() << endl;
        path.pop();
    }

    return 0;
}
