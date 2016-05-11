function [w]=grdescent(func,w0,stepsize,maxiter,tolerance)
% function [w]=grdescent(func,w0,stepsize,maxiter,tolerance)
%
% INPUT:
% func function to minimize
% w0 = initial weight vector 
% stepsize = initial gradient descent stepsize 
% tolerance = if norm(gradient)<tolerance, it quits
%
% OUTPUTS:
% 
% w = final weight vector
%

if nargin<5,tolerance=1e-02;end;

count = 1;
error = inf;
prevloss1 = inf;
prevloss2 = inf;
% initialize w
wt1 = w0;
wt = w0;
while (error > tolerance) && (count < maxiter)
    [loss, gradient] = func(wt1);
    if loss <= prevloss1
        wt = wt1;
        prevloss2 = prevloss1;
        prevloss1 = loss;
        wt1 = wt1 - stepsize.*gradient;
        stepsize = 1.01*stepsize;
        error = norm(gradient);
        count = count + 1;
    else
        wt1 = wt;
        prevloss1 = prevloss2;
        stepsize = 0.5*stepsize;
    end
end

w = wt1;
