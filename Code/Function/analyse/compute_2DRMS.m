function [POS_RMS] = compute_2DRMS(X,X10,Y,Y10,X_REF,Y_REF)
% 
% for i=2:length(X(:,1))-1
%    step_pos_X(i,:) = X(i,1:4)-X(i-1,1:4);
%    step_pos_Y(i,:) = Y(i,1:4)-Y(i-1,1:4);
%    step_pos_X10(i,:) = X10(i,1:4)-X10(i-1,1:4);
%    step_pos_Y10(i,:) = Y10(i,1:4)-Y10(i-1,1:4);
%    step_pos_ref_X(i,1) = X_REF(i,1)-X_REF(i-1,1);
%    step_pos_ref_Y(i,1) = Y_REF(i,1)-Y_REF(i-1,1);
%    
%    diff_pos_X(i,:) = step_pos_ref_X(i,1) - step_pos_X(i,:);
%    diff_pos_Y(i,:) = step_pos_ref_Y(i,1) - step_pos_Y(i,:);
%    diff_pos_X10(i,:) = step_pos_ref_X(i,1) - step_pos_X10(i,:);
%    diff_pos_Y10(i,:) = step_pos_ref_Y(i,1) - step_pos_Y10(i,:);
% end

for i=1:length(X(:,1))
   diff_pos_X(i,:) = X(i,1:4)-X_REF(i,1);
   diff_pos_Y(i,:) = Y(i,1:4)-Y_REF(i,1);
   diff_pos_X10(i,:) = X10(i,1:4)-X_REF(i,1);
   diff_pos_Y10(i,:) = Y10(i,1:4)-Y_REF(i,1);

end

POS_RMS(1,:) = sqrt(mean(diff_pos_X.^2+diff_pos_Y.^2));
POS_RMS(2,:) = sqrt(mean(diff_pos_X10.^2+diff_pos_Y10.^2));


end

