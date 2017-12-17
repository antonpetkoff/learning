#!/usr/bin/env python3

from __future__ import division
import csv
import copy
import random
from math import ceil
from collections import Counter
from statistics import mean


def read_votes(filename):
    data = []
    with open(filename, 'r') as csvfile:
        data_set = csv.reader(csvfile, delimiter=',')
        for sample in data_set:
            data.append(sample)
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
    return sample[:16]


def get_label(sample):
    return sample[16]


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


def get_feature_probabilities(data):
    feature_count = len(data[0]) - 1
    freq = {}
    for feature_id in range(feature_count):
        freq[feature_id] = {}
        for value in ['y', 'n', '?']:
            freq[feature_id][value] = {}
            for label in ['republican', 'democrat']:
                freq[feature_id][value][label] = 0

    for sample in data:
        label = get_label(sample)
        for feature_id, value in enumerate(get_features(sample)):
            freq[feature_id][value][label] += 1

    probs = copy.deepcopy(freq)
    for feature_id in range(feature_count):
        for label in ['republican', 'democrat']:
            total = 0
            for value in ['y', 'n', '?']:
                total += freq[feature_id][value][label]

            for value in ['y', 'n', '?']:
                prob = freq[feature_id][value][label] / total
                probs[feature_id][value][label] = prob

    return probs


def get_class_probabilities(data):
    total = len(data)
    freq = Counter(map(get_label, data))
    return {
        'republican': freq['republican'] / total,
        'democrat': freq['democrat'] / total
    }


data = read_votes('votes.csv')
print(get_feature_probabilities(data))
print(get_class_probabilities(data))
