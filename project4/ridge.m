function [loss,gradient]=ridge(w,xTr,yTr,lambda)
% function w=ridge(xTr,yTr,lambda)
%
% INPUT:
% w weight vector (default w=0)
% xTr dxn matrix (each column is an input vector)
% yTr 1xn matrix (each entry is a label)
% lambda regression constant
%
% OUTPUTS:
% loss = the total loss obtained with w on xTr and yTr
% gradient = the gradient at w
%
%[d,n]=size(xTr)

X = xTr';
Y = yTr';
W = w;
size(X);
size(Y);
size(W);

loss = trace(W'*(X'*X)*W - W'*X'*Y - Y'*X*W + Y'*Y + lambda*(W'*W));
gradient = 2*(X'*X)*W - 2*X'*Y + 2*lambda*W;