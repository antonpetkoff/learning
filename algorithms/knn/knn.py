import csv
import random
from math import ceil, sqrt

SEED = 42
random.seed(SEED)

# Attribute Information:
# 1. sepal length in cm
# 2. sepal width in cm
# 3. petal length in cm
# 4. petal width in cm
# 5. class:
# -- Iris Setosa
# -- Iris Versicolour
# -- Iris Virginica
data = []

with open('iris.csv', 'rb') as csvfile:
    data_set = csv.reader(csvfile, delimiter=',')
    for sample in data_set:
        data.append(list(map(float, sample[:4])) + [sample[4]])

indices = range(len(data))
random.shuffle(indices)
split_pivot = int(ceil(0.2 * len(data)))   # 20 percent are test data
test_set = map(lambda i: data[i], indices[:split_pivot])
train_set = map(lambda i: data[i], indices[split_pivot:])

k = 3


def euclidian_distance(sample1, sample2):
    return sqrt(sum(map(lambda t: (t[0] - t[1]) ** 2,
                        zip(sample1[:4], sample2[:4]))))


def predict(train_set, sample, k=3, distance=euclidian_distance):
    return sorted(train_set, key=lambda s: distance(s, sample))[:k]
