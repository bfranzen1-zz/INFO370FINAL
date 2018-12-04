#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 29 19:04:32 2018

@author: conniehe
"""

from sklearn.ensemble import ExtraTreesRegressor
from sklearn.feature_selection import SelectFromModel
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

import seaborn as sns
from sklearn.model_selection import train_test_split 
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split

from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import cross_val_score

from sklearn.metrics import make_scorer
from sklearn.metrics import mean_absolute_error
from sklearn.model_selection import KFold
from sklearn.ensemble import RandomForestRegressor

from sklearn.feature_selection import SelectKBest
from sklearn.feature_selection import f_regression
from sklearn.feature_selection import mutual_info_regression
from sklearn.neighbors import KNeighborsRegressor    # regressor
from sklearn.model_selection import GridSearchCV     # for grid search
from sklearn.pipeline import make_pipeline   
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.ensemble import ExtraTreesClassifier


def feature_selection(data,target,original, num):
    X1,y1=data,target
    
    clf1=ExtraTreesClassifier(n_estimators=50) #can change
    
    clf1=clf1.fit(X1,y1)
    model1 = SelectFromModel(clf1, prefit=True)
    X1_new = model1.transform(X1)
    
    temp=list(data.columns.values)
    index=np.argsort(clf1.feature_importances_)
    result=[]
    for i in range(len(index)):
        result.append(temp[index[i]])

    df = pd.DataFrame({'r':result, 'index':index})
    df1 = df.loc[df['index']<num] #select based on how many variables you want
    final_list=list(df1['r'])
    print(final_list)
    df_selected=original[final_list] #this is the features
    
    return df_selected


def model_selection_random_forest(df_dropped,df_target,train_features,train_outcome):
        estimator = RandomForestClassifier(class_weight={0: 20, 1: 6,2:6,3:1})
        param_grid = { "n_estimators"      : range(1,10,1),
            "max_features"      : ["auto", "sqrt", "log2"],
            "min_samples_split" : range(10,100,5),
            #"max_leaf_nodes" : range(2,20,1)
            #"bootstrap": [True, False],
            #STEP AND NUM OF NODES
            }

        grid = GridSearchCV(estimator, param_grid, n_jobs=-1, cv=5,return_train_score=True)
        grid.fit(train_features, train_outcome)
        
        print(grid.best_params_)
        
        auto_results = grid.cv_results_['mean_test_score'][grid.cv_results_['param_max_features'].data == "auto"]
        sqrt_results = grid.cv_results_['mean_test_score'][grid.cv_results_['param_max_features'].data == "sqrt"]
        log2_results= grid.cv_results_['mean_test_score'][grid.cv_results_['param_max_features'].data == "log2"]
        
        dim=len(auto_results)+1
        plt.plot(range(1,dim), auto_results, label="auto")
        plt.plot(range(1,dim), sqrt_results, label="sqrt")
        plt.plot(range(1,dim), log2_results, label="log2")
        plt.legend()
        
def get_MAE(best_model,train_features,test_features,train_outcome,test_outcome):
    
    best_model.fit(train_features,train_outcome)
    pred=best_model.predict(test_features)
    score=mean_absolute_error(test_outcome,pred)
    
    return score

def cross_val(train_features,train_outcome,best_model):
    
    #decision_tree_reg = DecisionTreeRegressor(random_state=11)
    folds=KFold(n_splits=10,shuffle=True)
    #print(np.mean(cross_val_score(best_model, train_features, train_outcome, cv = folds)))

    mean=np.mean(cross_val_score(best_model, train_features, train_outcome, cv = folds))
    return mean

