function [pos_X_NED,pos_Y_NED] = xy2analyse(x,y,X,Y)

pos_X_NED(:,1) = x(1,1)-x(:,1);
pos_Y_NED(:,1) = y(1,1)-y(:,1);
pos_X_NED(:,2:1+length(Y(1,:))) = Y(:,:);
pos_Y_NED(:,2:1+length(Y(1,:))) = X(:,:);


end

