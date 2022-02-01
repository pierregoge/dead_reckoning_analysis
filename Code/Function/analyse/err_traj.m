
function [diff_pos_X,diff_pos_Y,err_cumul_pos_X,err_cumul_pos_Y ] = err_traj(pos_X_NED,pos_Y_NED)

diff_pos_X = pos_X_NED(:,1) - pos_X_NED(:,2:end);
diff_pos_Y = pos_Y_NED(:,1) - pos_Y_NED(:,2:end);


err_cumul_pos_X = zeros(length(pos_X_NED(:,1)),length(diff_pos_X(1,:)));
err_cumul_pos_Y = zeros(length(pos_X_NED(:,1)),length(diff_pos_X(1,:)));


for i=2:length(pos_X_NED(:,1))-1
    err_cumul_pos_X(i,:) = err_cumul_pos_X(i-1,:) + abs(diff_pos_X(i,:));
    err_cumul_pos_Y(i,:) = err_cumul_pos_Y(i-1,:) + abs(diff_pos_Y(i,:));
  
   
end

end


