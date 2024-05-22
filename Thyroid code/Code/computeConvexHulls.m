function class_hulls = computeConvexHulls(data, labels)
    % Compute the Convex Hulls of each class of data
    class_hulls = cell(numel(unique(labels)), 1);
    for i = 1 to numel(unique(labels))
        class_data = data(labels == i, :);
        class_hulls{i} = convhulln(class_data);
    end
end