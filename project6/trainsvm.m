function [svmclassify,sv_i,alphas]=trainsvm(xTr,yTr, C,ktype,kpar);
% function [svmclassify,sv_i,alphas]=trainsvm(xTr,yTr, C,ktype,kpar);
% INPUT:	
% xTr : dxn input vectors
% yTr : 1xn input labels
% C   : regularization constant (in front of loss)
% ktype : (linear, rbf, polynomial)
% 
% Output:
% svmclassify : a classifier (scmclassify(xTe) returns the predictions on xTe)
% sv_i : indices of support vectors
% alphas : a nx1 vector of alpha values
%
% Trains an SVM classifier with kernel (ktype) and parameters (C,kpar)
% on the data set (xTr,yTr)
%

if nargin<5,kpar=1;end;
yTr=yTr(:);
%svmclassify=@(xTe) ((rand(1,size(xTe,2))>0.5).*2-1)'; %% classify everything randomly
n=length(yTr);

disp('Generating Kernel ...')
% 
% YOUR CODE
%
K = computeK(ktype, xTr, xTr, kpar);
% sv_i = K;

disp('Solving QP ...')
%
% YOUR CODE 
%
[H,q,Aeq,beq,lb,ub]=generateQP(K,yTr,C);
X0 = zeros(1,n); % initial guess for alphas
% Q = size(q)
% Q2 = length(q)
% A = size(Aeq.*0)
alphas = quadprog(H, q, Aeq.*0, beq.*0, Aeq, beq, lb, ub);%, X0);
%alphas = X;
sv_i = (alphas > 0.000001); % basically alphas == 0

disp('Recovering bias')
%
% YOUR CODE 
%
bias = recoverBias(K,yTr,alphas,C);

disp('Extracting support vectors ...')
%
% YOUR CODE 
%
supp_vecs = xTr(:,sv_i); % Maybe K?

disp('Creating classifier ...')
%
% YOUR CODE 
%
%svmclassify=@(xTe) (alphas'*yTr(:))*sum(K,2) + bias;
%svmclassify=@(xTe) ((alphas(:).*yTr(:))'*computeK(ktype, xTr, xTe, kpar))' + bias;
svmclassify=@(xTe) ((alphas(sv_i).*yTr(sv_i))'*computeK(ktype, supp_vecs, xTe, kpar))' + bias;
%svmclassify=@(xTe) (alphas'*yTr(:))*sum(computeK(ktype, xTr, xTe, kpar),2) + bias;
%svmclassify=@(xTe,w) xTe'*w + bias;

disp('Computing training error:') % this is optional, but interesting to see
%
% YOUR CODE 
%
trainerr=sum(sign(svmclassify(xTr))~=yTr(:))/length(yTr)

