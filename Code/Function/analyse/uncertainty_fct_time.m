function [u_x, u_y,u_speed, u_heading] = uncertainty_fct_time(rmse_X,rmse_Y,rmse_eul_yaw,rmse_speed,srate,limit_analyse)

sampling_freq_max = srate;
size_analyse = length(limit_analyse);

u_x = (rmse_X/size_analyse);%*sampling_freq_max;
u_y = (rmse_Y/size_analyse);%*sampling_freq_max;

u_speed = (rmse_speed);%/size_analyse);
u_heading = (rmse_eul_yaw);%/size_analyse);

% u_speed = sqrt(mean(diff_cumul_speed(limit_analyse,:).^2))./limit_analyse;
% u_heading = sqrt(mean(diff_cumul_eul_yaw(limit_analyse,:).^2))./limit_analyse;

end