function [K,L] = FT_resolving_1_by_1(adj_matrix, k)

n = size(adj_matrix,1);
G = graph(adj_matrix);
D = distances(G);

comb = 1:k;
count = 0;

while true
    count = count + 1;

    if is_fault_tolerant_resolving(D, comb)
        fprintf('Fault-tolerant resolving set found after checking %d subsets.\n', count);
        K = comb;
        L = D(:,comb);
        return;
    end

    if mod(count,100000) == 0
        fprintf('Checked %d subsets...\n', count);
    end

    comb = next_combination(comb, n, k);

    if isempty(comb)
        break;
    end
end

disp('No fault-tolerant resolving set found.');
K = [];
L = [];

end


function flag = is_fault_tolerant_resolving(D, W)

flag = true;

for i = 1:length(W)
    Wtemp = W;
    Wtemp(i) = [];

    M = D(:,Wtemp);

    if size(unique(M,'rows'),1) ~= size(D,1)
        flag = false;
        return;
    end
end

end


function comb = next_combination(comb, n, k)

i = k;

while i >= 1 && comb(i) == n-k+i
    i = i - 1;
end

if i == 0
    comb = [];
    return;
end

comb(i) = comb(i) + 1;

for j = i+1:k
    comb(j) = comb(j-1) + 1;
end

end