function BDT=boosttree(x,y,nt,maxdepth)
% function BDT=boosttree(x,y,nt,maxdepth)
%
% Learns a boosted decision tree on data x with labels y.
% It performs at most nt boosting iterations. Each decision tree has maximum depth "maxdepth".
%
% INPUT:
% x  | input vectors dxn
% y  | input labels 1xn
% nt | number of trees (default = 100)
% maxdepth | depth of each tree (default = 3)
%
% OUTPUT:
% BDT | Boosted DTree
%


%% fill in code here

if nargin < 4
    maxdepth = 3;
end

if nargin < 3
    nt = 10; %100
end

[d,n] = size(x);

% initialize variables
weights = ones(1,n)./n;
BDTtemp = cell(1,nt);
tree = id3tree(x,y,maxdepth,weights); 
BDTtemp{1}=tree;

for i = 1:1:nt 
    
    % Calculate weak learner
    BDTtemp{i} = id3tree(x,y,maxdepth,weights);
    % get predictions of the learner
    h = evaltree(BDTtemp{i},x);
    % calculate error
    error = sum(weights(y~=h));
    
    % break if error is really bad
    if error > 0.5 
        break;
    end
    
    % learning reate
    alpha = .5*log((1-error)/error);
    
    % now calculate the new weights
    weights = weights.*exp(-alpha.*h.*y)./(2*sqrt(error*(1-error)));

end

% how many non-null elements are in the cell array?
BDT = cell(1,i);
for k=1:i
    BDT{k} = BDTtemp{k};
end
