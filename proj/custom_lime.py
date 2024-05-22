import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from  matplotlib.colors import LinearSegmentedColormap
import copy
import skimage.segmentation
from sklearn.linear_model import LinearRegression
from skimage.color import gray2rgb
import os
from PIL import Image
import sklearn.metrics


# Generating pertubed image
def perturb_image(img,perturbation,segments):
    active_pixels = np.where(perturbation == 1)[0]
    mask = np.zeros(segments.shape)
    for active in active_pixels:
        mask[segments == active] = 1
    perturbed_image = copy.deepcopy(img)
    perturbed_image = perturbed_image*mask[:,:,np.newaxis]
    return perturbed_image

# connecting to matlab engine
import matlab.engine
eng = matlab.engine.connect_matlab()
eng.cd(r'/Users/nunemunthalashiva/Documents/BTP/xai_thyroid/Code', nargout=0)
eng.plus(2,3)

# reading image file and converting to rgb
img = skimage.io.imread('xai_thyroid/Data_temp/datapre/3_1.jpg')
img=gray2rgb(img)



#generating superpixels via different segmentation algorithms

# img = pre-processed image , dist = a number nearer to length of image , img :  preprocessed one
# ratio : Balances color-space proximity and image-space proximity. Higher values give more weight to color-space
# kernel_size = Width of Gaussian kernel used in smoothing the sample density. Higher means fewer clusters
# max_dist = Cut-off point for data distances. Higher means fewer clusters.
superpixels = skimage.segmentation.slic(img, n_segments=250, compactness=4.5, sigma=1,
                     start_label=1)
#superpixels = skimage.segmentation.quickshift(img,ratio=0.4,kernel_size=6,max_dist=150)
#superpixels = skimage.segmentation.felzenszwalb(img, scale=1, sigma=0.9, min_size=250)
num_superpixels = np.unique(superpixels).shape[0]
#skimage.io.imshow(skimage.segmentation.mark_boundaries(img, superpixels))

#Generate perturbations
num_perturb = 100
#drawing samples from binomial distribuition with prob=0.5 and n=1
perturbations = np.random.binomial(1, 0.5, size=(num_perturb, num_superpixels))

# print prediction of each pertubed image

predictions = []
for pert in perturbations:
    perturbed_img = perturb_image(img,pert,superpixels)

    try:
        im = Image.fromarray((perturbed_img * 255).astype(np.uint8))
    except Exception as e:
        print(e)
    #pred=eng.test_with_single_input_7200_hot(im)
    im.save('/Users/nunemunthalashiva/Documents/BTP/xai_thyroid/temp/temp_img.jpg', 'JPEG')
    pred = eng.test_with_single_input(7200,"hot") #get output from matlab regarding image of benign vs malignant
    pred=int(pred)
    predictions.append(pred)

predictions = np.array(predictions)


original_image = np.ones(num_superpixels)[np.newaxis,:] #Perturbation with all superpixels enabled
distances = sklearn.metrics.pairwise_distances(perturbations,original_image, metric='cosine').ravel()
#print(distances.shape)

# Finding how close a pertubed image file to original image

#Transform distances to a value between 0 an 1 (weights) using a kernel function
kernel_width = 0.25
#gaussian kernel function
weights = np.sqrt(np.exp(-(distances**2)/kernel_width**2))

simpler_model = LinearRegression()
simpler_model.fit(X=perturbations, y=predictions, sample_weight=weights)
coeff = simpler_model.coef_
#print(coeff.shape)

#Use coefficients from linear model to extract top features

#show top 20 features
num_top_features = 20
top_features = np.argsort(coeff)[-num_top_features:]
#print(top_features)
#Show only the superpixels corresponding to the top features
mask = np.zeros(num_superpixels)
mask[top_features]= True #Activate top superpixelsx
skimage.io.imshow(perturb_image(img,mask,superpixels).astype('uint8'))
