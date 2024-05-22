import shap
import cv2
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from  matplotlib.colors import LinearSegmentedColormap
import copy
%matplotlib inline
import skimage.segmentation
from sklearn.linear_model import LinearRegression
from skimage.color import gray2rgb
import os
from PIL import Image

import matlab.engine
eng = matlab.engine.connect_matlab()
eng.cd(r'/Users/nunemunthalashiva/Documents/BTP/xai_thyroid/Code', nargout=0)
eng.plus(2,3)

import shap
X=matplotlib.image.imread('xai_thyroid/Data_temp/datapre/3_1.jpg')
X=gray2rgb(X)
X=np.reshape(X,(1,300,300,3))
X=X.astype(np.float64)

masker = shap.maskers.Image("inpaint_telea", X[0].shape)

explainer = shap.Explainer(test_with_single_input_7200_hot_shap, masker, output_names=['benign','malignant'])

shap_values = explainer(X, max_evals=500, batch_size=50, outputs=shap.Explanation.argsort.flip[:2])
