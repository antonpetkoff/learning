library(UsingR);

A = 7;
lambda = 1 / (A + 1);

observe = function (sampleSize, simulationCount) {
  simple.sim(simulationCount, function () {
    mean(rexp(sampleSize, lambda));
  });
};

observe10 = observe(10, 500);
qqnorm(observe10);
qqline(observe10);

observe1000 = observe(1000, 500);
qqnorm(observe1000);
qqline(observe1000);
