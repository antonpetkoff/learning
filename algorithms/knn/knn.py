#!/usr/bin/env python3

from __future__ import division
import csv
import random
from math import ceil, sqrt
from collections import Counter


def read_iris(filename):
    data = []
    with open(filename, 'r') as csvfile:
        data_set = csv.reader(csvfile, delimiter=',')
        for sample in data_set:
            data.append(list(map(float, sample[:4])) + [sample[4]])
    return data


def train_test_split(data, test_size=0.2, random_seed=42):
    random.seed(random_seed)
    indices = list(range(len(data)))
    random.shuffle(indices)
    split_pivot = int(ceil(0.2 * len(data)))   # 20 percent are test data
    test_set = list(map(lambda i: data[i], indices[:split_pivot]))
    train_set = list(map(lambda i: data[i], indices[split_pivot:]))
    return (train_set, test_set)


def get_features(sample):
    return sample[:4]


def get_label(sample):
    return sample[4]


def euclidian_distance(sample1, sample2):
    return sqrt(sum(map(lambda t: (t[0] - t[1]) ** 2,
                        zip(get_features(sample1), get_features(sample2)))))


def predict(train_set, sample, k=3, distance=euclidian_distance):
    k_nearest = sorted(train_set, key=lambda s: distance(s, sample))[:k]
    return Counter(map(get_label, k_nearest)).most_common(1)[0][0]


def accuracy(train_set, test_set, k=3):
    matches = map(lambda s: predict(train_set, s, k) == get_label(s), test_set)
    return Counter(matches)[True] / len(test_set)
    # return Counter(matches)[True]


# Attribute Information:
# 1. sepal length in cm
# 2. sepal width in cm
# 3. petal length in cm
# 4. petal width in cm
# 5. class:
# -- Iris Setosa
# -- Iris Versicolour
# -- Iris Virginica
data = read_iris('iris.csv')
train_set, test_set = train_test_split(data, test_size=0.2, random_seed=42)
print(accuracy(train_set, test_set, 3))
