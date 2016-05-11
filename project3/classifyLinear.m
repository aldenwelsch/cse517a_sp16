function preds = classifyLinear(x,w,b);
% function preds=classifyLinear(x,w,b);
%
% Make predictions with a linear classifier
% Input:
% x : n input vectors of d dimensions (dxn)
% w : weight vector
% b : bias
%
% Output:
% preds: predictions
%

%% fill in code here
% w'*x
%preds = ones(size(x,2),1)';
size(w')
size(x)
preds = (floor((sign(w'*x + b)+1)/2)*2)-1;
