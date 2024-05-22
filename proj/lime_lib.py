import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from  matplotlib.colors import LinearSegmentedColormap
import copy
%matplotlib inline
import skimage.segmentation
from sklearn.linear_model import LinearRegression
from skimage.color import gray2rgb
import os
from PIL import Image
from lime import lime_image
from skimage.segmentation import mark_boundaries
from skimage.segmentation import clear_border,flood_fill

# connecting with matlab
import matlab.engine
eng = matlab.engine.connect_matlab()
eng.cd(r'/Users/nunemunthalashiva/Documents/BTP/xai_thyroid/Code', nargout=0)
eng.plus(2,3)

#
def test_with_single_input_7200_hot(images):
    #image=skimage.io.imread(image,format='jpeg')
    num_imgs=images.shape[0]
    result=np.zeros((num_imgs,2))
    for i in range(num_imgs):
        image=images[i]
        image = matlab.double(image.tolist())
        res=eng.features_of_single_image(image,nargout=2)
        # if you want to use pbdct features use res[0]
        [label,score] = eng.return_probs_hog(res[0],nargout=2)
        temp=np.asarray(score)
        result[i][0]=temp[0][0]
        result[i][1]=temp[0][1]
    return result


explainer = lime_image.LimeImageExplainer()
image=matplotlib.image.imread('xai_thyroid/Data_temp/datapre/3_1.jpg')
image=gray2rgb(image)
image=np.reshape(image,(1,300,300,3))
score=test_with_single_input_7200_hot(image)

import warnings
warnings.filterwarnings("ignore")
tmp_img=matplotlib.image.imread('xai_thyroid/Data_temp/datapre/3_1.jpg')
explanation = explainer.explain_instance(tmp_img, test_with_single_input_7200_hot, num_samples=350)
toc=time.time()
print("It took {} secs to explain this image".format(toc-tic))

#temp_1, mask_1 = explanation.get_image_and_mask(explanation.top_labels[0], positive_only=True, num_features=20, hide_rest=True)
temp_2, mask_2 = explanation.get_image_and_mask(explanation.top_labels[0], positive_only=True, num_features=12
                                                , hide_rest=False)

#fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(15,15))
#ax1.imshow(mark_boundaries(temp_1, mask_1))
plt.imshow(mark_boundaries(temp_2, mask_2,color=(1, 0, 0),mode='inner',outline_color=(1,0,0)))
#ax1.axis('off')
