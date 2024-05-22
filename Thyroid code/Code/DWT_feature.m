function [features_dwt] =  DWT_feature(I)
    
    % Perform DWT
    [cA1,cH1,cV1,cD1] = dwt2(I,'db6', 'mode','symw');
    [cA2,cH2,cV2,cD2] = dwt2(cA1,'db6', 'mode','symw');
    [cA3,cH3,cV3,cD3] = dwt2(cA2,'db6', 'mode','symw');

    % Calculate energy of each subband
    cA_energy = sum(cA3(:).^2); 
    cH_energy = sum(cH3(:).^2);
    cV_energy = sum(cV3(:).^2);
    cD_energy = sum(cD3(:).^2);

    % Normalize the energy values
    total_energy = cA_energy + cH_energy + cV_energy + cD_energy;
    cA_energy = cA_energy / total_energy;
    cH_energy = cH_energy / total_energy;
    cV_energy = cV_energy / total_energy;
    cD_energy = cD_energy / total_energy;

    % Calculate entropy of each subband
    cA_entropy = entropy(cA3);
    cH_entropy = entropy(cH3);
    cV_entropy = entropy(cV3);
    cD_entropy = entropy(cD3);

    % Compute the standard deviation of wavelet coefficients column-wise and row-wise
    std_col1 = std([cH1,cV1,cD1]);
    std_row1 = std([cH1',cV1',cD1']);
    std_col2 = std([cH2,cV2,cD2]);
    std_row2 = std([cH2',cV2',cD2']);
    std_col3 = std([cH3,cV3,cD3]);
    std_row3 = std([cH3',cV3',cD3']);

    % Concatenate the features: energy, entropy, and standard deviation
    features_dwt = [cA_energy, cH_energy, cV_energy, cD_energy, ...
                    cA_entropy, cH_entropy, cV_entropy, cD_entropy, ...
                    std_col1, std_row1, std_col2, std_row2, std_col3, std_row3];
end


