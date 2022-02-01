function [data_tag,data] = compute_odba(data_imu,data_tag,data,duration)

odba = ODBA(data_imu.accel_d(:,1),data_imu.accel_d(:,2),data_imu.accel_d(:,3));


data_tag = addvars(data_tag,odba,'NewVariableNames','odba');
data = addvars(data,odba,'NewVariableNames','odba');

% odba_smooth = smoothdata(data_tag.odba,'movmean',15,'SamplePoints',duration');
% 
% data_tag = addvars(data_tag,odba_smooth,'NewVariableNames','odba_smooth');
% data = addvars(data,odba_smooth,'NewVariableNames','odba_smooth');
end

