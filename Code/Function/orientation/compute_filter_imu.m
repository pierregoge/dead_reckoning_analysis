function [data_imu] = compute_filter_imu(srate,freq,data_tag)

% %Filter accel data
accel_d = highpass(data_tag.accel,freq,srate,'Steepness',0.85,'StopbandAttenuation',60);
% %Filter mag data to avoid artefact
mag_d =  highpass(data_tag.mag,freq,srate,'Steepness',0.85,'StopbandAttenuation',60);
%  accel_d = data_tag.accel*0;
% % %Filter mag data to avoid artefact
%  mag_d = data_tag.accel*0;

accel_g = data_tag.accel - accel_d;
mag_g = data_tag.mag - mag_d;

varNames = {'accel','mag','accel_d','accel_g','mag_d','mag_g','gyro'};
data_imu = timetable(data_tag.Time,data_tag.accel(:,1:3),data_tag.mag(:,1:3),accel_d(:,1:3),accel_g(:,1:3),mag_d(:,1:3),mag_g(:,1:3),data_tag.gyro(:,1:3),'VariableNames',varNames);


end

