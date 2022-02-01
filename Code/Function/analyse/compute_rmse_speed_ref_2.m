function [rmse_speed,diff_speed_c,diff_speed_10_c] = compute_rmse_speed(data_speed,data_speed_c,data_speed_10_c)

diff_speed_c(:,1) = data_speed.ref(:,1)-data_speed_c.sensor(:,1);
diff_speed_c(:,2) = data_speed.ref(:,1)-data_speed_c.odba(:,1);
diff_speed_10_c(:,1) = data_speed.ref(:,1)-data_speed_10_c.sensor(:,1);
diff_speed_10_c(:,2) = data_speed.ref(:,1)-data_speed_10_c.odba(:,1);

% RMSE speed heading
rmse_speed(2,1:2) = sqrt(mean(diff_speed_10_c(:,:).^2));
rmse_speed(1,1:2) = sqrt(mean(diff_speed_c(:,:).^2));
end

