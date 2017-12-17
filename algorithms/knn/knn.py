import csv
import random
import math

SEED = 42
random.seed(SEED)
data = []

with open('iris.csv', 'rb') as csvfile:
    data_set = csv.reader(csvfile, delimiter=',')
    for sample in data_set:
        data.append(sample)

indices = range(len(data))
random.shuffle(indices)
split_pivot = int(math.ceil(0.2 * len(data)))   # 20 percent are test data
test_set = map(lambda i: data[i], indices[0:split_pivot])
train_set = map(lambda i: data[i], indices[split_pivot:])
