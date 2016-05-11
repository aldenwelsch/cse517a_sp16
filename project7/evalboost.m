function preds=evalboost(BDT,xTe)
% function preds=evalboost(BDT,xTe);
%
% Evaluates a boosted decision tree on a test set xTe.
%
% input:
% BDT | Boosted Decision Trees
% xTe | matrix of m input vectors (matrix size dxm)
%
% output:
%
% preds | predictions of labels for xTe
%

%% fill in code here

[d,m]= size(xTe);
numT = size(BDT,2);

predmat = zeros(numT,m);

for i = 1:numT
   predmat(i,:) = evaltree(BDT{i},xTe);
end

%predictionMatrix(:,:)
%preds = mode(predictionMatrix,1)
preds = round(mean(predmat,1));

