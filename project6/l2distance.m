function D=l2distance(X,Z)
% function D=l2distance(X,Z)
%	
% Computes the Euclidean distance matrix. 
% Syntax:
% D=l2distance(X,Z)
% Input:
% X: dxn data matrix with n vectors (columns) of dimensionality d
% Z: dxm data matrix with m vectors (columns) of dimensionality d
%
% Output:
% Matrix D of size nxm 
% D(i,j) is the Euclidean distance of X(:,i) and Z(:,j)
%
% call with only one input:
% l2distance(X)=l2distance(X,X)
%
 
if (nargin==1) % case when there is only one input (X)
	%% fill in code here
    Xinner = X'*X;
    XinnerDiag = diag(Xinner);
    %D = sqrt(abs(repmat(XinnerDiag,[1,size(XinnerDiag)]) - 2*Xinner + repmat(XinnerDiag',[size(XinnerDiag),1])));
    D = sqrt(abs(XinnerDiag*ones(size(XinnerDiag))' - 2*Xinner + ones(size(XinnerDiag))*XinnerDiag'));
else  % case when there are two inputs (X,Z)
	%% fill in code here
    % We only care to store the diagonals. The first diagonal is the scalar
    % product of the first row with the first column. The second diagonal
    % is the scalar product of the second column. And so on.
    XinnerDiag = sum(X'.*X',2);
    ZinnerDiag = sum(Z'.*Z',2);
    %D = sqrt(abs(repmat(XinnerDiag,[1,size(ZinnerDiag)]) - 2*X'*Z + repmat(ZinnerDiag',[size(XinnerDiag),1])));
    D = sqrt(abs(XinnerDiag*ones(size(ZinnerDiag))' - 2*X'*Z + ones(size(XinnerDiag))*ZinnerDiag'));
end;
%



