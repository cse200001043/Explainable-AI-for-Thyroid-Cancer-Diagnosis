function [] = isLinearlySeparable(data, labels)
% Input data and class labels
X = data;
y = labels;

% Number of data points and features
[m, n] = size(X);

% Initialize the weight vector and bias term
w = rand(n, 1);
b = rand;

% Define the learning rate
%alpha = 0.01;

% Loop until all data points are correctly classified
%converged = false;
%while ~converged
%    converged = true;
 %   for i = 1:m
  %      if y(i) * (X(i, :) * w + b) <= 0
  %          converged = false;
  %          w = w + alpha * y(i) * X(i, :)';
  %          b = b + alpha * y(i);
 %       end
 %   end
%end

% Check if all data points are correctly classified
%if all(y .* (X * w + b) > 0)
  %%else
  %  disp('Data is not linearly separable');
%end

for iteration = 1:max_iterations
    misclassifications = 0;
    for i = 1:m
        if sign(w' * X(i,:)' + b) ~= y(i)
            w = w + y(i) * X(i,:)';
            b = b + y(i);
            misclassifications = misclassifications + 1;
        end
    end
    if misclassifications == 0
        break;
    end
end
predictions = sign(w' * X' + b);
accuracy = sum(predictions == y) / m;

disp(acc)


end
