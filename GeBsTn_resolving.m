clc;
% Generate tree and get its adjacency matrix
adj_matrix = GeBsTn(); % This is the original graph G

% Keep a copy of the adjacency matrix of G to use later
original_adj_matrix = adj_matrix;

% Repeatedly ask the user to check for resolving sets for this power graph
    while true
        % Ask for the number of elements in the resolving set
        prompt = 'How many elements will be in the set you want to check for resolving set: ';
        k = input(prompt);

        % Call the resolving set function
        [K,L] = resolving_1_by_1(adj_matrix, k);

        % Display the result of the resolving set check (or any relevant output)
        disp('Result of resolving set check:');
        disp(K); % Display the set being checked
        disp(L); % Display the result of the check

        % Ask if the user wants to check another resolving set for this power
        check_more = input('Do you want to check another resolving set for this graph (y/n)? ', 's');
        if strcmpi(check_more, 'n')
            break; % Exit the loop if the user doesn't want to check more sets for the current power
        end
    end
    disp('No more powers or resolving sets to check. Program ended.');