function [rmse_X,rmse_Y] = rmse_axis(diff_pos_X,diff_pos_Y,limit_rmse)

rmse_X = sqrt(mean(diff_pos_X(limit_rmse,:).^2));
rmse_Y = sqrt(mean(diff_pos_Y(limit_rmse,:).^2));

end

