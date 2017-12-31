#!/usr/bin/env python3

from copy import deepcopy
from matplotlib import pyplot as plt
import random
import sys

# import seaborn as sns
# import pandas as pd
import numpy as np
from operator import itemgetter

plt.rcParams['figure.figsize'] = (16, 9)
plt.style.use('ggplot')


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
    return [list(map(float, x.strip().replace('\t', ' ').split(' ', 2)))
            for x in content]


def mean(points, default_fn):
    count = len(points)

    if count == 0:
        return default_fn()

    sum_x1 = sum([point[0] for point in points])
    sum_x2 = sum([point[1] for point in points])
    return [sum_x1 / count, sum_x2 / count]


def train(data_set, k, max_iterations=100, dist=euclidian_distance):
    # total distance between 2 vector of points
    def vector_dist(vector1, vector2):
        return sum(map(lambda t: dist(t[0], t[1]),
                       zip(vector1, vector2)))

    min_x = min(data_set, key=lambda t: t[0])[0]
    min_y = min(data_set, key=lambda t: t[1])[1]
    max_x = max(data_set, key=lambda t: t[0])[0]
    max_y = max(data_set, key=lambda t: t[1])[1]
    # print(min_x, min_y, max_x, max_y)

    def get_random_point():
        return [min_x + random.random() * (max_x - min_x),
                min_y + random.random() * (max_y - min_y)]

    random.shuffle(data_set)
    clusters = [0 for _ in range(len(data_set))]
    centroids = [get_random_point() for _ in range(k)]
    # centroids = data_set[:k]    # TODO: we chose points from the data set
    centroids_old = [[0, 0] for _ in range(k)]
    error = vector_dist(centroids, centroids_old)
    iterations = 0

    while error != 0 and iterations < max_iterations:
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
            centroids[cluster_id] = mean(points, get_random_point)

        error = vector_dist(centroids, centroids_old)
        iterations += 1

    # print("finished in %d iterations" % iterations)
    # colors = ['r', 'g', 'b', 'y', 'c', 'm']
    # fig, ax = plt.subplots()
    # for i in range(k):
    #         points = np.array([data_set[j]
    #                           for j in range(len(data_set))
    #                           if clusters[j] == i])
    #         ax.scatter(points[:, 0], points[:, 1], s=7, c=colors[i])
    # # ax.scatter(centroids[:, 0], centroids[:, 1], marker='*', s=200, c='#050505')
    # ax.scatter(list(map(itemgetter(0), centroids)),
    #            list(map(itemgetter(1), centroids)),
    #            marker='*', s=200, c='#050505')

    return centroids


# run as ./k-means.py path/to/data-set.txt 3
# where the seconds arguments is an integer k
def main():
    try:
        filename = sys.argv[1]
        k = int(sys.argv[2])

        random_seed = 2
        vectors = read_points(filename)
        random.seed(random_seed)
        print(train(vectors, k))
    except Exception as e:
        print(e.message)


if __name__ == '__main__':
    main()
