function [bestC,bestP,bestval,allvalerrs]=crossvalidate(xTr,yTr,ktype,Cs,paras)
% function [bestC,bestP,bestval,allvalerrs]=crossvalidate(xTr,yTr,ktype,Cs,paras)
%
% INPUT:	
% xTr : dxn input vectors
% yTr : 1xn input labels
% ktype : (linear, rbf, polynomial)
% Cs   : interval of regularization constant that should be tried out
% paras: interval of kernel parameters that should be tried out
% 
% Output:
% bestC: best performing constant C
% bestP: best performing kernel parameter
% bestval: best performing validation error
% allvalerrs: a matrix where allvalerrs(i,j) is the validation error with parameters Cs(i) and paras(j)
%
% Trains an SVM classifier for all possible parameter settings in Cs and paras and identifies the best setting on a
% validation split. 
%

%%% Feel free to delete this
bestC=0;
bestP=0;
bestval=10^10;
allvalerrs = ones(length(Cs),length(paras))*10^10;

%% Split off validation data set
% YOUR CODE
rand_ind = randi(numel(yTr),1,floor(0.25*numel(yTr)));
xV = xTr(:,rand_ind);
yV = yTr(rand_ind);
ind = 1:numel(yTr);
xTrr = xTr;
yTrr = yTr;
xTrr(:,rand_ind) = [];
yTrr(rand_ind) = [];

%% Evaluate all parameter settings
% YOUR CODE
Cind = 0;
parind = 0;
for i = 1:length(Cs)
    for j = 1:length(paras)
        svmclassify = trainsvm(xTrr, yTrr, Cs(i),ktype,paras(j));
        valerror = sum(sign(svmclassify(xV))~=yV(:))/length(yV);
        if valerror < bestval
            bestval = valerror;
            Cind = i;
            parind = j;
        end
        allvalerrs(i,j) = valerror;
    end
end

%% Identify best setting
% YOUR CODE
bestC = Cs(Cind);
bestP = paras(parind);

