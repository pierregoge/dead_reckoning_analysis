function [data_analyse_speed] = compute_variable_speed(data_imu,data_tag,odba,speed,limit,smooth_coeff_speed)

limit_speed_analyse = limit;
data_analyse_speed(:,1:3) = data_imu.accel(limit_speed_analyse,1:3);
data_analyse_speed(:,4:6) = data_imu.mag(limit_speed_analyse,1:3);
data_analyse_speed(:,7:9) = data_imu.gyro(limit_speed_analyse,1:3);
% data_analyse_speed(:,10:12) = v_acc_turtle_d(limit_speed_analyse,1:3);
data_analyse_speed(:,13) = data_tag.spin(limit_speed_analyse,1);
data_analyse_speed(:,14) = filloutliers(odba,'nearest','mean');
data_analyse_speed(:,15) = speed(limit_speed_analyse,1);
data_analyse_speed(:,16) = smoothdata(speed(limit_speed_analyse,1),'movmean',smooth_coeff_speed);%speed_100hz(limit_speed_analyse,1);%

end

