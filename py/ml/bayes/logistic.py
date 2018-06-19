import math

def logistic(_TOTAL_FEATURES, _TOTAL_TRAINING_POINTS, _TOTAL_TESTING_POINTS,
             training, testing, rate):
    for i in range(_TOTAL_TRAINING_POINTS):
        training[i] = ([1] + list(training[i][0]), training[i][1])
    for i in range(_TOTAL_TESTING_POINTS):
        testing[i] = ([1] + list(testing[i][0]), testing[i][1])
    _TOTAL_FEATURES += 1
    betas = []
    for i in range(_TOTAL_FEATURES):
        betas.append(0.0)
    print("Starting epoch {}".format(1), end="", flush=True)
    for i in range(10000):
        print("\r                      \r", end="", flush=True)
        print("Starting epoch {}".format(i), end="", flush=True)
        gradients = []
        for j in range(_TOTAL_FEATURES):
            gradients.append(0.0)
        for features, val in training:
            z = sum([features[x]*betas[x] for x in range(_TOTAL_FEATURES)])
            for j in range(_TOTAL_FEATURES):
                gradients[j] += features[j]*(val - (1.0/(1+math.exp(-z))))
        for ix in range(_TOTAL_FEATURES):
            betas[ix] += rate*gradients[ix]
    
    num_correct = 0.0
    predicts = []
    for features, val in testing:
        z = sum([features[x]*betas[x] for x in range(_TOTAL_FEATURES)])
        if 1/(1+math.exp(-z)) > 0.5:
            predicts.append(1)
        else:
            predicts.append(0)

    for ix, suite in enumerate(testing):
        if predicts[ix] == suite[1]:
            num_correct += 1.0
    print("\nAccuracy: {}".format(num_correct/_TOTAL_TESTING_POINTS))

