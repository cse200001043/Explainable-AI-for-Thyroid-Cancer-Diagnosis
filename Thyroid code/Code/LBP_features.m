function [features_lbp] = LBP_features(image)
    % Convert the image to grayscale if necessary
    if size(image, 3) > 1
        grayImage = rgb2gray(image);
    else
        grayImage = image;
    end

    % Set the parameters for LBP
    numPoints = 8; % Number of neighboring points to consider
    radius = 1; % Radius of the circular neighborhood

    % Extract LBP features
    features_lbp = extractLBPFeatures(grayImage, 'NumNeighbors', numPoints, 'Radius', radius);
end