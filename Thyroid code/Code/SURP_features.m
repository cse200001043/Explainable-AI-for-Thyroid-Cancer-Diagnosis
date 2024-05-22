function [features_surp] = SURP_features(I) 

 
% Define the number of features to extract from each image
num_features = 100;

% detect surp keypoints

points = detectSURFFeatures(I);

% Select the strongest features
strongest_points = points.selectStrongest(num_features);

%Extract Surp descriptors 

[features, valid_points] = extractFeatures(I, strongest_points);

% Extracting 500 strongest texture features
%features_strong = validPoints.selectStrongest(500);
%features_surp = features_strong';

 features = double(features);
 features_surp = reshape(features,1,[]);


end
