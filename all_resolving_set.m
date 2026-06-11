function [resol_set,Dis] = all_resolving_set(A,r)
%This function takes adjacency matrix A of a graph and r as number of
%elements we want to check for reolving set. It will then find all subsets
%of size r and then check them for resolving set
G=graph(A);
rows=size(A,1); %No. of vertices in graph
V=zeros(1,rows); %Make a zero array having one row and same number of columns as vertices of graph
for i=1:rows %Populate it with vertex names
    V(1,i)=i;
end
All_subset_size_r=nchoosek(V,r); %find all subsets of G having r elements
[~,no_of_vertices_G]=size(V);  %size(V) finds number of rows and columns in V and saves it in a and b respectively
no_subsets_size_r=nchoosek(no_of_vertices_G,r);  %Total No. of subsets of graph G of size of size r
D=distances(G);
M=zeros(1,r);
for i=1:no_subsets_size_r
    Distances_k_j=zeros(no_of_vertices_G,r);
        for k=1:no_of_vertices_G
            for j=1:r
                Distances_k_j(k,j)=D(All_subset_size_r(i,j),V(1,k));
            end
        end
     CHECK=unique(Distances_k_j,'rows');
     if size(CHECK)==size(Distances_k_j)
         M=All_subset_size_r(i,:)
         Dis=Distances_k_j;
                %break;
     end
end
    if i==no_subsets_size_r
        M=0;
        Dis=0;
    end
resol_set=M;