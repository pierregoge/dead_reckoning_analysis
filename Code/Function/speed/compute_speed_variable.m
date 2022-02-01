function [speed_raw,data_analyse_speed] = compute_speed_variable(srate,data_tag,data_imu,gps_ref)


[speed] = speed_ref_gps_1(data_tag,gps_ref,srate);
[speed_raw] = speed_ref_gps_raw(data_tag,gps_ref,srate);

odba = ODBA(data_imu.accel_d(:,1),data_imu.accel_d(:,2),data_imu.accel_d(:,3));
odba_f = filloutliers(odba,'nearest','mean');

nb_min_spin = 0;
[no_spin,spin,nb_spin] = no_spin_detector(data_tag,nb_min_spin);

data_analyse_speed(:,1) = no_spin(:,1);
data_analyse_speed(:,2) = smoothdata(data_tag.spin(:,1),'movmean','SmoothingFactor',0.3);
data_analyse_speed(:,3) = data_tag.spin(:,1);
data_analyse_speed(:,5) = data_tag.spin(:,1);
data_analyse_speed(:,4) = smoothdata(odba(:,1),'movmean','SmoothingFactor',0.5);
data_analyse_speed(:,6) = odba(:,1);
data_analyse_speed(:,7) = speed(:,1);
data_analyse_speed(:,8) = speed_raw(:,1);
end

