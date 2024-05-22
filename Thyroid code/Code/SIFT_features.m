function [features_sift] = SIFT_features(I)
num_features = 100;
% Create a SIFT object
%sift = vl_sift(single(I));
% Detect SIFT features
    [frames, features] = vl_sift(single(I));

% Select the strongest features
    strongest_features = features(:,1:num_features);

% Get the features and descriptors
%features = sift(1:2,:);
%descriptors = sift(3:end,:);

% Convert the descriptors into a single row vector
descriptors_vector = reshape(strongest_features, [1, size(strongest_features, 1) * size(strongest_features, 2)]);

features_sift = descriptors_vector;

%The vl_sift function returns a matrix containing both the SIFT features and descriptors.
%The first two rows of the matrix contain the x and y coordinates of the features,
%and the remaining rows contain the descriptors for each feature.

end
