function [] = perceptron3(X, y, learning_rate)
% X: input data (n x m matrix), where n is the number of features and m is the number of data points
% y: output labels (-1 or 1) (1 x m matrix)
% learning_rate: learning rate (scalar)
% w: learned weight vector (n x 1)
% converged: boolean flag indicating whether the algorithm converged or not
% accuracy: percentage of correct predictions

% Add bias term to input data
X = [ones(1, size(X, 2)); X];

% Initialize weight vector to random values
w = rand(size(X, 1), 1);

converged = false;
iter = 0;

while ~converged
    % Initialize error flag to false
    error_flag = false;
    
    % Iterate over each data point
    for j = 1:size(X, 2)
        % Compute predicted output
        predicted_output = sign(w' * X(:, j));
        
        % Update weight vector if prediction is incorrect
        if predicted_output ~= y(j)
            w = w + learning_rate * y(j) * X(:, j);
            error_flag = true;
        end
    end
    
    % If all predictions are correct, algorithm has converged
    if ~error_flag
        converged = true;
    end
    
    % Increment iteration count
    iter = iter + 1;
    
    % Check if maximum number of iterations has been reached
    if iter >= 1000
        break;
    end
end

% Compute predictions on input data
predicted_labels = sign(w' * X);

% Compute percentage of correct predictions
accuracy = sum(predicted_labels == y) / length(y) * 100;

if converged
    disp('Data is linearly separable');
    disp(['Accuracy: ', num2str(accuracy), '%']);
else
    disp('Data is not linearly separable');
end
end
