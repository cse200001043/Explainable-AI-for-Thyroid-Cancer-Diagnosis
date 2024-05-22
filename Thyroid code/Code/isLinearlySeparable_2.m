function [] = isLinearlySeparable_2(X,y)

% Load the data into a matrix 'data'
%data = load('data.txt');

% Extract the input features and target labels from the data
%X = data(:,1:end-1);
%y = data(:,end);

% Initialize the weights and bias to random values
weights = rand(1, size(X,2));
bias = rand;

% Define the learning rate
eta = 0.1;

% Set the maximum number of iterations
maxIter = 100;

% Initialize the iteration counter
iter = 1;

% Start the perceptron learning algorithm
while iter <= maxIter
    % Initialize the flag to keep track of misclassified examples
    flag = 0;
    
    % Loop over all the examples in the data
    for i = 1:size(X,1)
        % Compute the output for the current example
        output = sign(weights * X(i,:)' + bias);
        
        % Check if the example is misclassified
        if output ~= y(i)
            % Update the weights and bias
            weights = weights + eta * y(i) * X(i,:);
            bias = bias + eta * y(i);
            
            % Set the flag to indicate that there was a misclassified example
            flag = 1;
        end
    end
    
    % If all examples are correctly classified, break from the loop
    if flag == 0
        break;
    end
    
    % Increment the iteration counter
    iter = iter + 1;
end

% Check if the data is linearly separable
if flag == 0
    fprintf('Data is linearly separable\n');
else
    fprintf('Data is not linearly separable\n');
end



end
