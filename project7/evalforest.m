function preds=evalforest(F,xTe)
% function preds=evalforest(F,xTe);
%
% Evaluates a random forest on a test set xTe.
%
% input:
% F   | Forest of decision trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%

%% fill in code here

[d,m]= size(xTe);
numTrees = size(F,2);

predmat = zeros(numTrees,m);

for i = 1:numTrees
   predmat(i,:) = evaltree(F{i},xTe);
end

% Take the mode of the predictions of each column
preds = mode(predmat,1);