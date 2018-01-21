#!/usr/bin/env python3

from __future__ import division
import csv
import random
from collections import Counter
from statistics import mean
from math import log
from operator import itemgetter
from pprint import PrettyPrinter


def read_data(filename):
    data = []
    with open(filename, 'r') as csvfile:
        data_set = csv.reader(csvfile, delimiter=',')
        for sample in data_set:
            data.append(sample)
    return data


def get_features(sample):
    return sample[:FEATURE_COUNT]


def get_label(sample):
    return sample[FEATURE_COUNT]


def accuracy(train_set, test_set, predict):
    matches = map(lambda s: predict(s) == get_label(s), test_set)
    return Counter(matches)[True] / len(test_set)


def chunk(l, n):
    """Yield successive n-sized chunks from l."""
    for i in range(0, len(l), n):
        yield l[i:i + n]


def cross_validation_score(data, predict, chunk_count=10, random_seed=42):
    data_set = data[:]
    random.seed(random_seed)
    random.shuffle(data_set)
    splits = list(chunk(data_set, chunk_count))
    test_scores = []

    for index, split in enumerate(splits):
        test_set = split
        train_set = sum([x for i, x in enumerate(splits) if i != index], [])
        test_scores.append(accuracy(train_set, test_set, predict))

    return mean(test_scores)


# takes a list of values
def entropy(data):
    counts = Counter(data).most_common()
    return sum([-proportion * log(proportion, 2)
                for proportion in
                map(lambda count: count[1] / len(data), counts)])


def information_gain(samples, attribute_id):
    samples_len = len(samples)
    unique_attribute_values = set(map(itemgetter(attribute_id), samples))
    labels_by_attr_value = {value: list(map(get_label,
                                            filter(lambda x: x[attribute_id] == value, samples)))
                            for value in unique_attribute_values}

    gain = entropy(list(map(get_label, samples)))
    gain -= sum([(len(labels) / samples_len) * entropy(labels)
                 for labels in labels_by_attr_value.values()])
    return (gain, labels_by_attr_value)


def most_frequent_label(examples):
    return Counter(map(get_label, examples)).most_common(1)[0][0]


def make_tree(examples, attributes, parent_examples):
    # TODO: min_examples per leaf parameter
    if examples == []:  # no samples to split are left
        return most_frequent_label(parent_examples)
    # examples consist of only 1 label
    if len(set(map(get_label, examples))) == 1:
        return get_label(examples[0])
    if attributes == []:    # no attributes to split on are left
        return most_frequent_label(parent_examples)

    # calculate information gain for each attribute
    gains_by_attribute = [(information_gain(examples, attribute_id),
                           attribute_id)
                          for attribute_id in attributes]

    # print(list(map(lambda x: x[0][0], gains_by_attribute)))

    if all([gain < 1e-6
            for (gain, _), _ in gains_by_attribute]):
        return most_frequent_label(parent_examples)

    # choose attribute (id) with max gain
    (_, labels), attribute_id = sorted(gains_by_attribute, key=lambda x: x[0][0], reverse=True)[0]

    attribute_values = set(map(itemgetter(attribute_id),
                               examples))

    rest_of_the_attributes = attributes[:]
    rest_of_the_attributes.remove(attribute_id)

    return {attribute_id: [(value,
                            make_tree(list(filter(lambda x: x[attribute_id] == value, examples)),
                                      rest_of_the_attributes,
                                      examples))
                           for value in attribute_values]}

# TODO: randomforest or pre/post-pruning for fighting overfitting

# class = string
# tree = {split_attribute_in_node: [(attribute_value, tree|class)]}

# {'Outlook': [
#     ('Sunny', {'Humidity': [
#         ('High', 'No'),
#         ('Normal', 'Yes')
#     ]}),
#     ('Overcast', 'Yes'),
#     ('Rain', {'Wind': []})
# ]}


def predict(tree, sample):
    if isinstance(tree, str):
        return tree
    if isinstance(tree, dict):
        attribute_id = list(tree.keys())[0]
        subtree = next(subtree for attr_value, subtree in tree[attribute_id]
                       if attr_value == str(sample[attribute_id]))
        return predict(subtree, sample)


FEATURE_COUNT = 9
data = read_data('breast-cancer.csv')

tree = make_tree(data, list(range(FEATURE_COUNT)), data)

pp = PrettyPrinter(indent=2)
pp.pprint(tree)

# for sample in data:
#     print(get_label(sample), predict(tree, sample))


def predictor(sample):
    return predict(tree, sample)


print(cross_validation_score(data, predictor, chunk_count=10, random_seed=1))
