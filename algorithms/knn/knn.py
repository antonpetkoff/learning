#!/usr/bin/env python3

from __future__ import division
import csv
import random
from math import ceil, sqrt
from collections import Counter
from statistics import mean


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
    split_pivot = int(ceil(test_size * len(data)))   # 20 percent are test data
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


def chunk(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


def cross_validation_score(data, k=3, chunk_count=10, random_seed=42):
    data_set = data[:]
    random.seed(random_seed)
    random.shuffle(data_set)
    splits = list(chunk(data_set, chunk_count))
    test_scores = []

    for index, split in enumerate(splits):
        test_set = split
        train_set = sum([x for i, x in enumerate(splits) if i != index], [])
        test_scores.append(accuracy(train_set, test_set, k))

    return mean(test_scores)
    # return test_scores


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
k_scores = [(k, cross_validation_score(data, k)) for k in range(1, 50)]
best_k = sorted(k_scores, key=lambda x: -x[1])[0][0]
print("best k is " + str(best_k))

# for random_state=42
# k equal to 11 gives 0.98 testing accuracy
# when cross-validation is done with 10 splits

train_set, test_set = train_test_split(data, test_size=0.2, random_seed=42)
for sample in test_set:
    prediction = predict(train_set, sample, k=best_k)
    print("sample %s is labeled as %s" % (str(sample), prediction))
