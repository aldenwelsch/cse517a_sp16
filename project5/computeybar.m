function ybar=computeybar(xTe)
% function [ybar]=ybar(xTe);
% 
% computes the expected label 'ybar' for a set of inputs x
% generated from two standard Normal distributions (one offset by OFFSET in
% both dimensions.)
%
% INPUT:
% xTe | a 2xn matrix of column input vectors
% 
% OUTPUT:
% ybar | a 1xn vector of the expected label ybare(x)
%

global OFFSET;

[~,n]=size(xTe);
ybar=zeros(1,n);

% Feel free to use the following function to compute p(x|y)
normpdf=@(x,mu,sigma)   exp(-0.5 * ((x - mu)./sigma).^2) ./ (sqrt(2*pi) .* sigma);

N1 = normpdf(xTe,zeros(size(xTe)),1);
pxy1 = N1(1,:).*N1(2,:);
py1 = 0.5;

mu = [OFFSET; OFFSET];
mu = repmat(mu,1,n);
N2 = normpdf(xTe,mu,1);
pxy2 = N2(1,:).*N2(2,:);
py2 = 0.5;

pyx1 = (pxy1*py1)./(pxy1*py1 + pxy2*py2);
pyx2 = (pxy2*py2)./(pxy2*py2 + pxy1*py1);
sum1 = pyx1 + pyx2;
ybar = 1*pyx1 + 2*pyx2;
