function adj_matrix=GeBsTn()
    % Initialize total vertices counter
    total_vertices = 0;
    paths = {};  % Cell array to hold each path's vertices

    % Loop to get three paths
    for i = 1:3
        while true
            % Ask user for path length
            path_length = input(['Enter the length of path ', num2str(i), ': ']);
            
            % Check if the path length is odd
            if mod(path_length, 2) == 1
                % Generate the path with consecutive vertices
                paths{i} = total_vertices + (1:path_length);
                total_vertices = total_vertices + path_length;
                break;  % Exit the while loop if valid input
            else
                disp('Path length must be odd. Please try again.');
            end
        end
    end
    
    % Initialize adjacency matrix for the graph
    num_even_vertices_in_path1 = sum(mod(paths{1}, 2) == 0);  % Even vertices in the first path
    num_even_vertices_in_path2 = sum(mod(paths{2}, 2) == 0);  % Even vertices in the second path
    total_vertices = total_vertices + num_even_vertices_in_path1 + num_even_vertices_in_path2; % Add space for the distinct leaf nodes
    adj_matrix = zeros(total_vertices);  % Adjust adjacency matrix size
    
    % Add edges for each path
    for i = 1:3
        % Get current path vertices
        path_vertices = paths{i};
        % Create edges along the path
        for j = 1:length(path_vertices)-1
            adj_matrix(path_vertices(j), path_vertices(j+1)) = 1;
            adj_matrix(path_vertices(j+1), path_vertices(j)) = 1; % Make symmetric
        end
    end
    
    % Add distinct leaf nodes to all even vertices in the first path
    next_leaf_vertex = total_vertices - num_even_vertices_in_path1 - num_even_vertices_in_path2 + 1; % Starting index for new leaf nodes
    leaf_vertices_path1 = [];  % To store the leaf nodes of the first path
    path2_vertices = paths{2};  % Vertices of the second path
    
    % Connect leaves to even vertices of the first path
    for j = 1:length(paths{1})
        if mod(paths{1}(j), 2) == 0
            % Connect a distinct leaf to each even vertex in the first path
            adj_matrix(paths{1}(j), next_leaf_vertex) = 1;
            adj_matrix(next_leaf_vertex, paths{1}(j)) = 1;  % Make symmetric
            
            % Store the leaf vertex for future connections
            leaf_vertices_path1(end+1) = next_leaf_vertex;
            next_leaf_vertex = next_leaf_vertex + 1;  % Move to the next leaf vertex
        end
    end
    
    % Connect leaves of the first path to odd-numbered vertices of the second path
    for k = 1:length(leaf_vertices_path1)
        if 2*k-1 <= length(path2_vertices)-2  % Ensure valid index in path 2
            % Connect leaf to the 1st and 3rd, 3rd and 5th, etc.
            adj_matrix(leaf_vertices_path1(k), path2_vertices(2*k-1)) = 1;  % Connect to odd vertex
            adj_matrix(path2_vertices(2*k-1), leaf_vertices_path1(k)) = 1;  % Make symmetric
            adj_matrix(leaf_vertices_path1(k), path2_vertices(2*k+1)) = 1;  % Connect to next odd vertex
            adj_matrix(path2_vertices(2*k+1), leaf_vertices_path1(k)) = 1;  % Make symmetric
        end
    end
    
    % Add distinct leaf nodes to all even vertices in the second path
    leaf_vertices_path2 = [];  % To store the leaf nodes of the second path
    path3_vertices = paths{3};  % Vertices of the third path
    
    % Connect leaves to even vertices of the second path
    for j = 1:length(paths{2})
        if mod(paths{2}(j), 2) == 1
            % Connect a distinct leaf to each even vertex in the second path
            adj_matrix(paths{2}(j), next_leaf_vertex) = 1;
            adj_matrix(next_leaf_vertex, paths{2}(j)) = 1;  % Make symmetric
            
            % Store the leaf vertex for future connections
            leaf_vertices_path2(end+1) = next_leaf_vertex;
            next_leaf_vertex = next_leaf_vertex + 1;  % Move to the next leaf vertex
        end
    end
    
    % Connect leaves of the second path to odd-numbered vertices of the third path
    for k = 1:length(leaf_vertices_path2)
        if 2*k-1 <= length(path3_vertices)-2  % Ensure valid index in path 3
            % Connect leaf to the 1st and 3rd, 3rd and 5th, etc.
            adj_matrix(leaf_vertices_path2(k), path3_vertices(2*k-1)) = 1;  % Connect to odd vertex
            adj_matrix(path3_vertices(2*k-1), leaf_vertices_path2(k)) = 1;  % Make symmetric
            adj_matrix(leaf_vertices_path2(k), path3_vertices(2*k+1)) = 1;  % Connect to next odd vertex
            adj_matrix(path3_vertices(2*k+1), leaf_vertices_path2(k)) = 1;  % Make symmetric
        end
    end
    
    % Connect leaves to even vertices of the third path
    for j = 1:length(paths{3})
        if mod(paths{3}(j), 2) == 0
            % Connect a distinct leaf to each even vertex in the second path
            adj_matrix(paths{3}(j), next_leaf_vertex) = 1;
            adj_matrix(next_leaf_vertex, paths{3}(j)) = 1;  % Make symmetric
            
            % Store the leaf vertex for future connections
            leaf_vertices_path2(end+1) = next_leaf_vertex;
            next_leaf_vertex = next_leaf_vertex + 1;  % Move to the next leaf vertex
        end
    end
    
    % Ensure the adjacency matrix is symmetric
    adj_matrix = adj_matrix + adj_matrix';
    
    % Plot the resulting graph
G = graph(adj_matrix);
adj_matrix = adjacency(G);
figure;
p = plot(G, 'Layout', 'force');
title('Graph with paths and connected leaves');

% Display vertex numbers next to the vertices
labelnode(p, 1:numnodes(G), cellstr(string(1:numnodes(G))));
end
