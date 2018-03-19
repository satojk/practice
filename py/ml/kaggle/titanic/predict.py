from sklearn.ensemble import AdaBoostClassifier
from copy import deepcopy
import pandas as pd

def age_range(age):
    if age < 4:
        return 1
    elif age < 15:
        return 2
    elif age < 25:
        return 3
    elif age < 50:
        return 4
    else:
        return 5

df = pd.read_csv('train.csv')
df['Age'] = df['Age'].apply(age_range)
x_df = df[['Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Embarked']]
x_df.fillna(value=0, inplace=True)
x_df = pd.get_dummies(x_df)
del x_df['Embarked_0']
y_df = df['Survived']
x_df.to_csv('x.csv')

df = pd.read_csv('test.csv')
df['Age'] = df['Age'].apply(age_range)
ids = deepcopy(df['PassengerId'])
x_test = df[['Pclass', 'Sex', 'Age', 'SibSp', 'Parch', 'Embarked']]
x_test.fillna(value=0, inplace=True)
x_test = pd.get_dummies(x_test)
x_test.to_csv('xt.csv')

predictor = AdaBoostClassifier()
predictor.fit(x_df.values, y_df.values)
ans = predictor.predict(x_test.values)

ans_df = pd.DataFrame({'ids':ids.values, 'ans':ans})
ans_df.to_csv('ans.csv')
