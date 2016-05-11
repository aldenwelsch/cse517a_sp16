function T=id3tree(xTr,yTr,maxdepth,weights)
% function T=id3tree(xTr,yTr,maxdepth,weights)
%
% The maximum tree depth is defined by "maxdepth" (maxdepth=2 means one split).
% Each example can be weighted with "weights".
%
% Builds an id3 tree
%
% Input:
% xTr | dxn input matrix with n column-vectors of dimensionality d
% yTr | 1xn input matrix
% maxdepth = maximum tree depth
% weights = 1xn vector where weights(i) is the weight of example i
%
% Output:
% T = decision tree
%

%% fill in code here
[d,n] = size(xTr);

%nargin
% If no weights parameter is passed in, set weights uniformly
if nargin < 4
    weights = ones(1, n)/n;
end
% if nargin == 3
%     numnodes = maxdepth
%     disp('hi')
% end
if nargin < 3
%     nargin
%     disp('<3')
    if log2(n) > d + 1
        numnodes = 2^(d + 2) - 1;
    else
        numnodes = 2^(log2(n) + 1) - 1;
    end
else
    if log2(n) <= d + 1
        if maxdepth<=log2(n) %Check to make sure maxdepth doesn't exceed max possible binary splits
            numnodes = 2^(maxdepth) - 1; %maxdepth+1
        else
            numnodes = 2^(log2(n) + 1) - 1;
        end
    else 
        if maxdepth <= d + 1
            numnodes = 2^(maxdepth)-1; %maxdepth+1
        else
            numnodes = 2^(d + 2) - 1;
        end
    end
end
% if nargin<3,
%     maxdepth = Inf;
%     numnodes = 2^3 - 1;
% else
% 	numnodes = 2^maxdepth - 1;
% end;

% Initialize T with estimate of maximum possible size for speed
% if numnodes <= 8
%     numnodes
% end
numnodes = cast(numnodes,'int32')+1;
T = zeros(6,numnodes);

nexttree = 2; %index of next subtree
train = cell(1,numnodes);
train{1}.x = xTr; train{1}.y = yTr;
i = 1;
while 1
    xs = train{i}.x;
    ys = train{i}.y;
    [feat,cut,Hbest] = entropysplit(xs,ys,weights);
    if (feat ~= 0) && (size(xs,2) ~= 1)
        T(1:4,i) = [mode(ys), feat, cut, nexttree];

        indices = 1:size(xs,2);
        indL = indices(xs(feat,:) <= cut);
        indR = indices(xs(feat,:) > cut);
        train{nexttree}.x = xs(:,indL);
        train{nexttree}.y = ys(:,indL);
        T(6,nexttree) = i;
        
        if (nexttree+2)>numnodes
            T(4:5,i)=0;
        else
            nexttree = nexttree+1;
        end

        train{nexttree}.x = xs(:,indR);
        train{nexttree}.y = ys(:,indR);
        T(5,i) = nexttree;
        T(6,nexttree) = i;
        
        if (nexttree+1)>numnodes
            T(4:5,i)=0;
        else
            nexttree = nexttree+1;
        end
    else
        T(1,i) = mode(ys);
    end

    i = i+1;
%     if i <= 9 && numnodes <= 8
%         i
%         nexttree
%     end
    if i==nexttree || i > numnodes
        T(:,i:end) = [];
        break;
    end
end



