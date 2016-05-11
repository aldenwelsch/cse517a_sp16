function w=perceptron(x,y)
% function w=perceptron(x,y);
%
% Implementation of a Perceptron classifier
% Input:
% x : n input vectors of d dimensions (dxn)
% y : n labels (-1 or +1)
%
% Output:
% w : weight vector
%

[d,n]=size(x);
w=zeros(d,1);

%% fill in code here
% Max loop iterations: 100
max = 0;
while 1
    m = 0;
    % Randomize the data on each iteration
    rand = randperm(length(y));
    y = y(rand);
    x = x(:,rand);
    for i = 1:n
        if (y(i)*w'*x(:,i) <= 0)
            w = perceptronUpdate(x(:,i), y(i), w); % update w
            m = m + 1;
        end
    end
    if m == 0
        break
    end
    
    % break if while loop executes 100 times
    if max == 100
        break
    end
    max = max + 1
end

