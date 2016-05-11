function T=prunetree(T,xTe,y)
% function T=prunetree(T,xTe,y)
%
% Prunes a tree to minimal size such that performance on data xTe,y does not
% suffer.
%
% Input:
% T = tree
% xTe = validation data x (dxn matrix)
% y = labels (1xn matrix)
%
% Output:
% T = pruned tree
%

%% fill in code here

% what is the starting test error?
err = analyze('acc',y,evaltree(T,xTe));

% Check to break the loop
done = 0;

% Keep track of the pruning storage vector index
pInd = 1;

% Initialize a vector of leaves that will be removed
%prune = zeros(6,size(T,2));

% Process:
% 1. Collect all the leaves
% 2. Test each leave pair to see if the error decreases
% 3. If any leaf needs to be pruned, rearrange the tree accordingly
% 4. Start again if pruning happened.
while 1
    
    % create a vector for all of the leaves
    leaves = find(T(4,:)==0);
    
    % Check through the leaves testing if they lower error
    for i = 1:length(leaves)

        % If sibling is not leaf, skip to next
        if ~((T(4, T(5, T(6, leaves(i)))) == 0) && (T(4, T(4, T(6, leaves(i)))) == 0))
            continue;
        end

        % Evaluate a duplicate of the tree
        Ttrue = T;

        % make the parent a leaf
        try x = Ttrue(4:5, T(6, leaves(i)));
            Ttrue(4:5, T(6, leaves(i))) = 0;
        catch
            % for debugging
            disp(T(6, leaves(i)));
        end

        % the new error without leaf pair
        testerr = analyze('acc', y, evaltree(Ttrue, xTe));

        if err <= testerr
            done = 1;
            % add the leaf to set of leaves to be pruned
            prune(1, pInd) = T(6, leaves(i));
            prune(2, pInd) = leaves(i);
            pInd = pInd + 1;
        end

    end
    
    if done == 1
        % if pruning happened, we need to update T 
        % the parents are now leaves
        try x = T(5, unique( prune(1,:)));
            T(4, unique( prune(1,:))) = 0;
            T(5, unique( prune(1,:))) = 0;
        catch
            % show the pruned leaves that are having troubles
            disp( unique( prune(1, :)));
            disp( prune(1, :));
        end;
        
        % leaves yet to be pruned get a dummy value
        T(:,prune(2,:)) = -1;
        
        % update the error with each new tree
        err = analyze('acc', y, evaltree(T, xTe));

        % update helper variables
        pInd = 1;
        done = 0;
        prune = [];
        
    else
        % Just return T since the error wasn't lowered
        break;
    end
end