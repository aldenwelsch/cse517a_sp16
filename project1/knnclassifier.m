function preds=knnclassifier(xTr,yTr,xTe,k);
% function preds=knnclassifier(xTr,yTr,xTe,k);
%
% k-nn classifier 
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with n column-vectors of dimensionality d
% k = number of nearest neighbors to be found
%
% Output:
%
% preds = predicted labels, ie preds(i) is the predicted label of xTe(:,i)
%


% % output random result as default (you can erase this code)
% [d,n]=size(xTe);
% [d,ntr]=size(xTr);
% if k>ntr,k=ntr;end;
% 
% %currently assigning random predictions
% un=unique(yTr);
% preds=un(ceil(rand(1,n)*length(un)));

%% fill in code here
%preds = mode(yTr(findknn(xTr,xTe,k)'),1)
% indices = findknn(xTr,xTe,k);
% [M,F] = mode(yTr(indices),1);
% if max(F) == 1,
%     preds = mode(yTr(indices(1,:)),1);
% else 
%     preds = M;
% end
if size(xTe) == size(xTr)
    if xTe == xTr
        preds = yTr;
    else
%         preds = mode(yTr(findknn(xTr,xTe,k)));
%         [M,F,C] = mode(yTr(findknn(xTr,xTe,k)),1);
%         if max(F) == 1
%             temp = yTr(findknn(xTr,xTe,k));
%             preds = temp(:,1);
%         end
        indices = findknn(xTr,xTe,k);
        val = reshape(yTr(indices),size(indices));
        [M,F,C] = mode(val);
        [nrows,ncols] = cellfun(@size,C);
        if nrows ~= 1 %isequal(F, ones(size(F))) %&& isequal(M, ones(size(M)))
            %preds = val(1,:);
            indices = findknn(xTr,xTe,k-1);
            preds = mode(reshape(yTr(indices),size(indices)));
        else
            preds = M;
        end
    end
else
%     preds = mode(yTr(findknn(xTr,xTe,k)));
%     [M,F,C] = mode(yTr(findknn(xTr,xTe,k)),1);
%     if max(F) == 1
%         temp = yTr(findknn(xTr,xTe,k));
%         preds = temp(:,1);
%     end
    indices = findknn(xTr,xTe,k);
    val = reshape(yTr(indices),size(indices));
    [M,F,C] = mode(val);
    [nrows,ncols] = cellfun(@size,C);
    if nrows ~= 1 %isequal(F, ones(size(F))) %&& isequal(M, ones(size(M)))
        %preds = val(1,:);
        indices = findknn(xTr,xTe,k-1);
        preds = mode(reshape(yTr(indices),size(indices)));
    else
        preds = M;
    end
end
%preds = mode(yTr(findknn(xTr,xTe,k)),2);
% indices = findknn(xTr,xTe,k);
% val = reshape(yTr(indices),size(indices));
% modes = mode(val);
% if modes == ones(size(modes))
%     preds = val(1,:);
% else
%     preds = modes;
% end

