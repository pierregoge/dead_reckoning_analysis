function [data,time] = openlogger_compute_data(data_raw,gyrooffset,acceloffset,magoffset,srate)

[r,c]=size(data_raw.accel);  
time=[0:r-1]/srate(1);  % create time scale in seconds

% Settings for OpenTag oriented in potted fashion with SD card up. 
accelsign=[1 1 1]; %NED  % sign (y, x, z with swapping)
magsign=[1 1 1]; %NED
gyrosign=[1 1 1]; %NED

% Vectors to hold rearranged data
data.accel=[];
data.mag=[];
data.gyro=[];
%data.spin = data_raw.spin;

%Extrapolate depth value sampled at 1Hz
[data.depth,TF] = fillmissing(data_raw.depth,'linear','SamplePoints',time);
[data.spin,TF] = fillmissing(data_raw.spin,'linear','SamplePoints',time);

k=2;  % read in y first, so can swap with x
data.accel=[data.accel (data_raw.accel(:,k)-acceloffset(k))*accelsign(k)]; %correct acceloffset
data.gyro=[data.gyro, (data_raw.gyro(:,k)-gyrooffset(k))*gyrosign(k)]; %correct gyrooffset   
data.mag=[data.mag (data_raw.mag(:,k)-magoffset(k))*magsign(k)]; %correct magoffset

k=1;  
data.accel=[data.accel (data_raw.accel(:,k)-acceloffset(k))*accelsign(k)]; %correct acceloffset
data.gyro=[data.gyro, (data_raw.gyro(:,k)-gyrooffset(k))*gyrosign(k)]; %correct gyrooffset    
data.mag=[data.mag (data_raw.mag(:,k)-magoffset(k))*magsign(k)]; %correct magoffset

k=3;  % read in z
data.accel=[data.accel (data_raw.accel(:,k)-acceloffset(k))*accelsign(k)]; %correct acceloffset
data.gyro=[data.gyro, (data_raw.gyro(:,k)-gyrooffset(k))*gyrosign(k)]; %correct gyrooffset
data.mag=[data.mag (data_raw.mag(:,k)-magoffset(k))*magsign(k)]; %correct magoffset


end

