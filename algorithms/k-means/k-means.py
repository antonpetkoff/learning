#!/usr/bin/env python3

from __future__ import division
import random
from statistics import mean

import seaborn as sns
import pandas as pd

from copy import deepcopy


def euclidian_distance(sample1, sample2):
    result = sum(map(lambda t: (t[0] - t[1]) ** 2,
                     zip(sample1, sample2)))
    # print(result)
    return result


# def predict(train_set, sample, k=3, distance=euclidian_distance):
#     k_nearest = sorted(train_set, key=lambda s: distance(s, sample))[:k]
#     return Counter(map(get_label, k_nearest)).most_common(1)[0][0]


def read_points(filename):
    with open(filename) as file:
        content = file.readlines()
    return [list(map(float, x.strip().split('\t', 2))) for x in content]


def mean(points):
    count = len(points)
    sum_x1 = sum([point[0] for point in points])
    sum_x2 = sum([point[1] for point in points])
    return [sum_x1 / count, sum_x2 / count]


def train(data_set, k, max_iterations=10, dist=euclidian_distance):
    # total distance between 2 vector of points
    def vector_dist(vector1, vector2):
        return sum(map(lambda t: dist(t[0], t[1]),
                       zip(vector1, vector2)))

    random.shuffle(data_set)
    clusters = [0 for _ in range(len(data_set))]
    centroids = data_set[:k]    # TODO: we chose points from the data set
    centroids_old = [[0, 0] for _ in range(k)]
    error = vector_dist(centroids, centroids_old)
    iterations = 0

    while error != 0 or iterations < max_iterations:
        # assign each sample to its closest cluster (nearest centroid)
        for sample_id in range(len(data_set)):
            nearest_centroid = min(centroids,
                                   key=lambda c: dist(data_set[sample_id], c))
            cluster_index = centroids.index(nearest_centroid)
            clusters[sample_id] = cluster_index

        centroids_old = deepcopy(centroids)

        # for each cluster assign a new centroid
        for cluster_id in range(k):
            points = [data_set[sample_id]
                      for sample_id in range(len(data_set))
                      if clusters[sample_id] == cluster_id]
            centroids[cluster_id] = mean(points)

        error = vector_dist(centroids, centroids_old)
        iterations += 1

    print("finished in %d iterations" % iterations)
    return centroids


random_seed = 42
vectors = read_points('normal/normal.txt')
random.seed(random_seed)

print(train(vectors, 4))
