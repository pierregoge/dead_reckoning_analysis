function [data_tag, data_tt,duration] = compute_openLogger_time_3(srate,data_raw,limit_analyse_1,limit_analyse_2,seconds_offset_openlogger,plot_raw_data_logger,magoffset,gyrooffset,acceloffset)

[data, time] = openlogger_compute_data(data_raw,gyrooffset,acceloffset,magoffset,srate);

if (plot_raw_data_logger == 1)
openlogger_plot_data(data.gyro,data.accel,data.mag,data.depth,data.spin,time)
end

% if (debug_signal_analyzer == 1)
%     data_a = struct2table(data);
%     data_array = table2array(data_a);
% end
% 
% FileName = data_raw.name;
% 
% a = string(FileName(1:6));
% a = strcat(FileName(1:2),{'/'},FileName(3:4),{'/20'},FileName(5:6));
% b = string(FileName(8:13));
% b = strcat(FileName(8:9),{':'},FileName(10:11),{':'},FileName(12:13),{'.0'});
% time_log = datetime(strcat(a,{' '},b),'InputFormat','dd/MM/yyyy HH:mm:ss.S');
% time_log = time_log + seconds(seconds_offset_openlogger);
% %time_analyse = (time_log:seconds(1):limit_analyse_2)';
% 
% sec = seconds(length((data.accel(:,1)))/100);
% time_end_log = time_log +sec;
% 
% 
% time_analyse = (time_log:milliseconds(10):time_end_log-seconds(0.01))';

% time_log_start = data.time(1,1) + seconds(seconds_offset_openlogger);
% time_log_end = data.time(end,1) + seconds(seconds_offset_openlogger);

t1 = datetime(limit_analyse_1,'InputFormat','yyyy-dd-MM HH:mm:ss');
t2 = datetime(limit_analyse_2,'InputFormat','yyyy-dd-MM HH:mm:ss');

data_raw.time = data_raw.time + seconds(seconds_offset_openlogger);
%Creation of timetable
%length_d = 1:length(time_analyse(:,1));
varNames = {'gyro','accel','mag'};
data_tt = timetable(data_raw.time,data.gyro(:,1:3),data.accel(:,1:3),data.mag(:,1:3),'VariableNames',varNames);
%data_s = timetable(time_analyse,data.gyro(length_d,1));
%Creation of time range
TR = timerange(t1,t2);
data_tt = data_tt(TR,:);

data_tt = retime(data_tt,'regular','fillwithmissing','TimeStep',seconds(0.01));
data_tt = fillmissing(data_tt,'linear');


length_dur = 1:size(data_tt.accel(:,1));
duration = milliseconds(length_dur)*10;
varNames = {'accel','mag','gyro'};
data_tag = timetable(duration',data_tt.accel(:,1:3),data_tt.mag(:,1:3),data_tt.gyro(:,1:3),'VariableNames',varNames);



end

