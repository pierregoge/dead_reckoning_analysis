
% Author : Pierre Gogendeau 26/11/2021

clear all
close all

%% User variablable

seq_var.seq_id = 3; % Swim sequence to analyse
seq_var.srate = [100 10];  % Sampling rate of the IMU for the swim sequence

%Plot
seq_var.plot_data_logger = 0; % Openlogger data corrected with offset

%% Librairies and speed model
%Adding librairies, change to location with the download libraries
path = ('C:\Users\Andrea\Documents\These\Seafile\Code\Matlab');

addpath(genpath(strcat(path,'\Functions')));
addpath(genpath(strcat(path,'\Scripts_analyse')));
addpath(genpath(strcat(path,'\Scripts globaux')));
addpath(genpath(strcat(path,'\Autre travaux\madgwick_algorithm_matlab')));

%Load speed model
load('speed_model_test_1.mat') %10Hz
load('speed_model_test_2.mat') %100Hz

%% Import and process logger and GPS data
% Logger data
[data_tag,data,data_tag_10,data_imu,data_10,data_imu_10,seq_var] = import_compute_seq_logger(seq_var);
% Ground-trhuth GPS data
[data_ref, data_ref_10,seq_var] = import_compute_seq_gps(seq_var,data);

%% Compute orientation
% 100Hz
% [madgwick(:,3),madgwick(:,1),madgwick(:,2)] = compute_madgwick_filter_2(data_imu,seq_var.beta,seq_var.srate(1));
% [saam(:,3),saam(:,1),saam(:,2)] = compute_trigo_orientation_2(data_imu);
% 10Hz
[madgwick_10(:,3),madgwick_10(:,1),madgwick_10(:,2)] = compute_madgwick_filter_2(data_imu_10,seq_var.beta,seq_var.srate(2));
[saam_10(:,3),saam_10(:,1),saam_10(:,2)] = compute_trigo_orientation_2(data_imu_10);

%Creation of timetables for heading
% 100Hz
[data_heading, data_pitch] = orientation_timetable(data_tag,data_ref,madgwick,saam);
% 10Hz
[data_heading_10, data_pitch_10] = orientation_timetable(data_tag_10,data_ref_10,madgwick_10,saam_10);

clear madgwick madgwick_10 saam saam_10

%% Compute Speed
%100Hz
[speed_raw,data_analyse_speed] = compute_speed_variable(seq_var.srate(1),data_tag,data_imu,data_ref);
speed_predict(:,1) = speed_test_no_spin.predictFcn(data_analyse_speed(:,1:6));
speed_predict(:,2) = speed_test_spin_no_odba.predictFcn(data_analyse_speed(:,1:6));

%10hz
[speed_raw_10,data_analyse_speed_10] = compute_speed_variable(seq_var.srate(2),data_tag_10,data_imu_10,data_ref_10);
speed_predict_10(:,1) = speed_test_no_spin_10.predictFcn(data_analyse_speed_10(:,1:6));
speed_predict_10(:,2) = speed_test_spin_no_odba_10.predictFcn(data_analyse_speed_10(:,1:6));


% Creation of timetables to compute trajectories
%Create of timetables for speed
varNames = {'ref','odba','sensor'};
% 100Hz
data_speed = timetable(data_tag.Time,speed_raw(1:length(speed_predict(:,1)),1),speed_predict(:,1),speed_predict(:,2),'VariableNames',varNames);
% 10Hz
data_speed_10 = timetable(data_tag_10.Time,speed_raw_10(:,1),speed_predict_10(:,1),speed_predict_10(:,2),'VariableNames',varNames);

clear speed_predict speed_predict_10 speed_raw speed_raw_10 data_analyse_speed data_analyse_speed_10 varNames madgwick madgwick_10 saam saam_10

%% Prepare data to be analyzed and to compute trajectory
% Downsampling to 10Hz orientation and speed to be compared with reference
% system
[data_heading,data_pitch] = downsample_openLogger_firstvalue(seq_var.srate(2),data_heading,data_pitch);
[data_speed,data_speed_test] = downsample_openLogger_mean(seq_var.srate(2),data_speed,data_speed);

% 100Hz
% Adding heading offset of dual GPS system
[data_heading] = add_heading_offset_ref(data_heading,seq_var.gps_orientation);
% Adding heading offset of logger
[data_heading] = add_heading_offset(data_heading,seq_var.heading_offset);
% 10Hz
% Adding heading offset of dual GPS system
[data_heading_10] = add_heading_offset_ref(data_heading_10,seq_var.gps_orientation);
% Adding heading offset of logger
[data_heading_10] = add_heading_offset(data_heading_10,seq_var.heading_offset);

%Set reference on speed and heading with the 10Hz reference
data_heading.ref = data_heading_10.ref;
data_speed.ref = data_speed_10.ref;

%% Heading and speed analyse 
%Variables of the analyze limit fixed 
lim1 = seq_var.limit_traj(1);
lim2 = seq_var.limit_traj(2);

% 100Hz
% Error for speed and heading angle of the turtle compare to the reference
% on the turtle frame
[diff_speed,diff_cumul_speed, diff_heading,diff_cumul_heading] = err_speed_heading(data_heading(lim1:lim2,:),data_speed(lim1:lim2,:));
% Error for speed and heading angle of the turtle compare to the reference
% on the earth frame
%[diff_speed_2,diff_cumul_speed_2, diff_heading_2,diff_cumul_heading_2] = err_speed_heading_ref_2(data_heading(lim1:lim2,:),data_speed(lim1:lim2,:));

% 10Hz
% Error for speed and heading angle of the turtle compare to the reference
% on the turtle frame
[diff_speed_10,diff_cumul_speed_10, diff_heading_10,diff_cumul_heading_10] = err_speed_heading(data_heading_10(lim1:lim2,:),data_speed_10(lim1:lim2,:));

% RMSE speed and heading
% 100Hz
rmse_heading(1,:) = sqrt(mean(diff_heading(:,:).^2));
rmse_speed(1,:) = sqrt(mean(diff_speed(:,:).^2));
%rmse_heading(3,:) = sqrt(mean(diff_heading_2(:,:).^2));
% 10Hz
rmse_heading(2,:) = sqrt(mean(diff_heading_10(:,:).^2)); 
rmse_speed(2,:) = sqrt(mean(diff_speed_10(:,:).^2));


%% Trajectory
% 100hz
%Compute trajectories with estimated heading and speed
[X(:,1:2),Y(:,1:2),Z(:,1:2)] = compute_traj_2(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed.sensor(lim1:lim2,1),0,seq_var.srate(2));
[X(:,3:4),Y(:,3:4),Z(:,3:4)] = compute_traj_2(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed.odba(lim1:lim2,1),0,seq_var.srate(2));
%Compute rajectory with reference heading and speed
[X(:,5),Y(:,5),Z(:,5)] = compute_traj_speed_analysis_heading_ref(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed.ref(lim1:lim2,1),0,seq_var.srate(2));

%Trajectories test mixing reference and estimated data
% [X(:,6:7),Y(:,6:7),Z(:,6:7)] = compute_traj_2(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed.ref(lim1:lim2,1),0,seq_var.srate(2));
% [X(:,8),Y(:,8),Z(:,8)] = compute_traj_speed_analysis_heading_ref(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed.ref(lim1:lim2,1),0,seq_var.srate(2));
% [X(:,9),Y(:,9),Z(:,9)] = compute_traj_speed_analysis_heading_ref(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed.sensor(lim1:lim2,1),0,seq_var.srate(2));

% Geolocate traj with the first GPS position of the analysis
lat_traj = km2deg((data_ref_10.x(lim1,1)+Y(:,:))/1000);
lon_traj = km2deg((data_ref_10.y(lim1,1)+X(:,:))/1000);

% 10hz
%Compute trajectories with estimated heading and speed
[X10(:,1:2),Y10(:,1:2),Z10(:,1:2)] = compute_traj_2(data_pitch_10(lim1:lim2,:),data_heading_10(lim1:lim2,:),data_speed_10.sensor(lim1:lim2,1),0,seq_var.srate(2));
[X10(:,3:4),Y10(:,3:4),Z10(:,3:4)] = compute_traj_2(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed_10.odba(lim1:lim2,1),0,seq_var.srate(2));
%Compute rajectory with reference heading and speed
[X10(:,5),Y10(:,5),Z10(:,5)] = compute_traj_speed_analysis_heading_ref(data_pitch_10(lim1:lim2,:),data_heading_10(lim1:lim2,:),data_speed_10.ref(lim1:lim2,1),0,seq_var.srate(2));

% Geolocate traj with the first GPS position of the analysis
lat_traj_10 = km2deg((data_ref_10.x(lim1,1)+Y10(:,:))/1000);
lon_traj_10 = km2deg((data_ref_10.y(lim1,1)+X10(:,:))/1000);

%% 2DRMS for Trajectory analyse 

[POS_RMS(1:2,:)] = compute_2DRMS(X,X10,Y,Y10,X(:,5),Y(:,5));


%% Plot trajectories
figure(15)
geoscatter(data_ref_10.lat(lim1:lim2,1),data_ref_10.lon(lim1:lim2,1),0.5,'g');
hold on
for i=1:length(seq_var.rest_lim(:,1))
geoscatter(data_ref_10.lat(seq_var.rest_lim(i,1):50:seq_var.rest_lim(i,2),1),data_ref_10.lon(seq_var.rest_lim(i,1):50:seq_var.rest_lim(i,2),1),100,'g*');
end
geobasemap("satellite");
hold on
geoscatter(lat_traj(:,5),lon_traj(:,5),0.5,'y');
geoscatter(lat_traj(:,1),lon_traj(:,1),0.5,'b');
geoscatter(lat_traj(:,3),lon_traj(:,3),0.5,'r');
     
     
%% Compute marine current and correct trajectories
[vec_vel_current,current_angle,current_strength] = compute_marine_current(seq_var,X,Y);

[data_speed_c,data_speed_10_c] = correct_speed_current(data_heading,data_speed,data_heading_10,data_speed_10,vec_vel_current);

% 100Hz
[X_C(:,1:2),Y_C(:,1:2),Z_C(:,1:2)] = compute_traj_2(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed_c.sensor(:,1),0,seq_var.srate(2));
[X_C(:,3:4),Y_C(:,3:4),Z_C(:,3:4)] = compute_traj_2(data_pitch(lim1:lim2,:),data_heading(lim1:lim2,:),data_speed_c.odba(:,1),0,seq_var.srate(2));
% Geolocate traj with the first GPS position of the analysis
lat_traj_c = km2deg((data_ref_10.x(lim1,1)+Y_C(:,:))/1000);
lon_traj_c = km2deg((data_ref_10.y(lim1,1)+X_C(:,:))/1000);

% 10Hz
[X10_C(:,1:2),Y10_C(:,1:2),Z10_C(:,1:2)] = compute_traj_2(data_pitch_10(lim1:lim2,:),data_heading_10(lim1:lim2,:),data_speed_10_c.sensor(:,1),0,seq_var.srate(2));
[X10_C(:,3:4),Y10_C(:,3:4),Z10_C(:,3:4)] = compute_traj_2(data_pitch_10(lim1:lim2,:),data_heading_10(lim1:lim2,:),data_speed_10_c.odba(:,1),0,seq_var.srate(2));
% Geolocate traj with the first GPS position of the analysis
lat_traj_10_c = km2deg((data_ref_10.x(lim1,1)+Y_C(:,:))/1000);
lon_traj_10_c = km2deg((data_ref_10.y(lim1,1)+X_C(:,:))/1000);

%% Sspeed and 2DRMS corrected with current analyse 

% RMSE speed
[rmse_speed(3:4,1:2),diff_speed_c,diff_speed_10_c] = compute_rmse_speed(data_speed(lim1:lim2,:),data_speed_c(lim1:lim2,:),data_speed_10_c(lim1:lim2,:));
% 2DMRS
[POS_RMS(3:4,:)] = compute_2DRMS(X_C,X10_C,Y_C,Y10_C,X(:,5),Y(:,5));

%% Trajectories distances calculation

[delta_d,distance] = compute_distance(X,Y,X10,Y10,X_C,Y_C,X10_C,Y10_C);


%% Plot trajectories corrected with current
figure(15)
geoscatter(data_ref_10.lat(lim1:lim2,1),data_ref_10.lon(lim1:lim2,1),0.5,'g');
hold on
%geoscatter(data_ref_10.lat(8311:50:8942,1),data_ref_10.lon(8311:50:8942,1),100,'g*');
%geoscatter(gps_ref_10.lat(16830:100:17180,1),gps_ref_10.lon(16830:100:17180,1),100,'g*');
geobasemap("satellite");
hold on
geoscatter(lat_traj_c(:,1),lon_traj_c(:,1),0.5,'b');
geoscatter(lat_traj_c(:,3),lon_traj_c(:,3),0.5,'r');

%% Compute distance

d=zeros(length(X(:,5)),5);
d(1,1) = 0;
% d1=zeros(limit_traj_10(2)-limit_traj_10(1),1);
% d1(1,1) = 0;
inc = 1;
for j=1:5
for i=2:length(X(:,5))-1
    d(i,j) = d(i-1,j) + sqrt((X(i,j)-X(i-1,j))^2+(Y(i,j)-Y(i-1,j))^2);
    %d1(inc+1,1) = d1(inc,1) + speed_10(i)/10;   
end
end
d(end-1,5)
%% Plot analyse

% Plot geoscatter with variables for article 1 speed analysis
plot_speed(1) = 1;
plot_speed(2) = 4;
lat_traj_1 = lat_traj(:,plot_speed(1));
lat_traj_2 = lat_traj(:,plot_speed(2));
lon_traj_1 = lon_traj(:,plot_speed(1));
lon_traj_2 = lon_traj(:,plot_speed(2));
diff_speed_1 = diff_speed(:,1); % Speed sensor error
diff_speed_2 = diff_speed(:,2); % Speed ODBA error
diff_heading_1 = diff_heading(:,1); % Heading madgwick error
diff_heading_2 = diff_heading(:,2); % Heading SAAM error

plot_traj_speed_heading_error(data_ref_10,lat_traj_1,lat_traj_2,lon_traj_1,lon_traj_2,diff_speed_1,diff_speed_2,diff_heading_1,diff_heading_2,lim1,lim2,data_speed,seq_var)

% YMatrix1 = [lat_traj_1 lat_traj_2 data_ref_10.lat(lim1:lim2,1) diff_speed_1 diff_speed_2];
% axes2 = [lon_traj_1 lon_traj_2 data_ref_10.lon(lim1:lim2,1)];
% YMatrix2 = [diff_heading_1 diff_heading_1];
% create_figure_article_1_heading_speed(YMatrix1, axes2, YMatrix2)

% Plot ellispe 100hz
% 100hz

uncert_var = (2*POS_RMS(3,:))/length(X(:,1));

for i=1:length(X(:,1))
    uncert(i,:) = uncert_var*i;
end

plot_nb = 2;
plot_ellispe_2(plot_nb,uncert,uncert,X_C,Y_C,data_ref_10(lim1:lim2,:),lat_traj,lon_traj,lat_traj_c,lon_traj_c,data_heading.ref(lim1:lim2,:),0)


% Electrical consumption in mA
[e_cons] = electrical_consumption_1();

% % Plot the tradeoff CEP vs power
plot_drms_consumption(POS_RMS,e_cons)

%%

% Plot geoscatter with variables for article 1 speed analysis
plot_speed(1) = 1;
plot_speed(2) = 1;
lat_traj_1 = lat_traj(:,plot_speed(1));
lat_traj_2 = lat_traj_c(:,plot_speed(2));
lon_traj_1 = lon_traj(:,plot_speed(1));
lon_traj_2 = lon_traj_c(:,plot_speed(2));
diff_speed_1 = diff_speed(:,1); % Speed sensor error
diff_speed_2 = diff_speed_c(:,1); % Speed ODBA error
diff_heading_1 = diff_heading(:,1); % Heading madgwick error
diff_heading_2 = diff_heading(:,1); % Heading SAAM error

plot_traj_speed_error(data_ref_10,lat_traj_1,lat_traj_2,lon_traj_1,lon_traj_2,diff_speed_1,diff_speed_2,diff_heading_1,diff_heading_2,lim1,lim2,data_speed,seq_var)


