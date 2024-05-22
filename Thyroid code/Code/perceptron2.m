function [] = perceptron2(X,y)
% Perceptron algorithm to classify linearly separable data
% X: N x d matrix representing N data points in d-dimensional space
% y: N x 1 vector representing class labels (-1 or 1)
% w: d x 1 weight vector
% b: scalar bias term
% converged: flag indicating if algorithm converged (0 or 1)

[N,d] = size(X); % Get the number of data points and dimensions
w = zeros(d,1); % Initialize weight vector
b = 0; % Initialize bias term
converged = 0; % Initialize convergence flag
iter = 0; % Initialize iteration count

% Repeat until all data points are correctly classified or maximum iterations reached
while (~converged && iter<1000)
    converged = 1; % Assume convergence at start of each iteration
    for i = 1:N
        if (y(i)*(X(i,:)*w + b) <= 0) % Check if data point is misclassified
            converged = 0; % If misclassified, set convergence flag to 0
            w = w + y(i)*X(i,:)'; % Update weight vector
            b = b + y(i); % Update bias term
        end
    end
    iter = iter + 1; % Increment iteration count
end

% If algorithm converged, return w and b, otherwise return error message
if (converged)
    disp('Data is linearly separable.')
    %disp(['Weight vector: ' num2str(w')])
    %disp(['Bias term: ' num2str(b)])
else
    disp('Data is not linearly separable or maximum iterations reached.')
end
% Compute predictions on input data
predicted_labels = sign( X * w);

% Compute percentage of correct predictions
accuracy = sum(predicted_labels == y) / length(y) * 100;

disp(accuracy);

end
