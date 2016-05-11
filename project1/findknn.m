function [indices,dists]=findknn(xTr,xTe,k);
% function [indices,dists]=findknn(xTr,xTe,k);
%
% Finds the k nearest neighbors of xTe in xTr.
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
% k = number of nearest neighbors to be found
% 
% Output:
% indices = kxm matrix, where indices(i,j) is the i^th nearest neighbor of xTe(:,j)
% dists = Euclidean distances to the respective nearest neighbors
%

% output random results, please erase this code
% [d,ntr]=size(xTr);
% [d,nte]=size(xTe);
% indices=ceil(rand(k,nte)*ntr);
% size(indices)
% dists=rand(k,nte);
% if k>ntr,k=ntr;end;

%% fill in code here

% Find the distance between each vector in xTe and xTr
D = l2distance(xTe,xTr);
% Sort D' so that the columns are in descending order of the closest
% distances between xTe(:,i) and xTr(:,j)
[B, I] = sort(D,2,'ascend');
% Only take the k closest distances and their corresponding indeces
indices = I(:,1:k)';
dists = B(:,1:k)';
	
%%	%
	
