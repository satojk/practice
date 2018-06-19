from bayes import bayes
from logistic import logistic

_TOTAL_FEATURES = 0
_TOTAL_TRAINING_POINTS = 0
_TOTAL_TESTING_POINTS = 0

def parse_data(filename, is_training):
    global _TOTAL_FEATURES
    global _TOTAL_TRAINING_POINTS
    global _TOTAL_TESTING_POINTS
    a0s = 0
    a1s = 0
    data = []
    with open(filename, "r") as f:
        _TOTAL_FEATURES = int(f.readline())
        if (is_training): _TOTAL_TRAINING_POINTS = int(f.readline())
        else: _TOTAL_TESTING_POINTS = int(f.readline())
        for line in f:
            d = line.split(":")
            data.append((tuple([int(x) for x in d[0].split(" ")]),
                               int(d[1].strip())))
            if int(d[1].strip()): a1s += 1
            else: a0s += 1
    if is_training: datatype = "training"
    else: datatype = "testing"

    print("0s in {} data: {}".format(datatype, a0s))
    print("1s in {} data: {}".format(datatype, a1s))
    return data

def main():
    print("Training and testing Logistic Regression and Naive Bayes with " +
          "both Maximum Likelihood Estimator as well as Laplacian Estimators\n\n")
    for dataset in ["simple", "vote", "heart"]:
        print("\nFor dataset {}:".format(dataset))
        training = parse_data("{}-train.txt".format(dataset), True)
        testing  = parse_data("{}-test.txt".format(dataset), False)
        print("\nNaive Bayes:")
        bayes(_TOTAL_FEATURES, _TOTAL_TRAINING_POINTS, _TOTAL_TESTING_POINTS,
          training, testing)
        print("\nLogistic Regression:")
        logistic(_TOTAL_FEATURES, _TOTAL_TRAINING_POINTS, _TOTAL_TESTING_POINTS,
          training, testing, 0.000001)

    print("Training and testing Logistic Regression with multiple learning rates")
    dataset = "heart"
    print("\nFor dataset {}:".format(dataset))
    training = parse_data("{}-train.txt".format(dataset), True)
    testing  = parse_data("{}-test.txt".format(dataset), False)
    for rate in [0.000001, 0.00002, 0.0001, 0.0002, 0.0005, 0.001, 0.002, 0.01]:
        print("Rate: {}".format(rate))
        logistic(_TOTAL_FEATURES, _TOTAL_TRAINING_POINTS, _TOTAL_TESTING_POINTS,
          training, testing, rate)

if __name__ == "__main__":
    main()
