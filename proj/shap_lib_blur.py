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


masker_blur = shap.maskers.Image("blur(16,32)", X[0].shape)
class_names=['benign','malignant']
explainer_blur = shap.Explainer(test_with_single_input_7200_hot_shap, masker_blur, output_names=class_names)

# here we explain two images using 300 evaluations of the underlying model to estimate the SHAP values
shap_values_fine = explainer_blur(X, max_evals=500, batch_size=100, outputs=shap.Explanation.argsort.flip[:2])


shap_values_fine.data = shap_values_fine.data[0]
shap_values_fine.values = [val for val in np.moveaxis(shap_values_fine.values[0],-1, 0)]


shap.image_plot(shap_values=shap_values_fine.values,
                pixel_values=shap_values_fine.data,
                labels=shap_values_fine.output_names)
