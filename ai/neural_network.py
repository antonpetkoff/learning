from math import exp
from utils import dot


def sigmoid(t):
    return 1 / (1 + exp(-t))


def neuron_output(inputs, weights):
    return sigmoid(dot(inputs, weights))


def network_output(neural_network, input_vector):
    """the network is a list (layers) of lists (neurons) of lists (weights)"""
    outputs = []    # output of each layer from 1st hidden to output layer

    for layer in neural_network:
        output = [neuron_output(input_vector + [1], neuron)
                  for neuron in layer]
        outputs.append(output)
        input_vector = output

    return outputs


def test_xor_network():
    xor_network = [# hidden layer with 2 neurons
                   [[20, 20, -30],      # AND neuron
                    [20, 20, -10]],     # OR neuron
                   # output layer
                   [[-60, 60, -30]]]    # accept 2nd, but negate 1st input nuron

    for x in [0, 1]:
        for y in [0, 1]:
            # print only the outputs of the output layer
            print(x, y, network_output(xor_network, [x, y]))


def backpropagate(network, input_vector, targets):
    # ???
    hidden_outputs, outputs = network_output(network, input_vector)

    # s'(t) = s(t) * (1 - s(t)), where s(t) = 1 / (1 + e^(-t))
    output_deltas = [output * (1 - output) * (output - target)
                     for output, target in zip(outputs, targets)]

    # adjust weights for output layer, one neuron at a time
    for i, output_neuron in enumerate(network[-1]):
        # focus on the ith output layer neuron
        for j, hidden_output in enumerate(hidden_outputs + [1]):
            # adjust the jth weight based on both
            # this neuron's delta and its jth input
            output_neuron[j] -= output_deltas[i] * hidden_output

    # back-propagate errors to hidden layer
    hidden_deltas = [hidden_output * (1 - hidden_output) *
                     dot(output_deltas, [n[i] for n in network[-1]])
                     for i, hidden_output in enumerate(hidden_outputs)]

    for i, hidden_neuron in enumerate(network[0]):
        for j, input in enumerate(input_vector + [1]):
            hidden_neuron[j] -= hidden_deltas[i] * input


test_xor_network()
