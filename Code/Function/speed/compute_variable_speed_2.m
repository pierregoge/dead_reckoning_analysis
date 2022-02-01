function [data_analyse_speed,limit_speed_analyse] = compute_variable_speed_2(limit,odba,nb_spin,no_spin,data_tag,v_acc_ned_3axis_f,speed_100,speed_100_raw)
limit_speed_analyse = limit(1):limit(end); %60000:180000; 61000:138000; %
data_analyse_speed(:,1) = no_spin(limit_speed_analyse,1);
data_analyse_speed(:,2) = smoothdata(nb_spin(limit_speed_analyse,1),'movmean','SmoothingFactor',0.3);
data_analyse_speed(:,3) = nb_spin(limit_speed_analyse,1);
data_analyse_speed(:,5) = data_tag.spin(limit_speed_analyse,1);


data_analyse_speed(:,4) = smoothdata(odba(limit_speed_analyse,1),'movmean','SmoothingFactor',0.5);
data_analyse_speed(:,6) = odba(limit_speed_analyse,1);
% data_analyse_speed(:,7) = v_acc_ned_3axis_f;
% data_analyse_speed(:,8) = data_imu.accel_d(:,1);
% data_analyse_speed(:,9) = data_imu.accel_d(:,2);

data_analyse_speed(:,7) = speed_100(limit_speed_analyse,1);
data_analyse_speed(:,8) = speed_100_raw(limit_speed_analyse,1);

end

