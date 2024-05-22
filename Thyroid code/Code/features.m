function [] = features(path)
    file_area = dir(string(path) + '*.jpg');
    num = length(file_area);

    names = [];
    HOG_featurevectors = [];
    DCT_featurevectors = [];
    DWT_featurevectors = [];
    SURP_featurevectors = [];
    SIFT_fetaurevectors = [];
    LBP_featurevectors = [];

    for k=1:num
        filename = fullfile(file_area(k).folder,file_area(k).name);
        [~,name_test, ~] = fileparts(filename);
        
        I = imread(filename);

        names = [string(name_test) names];
        HOG_featurevectors = [[HOG_Comp_Cell_sigma(I, 2.5)] ; HOG_featurevectors];
        DCT_featurevectors = [[DCT_feature(I)] ; DCT_featurevectors];
        DWT_featurevectors = [[DWT_feature(I)]; DWT_featurevectors];
        SURP_featurevectors = [[SURP_features(I)] ;SURP_featurevectors];
        %SURP_featurevectors = SURP_features(I);

        SIFT_fetaurevectors = [[SIFT_features(I)] ;SIFT_fetaurevectors];
        LBP_featurevectors  = [[LBP_features(I)]; LBP_featurevectors];

        
        %HOT_DWT_featurevector = cat(2, HOG_featurevectors, DWT_featurevectors);

        %disp(k);
    end
    %8disp(size(LBP_featurevectors));
    %disp(size(DWT_featurevectors));
    %disp(size(SURP_featurevectors));
    %disp(size(SIFT_fetaurevectors));
    data_struct = struct('names',names,'HOG_featurevectors',HOG_featurevectors,'DCT_featurevectors',DCT_featurevectors,'DWT_featurevectors',DWT_featurevectors, 'SURP_featurevectors',SURP_featurevectors, 'SIFT_featurevectors',SIFT_fetaurevectors , 'LBP_featurevectors', LBP_featurevectors);
    data_json = jsonencode(data_struct);

    fileID = fopen('features.json','w');
    fprintf(fileID,'%s',data_json);
 
    fclose(fileID);
end