theoreticalProb = factorial(97) * choose(100, 3) / factorial(100);

experiment = function () {
  permutation = sample(100);
  !is.unsorted(match(c(20, 12, 16), permutation));
};

simulation = function (size) {
  sample = simple.sim(size, experiment);
  length(sample[sample == 1]) / size;
};

sims = simple.sim(100, simulation, 1e4);
mean(sims);

# 1 simulation with 1e6 experiments = 0.16687
# 10 simulations with 1e5 experiments = 0.166737
# 100 simulations with 1e4 experiments = 0.166893
