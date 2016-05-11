function [ypredict]=evaltree(T,xTe)
% function [ypredict]=evaltree(T,xTe);
%
% input:
% T0  | tree structure
% xTe | Test data (dxn matrix)
%
% output:
%
% ypredict : predictions of labels for xTe
%

%% fill in code here
[~, n] = size(xTe);
for i = 1:n,
	ypredict(1, i) = checkTree(T, 1, xTe(:, i));
end

end

function pred = checkTree(T, i, x)
	if T(4 ,i) == 0
		pred = T(1, i);
    else
		feature = T(2, i);
		cut = T(3, i);
		if x(feature, 1) <= cut
			left = T(4, i);
			pred = checkTree(T, left, x);
        else
			right = T(5, i);
			pred = checkTree(T, right, x);
		end
	end
end
