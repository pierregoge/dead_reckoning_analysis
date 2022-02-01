function [data_tag,data,data_tag_10,data_imu,data_10,data_imu_10,seq_var] = import_compute_seq_logger(seq_var)

%Filter coefficients
seq_var.freq_filter = 0.3; %Low-poss filter coefficient for accelerometer and magnetometer
seq_var.beta = 0.02; % Coefficient of madgwick filter


if seq_var.seq_id == 1
    
% Time range of analysis
seq_var.limit_analyse_1 = "2021-17-11 18:02:00"; 
seq_var.limit_analyse_2 = "2021-17-11 18:17:00";
nb_min = 15; % Swim seq number of minute

% Swim sequence analysis limit in number of sample
seq_var.limit = 1:(nb_min*6000); %100hz
seq_var.limit_10 = 1:(nb_min*600); %10hz

% Trajectry limit in number of sample
seq_var.limit_traj(1) =1000;
seq_var.limit_traj(2) =9000;

% Trajectory resting phases
seq_var.rest_lim(1,1) = 8500-seq_var.limit_traj(1); 
seq_var.rest_lim(1,2) = 8900-seq_var.limit_traj(1);

% IMU offset
% 17/11 Lagon paddle
% Offset are calculed with the openlogger_main.m script in function
seq_var.magoffset = [-0.017222017836489,-0.162013969744331,-0.177422036470117]; 
seq_var.gyrooffset = [-2.302746151840946,-1.490113616615377,-0.861883223041896];
seq_var.acceloffset = [0,0,0];
seq_var.heading_offset = -17;

%% Import file
% Openlogger variables
compute_data_logger  = 0; % Set to 1 for the first computing of the seq data
compute_data_logger_2= 0; %Set to 1 for the first computing of the seq data

seq_var.seconds_offset_openlogger = 977.9;  %977.5
seq_var.seconds_offset_openlogger_2 = -110.5;


%% Import data from openlogger tag and apply calibration
if compute_data_logger == 1
    data_raw = openlogger_load_time(); % load data file
else
    load('data_17_11.mat') 
end
[data_tag, data] = compute_openLogger_time_4(seq_var,data_raw);


%% 2nd Logger used for spin data

if compute_data_logger_2 == 1
    data_raw_2 = openlogger_load_time(); % load data file
else
    load('data_17_11_speed.mat') 
end

[datal_tag_2, datal_2] = compute_openLogger_time_5(seq_var,data_raw_2);

%Function to count the number of spin with the magnet influence on
%magnetometer
[spin_num] = mag2spin(datal_tag_2);

%Store spin in data 
data.spin = spin_num;
data_tag.spin = spin_num;

end

if seq_var.seq_id == 2
    
    
% Time range of analysis
seq_var.limit_analyse_1 = "2021-18-11 13:00:00"; 
seq_var.limit_analyse_2 = "2021-18-11 13:30:00"; 
nb_min = 30; % Swim seq number of minute

% Swim sequence analysis limit in number of sample
seq_var.limit = 1:(nb_min*6000); %100hz
seq_var.limit_10 = 1:(nb_min*600); %10hz

% Trajecotry limit in number of sample
seq_var.limit_traj(1) =1000;
seq_var.limit_traj(2) =18000;

% Trajectory resting phases
seq_var.rest_lim(1,1) = 13350-seq_var.limit_traj(1) ; 
seq_var.rest_lim(1,2) = 13620-seq_var.limit_traj(1) ;

% seq_var.rest_lim(2,1) = 17010-seq_var.limit_traj(1) ; 
% seq_var.rest_lim(2,2) = 17140-seq_var.limit_traj(1) ;


% IMU offset
% 18/11 Lagon paddle
% Offset are calculed with the openlogger_main.m scrpit in function
seq_var.magoffset = [0.004133850127342,-0.157962684522562,-0.194870008233611];
seq_var.gyrooffset = [-2.211807967423202,-1.354419506274975,-1.175978562453172];
seq_var.acceloffset = [0,0,0];
seq_var.heading_offset = -25;

%% Import file
% Openlogger variables
compute_data_logger   = 0; % Set to 1 for the first computing of the seq data
compute_data_logger_2 = 0; %Set to 1 for the first computing of the seq data

seq_var.seconds_offset_openlogger = 977.0;  %977.1;
seq_var.seconds_offset_openlogger_2 = -110.5;


%% Import data from openlogger tag and apply calibration
if compute_data_logger == 1
    data_raw = openlogger_load_time(); % load data file
else
    load('data_18_11.mat') 
end
[data_tag, data] = compute_openLogger_time_4(seq_var,data_raw);


%% 2nd Logger used for spin data

if compute_data_logger_2 == 1
    data_raw_2 = openlogger_load_time(); % load data file
else
    load('data_18_11_speed.mat') 
end

[datal_tag_2, datal_2] = compute_openLogger_time_5(seq_var,data_raw_2);

%Function to count the number of spin with the magnet influence on
%magnetometer
[spin_num] = mag2spin(datal_tag_2);

%Store spin in data 
data.spin = spin_num;
data_tag.spin = spin_num;

end

if seq_var.seq_id == 3
    
    
% Time range of analysis
seq_var.limit_analyse_1 = "2021-20-11 14:07:00"; 
seq_var.limit_analyse_2 = "2021-20-11 14:47:00";
nb_min = 40; % Swim seq number of minute

% Swim sequence analysis limit in number of sample
seq_var.limit = 1:(nb_min*6000); %100hz
seq_var.limit_10 = 1:(nb_min*600); %10hz

% Trajecotry limit in number of sample
seq_var.limit_traj(1) =1000;
seq_var.limit_traj(2) =24000;

% Trajectory resting phases
seq_var.rest_lim(1,1) = 18840-seq_var.limit_traj(1); seq_var.rest_lim(1,2) = 19090-seq_var.limit_traj(1);

seq_var.rest_lim(2,1) = 3190-seq_var.limit_traj(1); seq_var.rest_lim(2,2) = 3297-seq_var.limit_traj(1);
seq_var.rest_lim(3,1) = 8922-seq_var.limit_traj(1); seq_var.rest_lim(3,2) = 9122-seq_var.limit_traj(1);
seq_var.rest_lim(4,1) = 12390-seq_var.limit_traj(1); seq_var.rest_lim(4,2) = 12530-seq_var.limit_traj(1);

seq_var.rest_lim(5,1) = 5910-seq_var.limit_traj(1); seq_var.rest_lim(5,2) = 6093-seq_var.limit_traj(1);

seq_var.rest_lim(6,1) = 15830-seq_var.limit_traj(1); seq_var.rest_lim(6,2) = 16210-seq_var.limit_traj(1);
seq_var.rest_lim(7,1) = 18970-seq_var.limit_traj(1); seq_var.rest_lim(7,2) = 19180-seq_var.limit_traj(1);
seq_var.rest_lim(8,1) = 22080-seq_var.limit_traj(1); seq_var.rest_lim(8,2) = 22200-seq_var.limit_traj(1);

% IMU offset
% 20/11 Lagon paddle
% Offset are calculed with the openlogger_main.m scrpit in function
seq_var.magoffset = [0.151630086594739,-0.263527890104116,-0.310230011620108];
seq_var.gyrooffset = [-2.211807967423202,-1.354419506274975,-1.175978562453172];
seq_var.acceloffset = [0,0,0];
seq_var.heading_offset = -26;

%% Import file
% Openlogger variables
compute_data_logger   = 0; % Set to 1 for the first computing of the seq data
compute_data_logger_2 = 0; %Set to 1 for the first computing of the seq data

seq_var.seconds_offset_openlogger = 977.1;
seq_var.seconds_offset_openlogger_2 = -110.5;


%% Import data from openlogger tag and apply calibration
if compute_data_logger == 1
    data_raw = openlogger_load_time(); % load data file
else
    load('data_20_11.mat') 
end
[data_tag, data] = compute_openLogger_time_4(seq_var,data_raw);


%% 2nd Logger used for spin data

if compute_data_logger_2 == 1
    data_raw_2 = openlogger_load_time(); % load data file
else
    load('data_20_11_speed.mat') 
end

[datal_tag_2, datal_2] = compute_openLogger_time_5(seq_var,data_raw_2);

%Function to count the number of spin with the magnet influence on
%magnetometer
[spin_num] = mag2spin(datal_tag_2);

%Store spin in data 
data.spin = spin_num;
data_tag.spin = spin_num;


end







%%
% Downsample IMU 10hz
[data_10, data_tag_10] = downsample_openLogger(seq_var.srate(2),data,data_tag);

%Filtering IMU data with low-pass filter. Coefficient of the filter is
%finded with frequencies analysis
[data_imu_10] = compute_filter_imu(seq_var.srate(2),seq_var.freq_filter,data_tag_10);
[data_imu] = compute_filter_imu(seq_var.srate(1),seq_var.freq_filter,data_tag);

% Plot data corrected by offset of the openlogger
if (seq_var.plot_data_logger == 1)
openlogger_plot_data(data.gyro,data.accel,data.mag,data.depth,data.spin,time)
end


end

