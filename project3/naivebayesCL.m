function [w,b]=naivebayesCL(x,y);
% function [w,b]=naivebayesCL(x,y);
%
% Implementation of a Naive Bayes classifier
% Input:
% x : n input vectors of d dimensions (dxn)
% y : n labels (-1 or +1)
%
% Output:
% w : weight vector
% b : bias (scalar)
%

% % add one all-ones positive and negative example
% [d,n]=size(x);
% %[pos neg] = naivebayesPY(x,y);
% x=[x ones(d,2)];
% y=[y -1 1];

 

[d,n]=size(x);
%% fill in code here
w = ones(size(x,1),1);
size(w);
b = 0;
% Closed form:
% size(((x'*x)^(-1)*x'*y'))
lambda = 0.4428;
w = (((lambda*eye(length(w))+x*x')^-1)*x*y');

