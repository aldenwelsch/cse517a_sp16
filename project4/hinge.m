function [loss,gradient]=hinge(w,xTr,yTr,lambda)
% function w=ridge(xTr,yTr,lambda)
%
% INPUT:
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% lambda regression constant
% w weight vector (default w=0)
%
% OUTPUTS:
%
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%

[d,n]=size(xTr);

m = max((1-yTr.*(w'*xTr)),0);
loss = sum(m) + lambda*w'*w;

ind = (m ~= 0);

x = xTr(:,ind);
y = yTr(:,ind);
gradient = sum(-x*y',2) + lambda*2*w;