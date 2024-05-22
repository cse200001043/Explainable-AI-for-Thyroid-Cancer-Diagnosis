function [] = ranked()

    data = jsondecode(fileread('features.json'));
    
    


data_input = data.HOG_featurevectors(:,:);

top_5000_features = feature_ranking_t_test(data_input, out);

disp(size(top_5000_features));


end