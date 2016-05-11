function bias=recoverBias(K,yTr,alphas,C);
% function bias=recoverBias(K,yTr,alphas,C);
%
% INPUT:	
% K : nxn kernel matrix
% yTr : 1xn input labels
% alphas  : nx1 vector or alpha values
% C : regularization constant
% 
% Output:
% bias : the hyperplane bias of the kernel SVM specified by alphas
%
% Solves for the hyperplane bias term, which is uniquely specified by the support vectors with alpha values
% 0<alpha<C
%

% YOUR CODE 
bias = 0;
% sv_i = (alphas > 0.000001);
% alphas = alphas(sv_i);
% yTr = yTr(sv_i);
% K = K(sv_i, sv_i);

%correct yTr dimensions
yTr = yTr(:)';

%pick alpha_j
val = C/2; %value to find
tmp = abs(alphas-val);
[~,j] = min(tmp); %index of closest value

bias = 1/yTr(j) - (alphas.*yTr')'*K(:,j);

