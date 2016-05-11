function preds=competition(xTr,yTr,xTe);
% function preds=competition(xTr,yTr,xTe);
%
% A classifier that outputs predictions for the data set xTe based on 
% what it has learned from xTr,yTr
%
% Input:
% xTr = dxn input matrix with n column-vectors of dimensionality d
% xTe = dxm input matrix with m column-vectors of dimensionality d
%
% Output:
%
% preds = predicted labels, ie preds(i) is the predicted label of xTe(:,i)
%

% The random classifier is awesome!!! Could you possibly do better?
% un=unique(yTr);
% [d,n]=size(xTe);
% preds=randi(length(un),1,n);

%fill in the code here
% [d,n]=size(xTr);
% xTr2 = xTr(:,1:ceil(n*0.15));
% yTr2 = yTr(:,1:ceil(n*0.15));
% xTr1 = xTr(:,1:floor(n*0.85));
% yTr1 = yTr(:,1:floor(n*0.85));
% k = 1;
% max = 0;
% while 1
%     temp = knnclassifier(xTr1,yTr1,xTr2,k);
%     temp2 = analyze('acc',yTr2,temp)
%     k
%     if k < 25
%         if temp2 > max
%             max = temp2;
%             optk = k
%         end
%         k = k + 1;
%     else
%         k;
%         break;
%     end
% end
% preds = knnclassifier(xTr,yTr,xTe,optk);
%%
%preds = knnclassifier(xTr,yTr,xTe,3);

%%
% This time, if we weight the modes properly, then we may be able to
% classify the labels with higher accuracy. The question, then is how to
% weight the modes properly. For now, we'll weight the indices with the 
% closest distance more heavily than those further away.

k =10;
% If the testing set and the training set are the same, we should just
% output the labels of the training set, since they should be the same.
if isequal(xTe,xTr)
    preds = yTr;
else
    % Store the indices of the k closest training points to each test
    % point. Then reshape the indices to find the true mode. If there is a
    % tie, find the k-1 closest points to break the tie. Otherwise, just
    % use the mode.
    indices = findknn(xTr,xTe,k);
    temp = repmat(indices(1,:),k,1);
    indices = temp;
    val = reshape(yTr(indices),size(indices));
    [M,F,C] = mode(val);
    [nrows,ncols] = cellfun(@size,C);
    if nrows ~= 1 
        indices = findknn(xTr,xTe,k-1);
        preds = mode(reshape(yTr(indices),size(indices)));
    else
        preds = M;
    end
end