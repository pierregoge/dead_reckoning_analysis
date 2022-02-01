function [data_tag, data_tt] = compute_openLogger_time_4(seq_var,data_raw)

[data, time] = openlogger_compute_data(data_raw,seq_var.gyrooffset,seq_var.acceloffset,seq_var.magoffset,seq_var.srate);

t1 = datetime(seq_var.limit_analyse_1,'InputFormat','yyyy-dd-MM HH:mm:ss');
t2 = datetime(seq_var.limit_analyse_2,'InputFormat','yyyy-dd-MM HH:mm:ss');

data_raw.time = data_raw.time + seconds(seq_var.seconds_offset_openlogger);
%Creation of timetable
varNames = {'gyro','accel','mag','depth','spin'};
data_tt = timetable(data_raw.time,data.gyro(:,1:3),data.accel(:,1:3),data.mag(:,1:3),data.depth(:,1),data.spin(:,1),'VariableNames',varNames);

%Creation of time range
TR = timerange(t1,t2);
data_tt = data_tt(TR,:);

data_tt = retime(data_tt,'regular','fillwithmissing','TimeStep',seconds(0.01));
data_tt = fillmissing(data_tt,'linear');

length_dur = 1:size(data_tt.accel(:,1));
duration = milliseconds(length_dur)*10;
varNames = {'accel','mag','depth','spin','gyro'};
data_tag = timetable(duration',data_tt.accel(:,1:3),data_tt.mag(:,1:3),data_tt.depth(:,1),data_tt.spin(:,1),data_tt.gyro(:,1:3),'VariableNames',varNames);



end

