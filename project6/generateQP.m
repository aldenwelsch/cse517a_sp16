function [H,q,Aeq,beq,lb,ub]=generateQP(K,yTr,C);
% function [H,q,A,b,lb,ub]=generateQP(K,yTr,C);
%
% INPUT:	
% K : nxn kernel matrix
% yTr : 1xn input labels
% C : regularization constant
% 
% Output:
% H,q,Aeq,beq,lb,ub as defined in the MATLAB function 'quadprog'
%
% A call of quadprog (H, q, A, b,Aeq,beq,lb, ub,alpha0); should return the solution of the SVM specified by K,yTr,C
% for any valid alpha0 initialization.
%

[d,n]=size(K);
assert(d==n);

% YOUR CODE
% Correct yTr dimensions
yTr = yTr(:)';

Aeq = repmat(yTr,length(yTr),1); %eye(n);
%Aeq = repmat(yTr,1,length(yTr))';
%size(Aeq)
beq = zeros(length(yTr),1);%C*ones(n,1);
%size(beq)
H = (yTr'*yTr).*K;
%h = size(H)
%H == H';
q = -ones(n,1); % maybe -1
% A = Aeq.*0;
% b = beq.*0;
lb = zeros(n,1);
ub = C*ones(n,1);
%X0 = zeros(n,1);
%X = quadprog(H, q, A, b, Aeq, beq, lb, ub, X0);



