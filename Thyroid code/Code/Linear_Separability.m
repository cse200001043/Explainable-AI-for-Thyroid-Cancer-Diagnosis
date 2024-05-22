function [] = Linear_Separability()

    
    data = jsondecode(fileread('features.json'));
    
    [~,~,raw] = xlsread('../Data/labels.xlsx','A1:C480');
    map = containers.Map(raw(:,1),raw(:,2));
    
    [r,~] = size(data.names);
    out = [];
    for i = 1:r
        % out variable contains labels for stage one
        out = [map(string(data.names(i)));out];
    end



% Initialize the output vector
output_vector = zeros(1, length(out));

% Loop through the input vector and replace values
for i = 1:length(out)
    if out(i) == 1
        output_vector(i) = -1;
    elseif out(i) == 2
        output_vector(i) = 1;
    end
end

% Display the output vector
%disp(output_vector);

in = data.HOG_featurevectors(:,:);
%in = data.DCT_featurevectors(:,:);
%in = data.DWT_featurevectors(:,:);
%in = data.SIFT_featurevectors(:,:);
%in = data.SURP_featurevectors(:,:);



%disp(size(in));
%isLinearlySeparable(in, out);
  %[w,b,iter,misclassifications] = perceptron(in,out);

  % call perceptron alorithm to know about data is linearly separable or
  % not
  learning_rate = 0.05;

perceptron4(in,output_vector, learning_rate);
  %perceptron2(in,output_vector)
  %perceptron3(in,output_vector,0.05)

  


  
end