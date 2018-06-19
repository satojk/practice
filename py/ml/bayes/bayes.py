import copy
import math

def bayes(_TOTAL_FEATURES, _TOTAL_TRAINING_POINTS, _TOTAL_TESTING_POINTS,
          training, testing):
    
    # mle is a array of 2x2 matrices, where each matrix represents the PMF
    # for a given feature (0, 1, on the horizontal axis) and Y value (0, 1, on
    # the vertical axis
    mle =[]
    mley = [0.0, 0.0]
    lap = []
    lapy = [1.0, 1.0]
    for i in range(_TOTAL_FEATURES):
        mle.append([[0.0,0.0], [0.0,0.0]])
        lap.append([[1.0,1.0], [1.0,1.0]])
    for features, cat in training:
        mley[cat] += 1.0
        lapy[cat] += 1.0
        for ix, feature in enumerate(features):
            mle[ix][cat][feature] += 1.0
            lap[ix][cat][feature] += 1.0

    for i in range(_TOTAL_FEATURES):
        for j in range(2):
            for k in range(2):
                mle[i][j][k] = mle[i][j][k] / _TOTAL_TRAINING_POINTS
                lap[i][j][k] = lap[i][j][k] / (_TOTAL_TRAINING_POINTS + 4.0)
    for i in range(2):
        mley[i] = mley[i] / _TOTAL_TRAINING_POINTS
        lapy[i] = lapy[i] / (_TOTAL_TRAINING_POINTS + 2.0)

    print("Priors for MLE Y:", mley)
    print("Priors for Lap Y:", lapy)

    mlecorrect = 0.0
    mleans = []
    lapcorrect = 0.0
    lapans = []

    for features, cat in testing:
        mleprob0 = copy.copy(mley[0])
        mleprob1 = copy.copy(mley[1])
        lapprob0 = copy.copy(lapy[0])
        lapprob1 = copy.copy(lapy[1])
        for ix, feature in enumerate(features):
            mleprob0 *= mle[ix][0][feature]/mley[0]
            mleprob1 *= mle[ix][1][feature]/mley[1]
            lapprob0 *= lap[ix][0][feature]/lapy[0]
            lapprob1 *= lap[ix][1][feature]/lapy[1]
        if mleprob0 > mleprob1: mleans.append(0)
        else: mleans.append(1)
        if lapprob0 > lapprob1: lapans.append(0)
        else: lapans.append(1)

    for i in range(_TOTAL_TESTING_POINTS):
        if mleans[i] == testing[i][1]: mlecorrect += 1.0
        if lapans[i] == testing[i][1]: lapcorrect += 1.0
    print("MLE Accuracy: {}".format(mlecorrect/_TOTAL_TESTING_POINTS))
    print("Lap Accuracy: {}".format(lapcorrect/_TOTAL_TESTING_POINTS))

