function [gps] = compute_gps(data_1,data_2,hours_offset_rtk,limit_analyse_1,limit_analyse_2)

a = string(data_1.time);
b = string(data_1.date);
time_gps_1 = datetime(strcat(b,{' '},a),'InputFormat','yyyy/MM/dd HH:mm:ss.SSS');
time_gps_1 = time_gps_1 + hours(hours_offset_rtk);

a = string(data_2.time);
b = string(data_2.date);
time_gps_2 = datetime(strcat(b,{' '},a),'InputFormat','yyyy/MM/dd HH:mm:ss.SSS');
time_gps_2 = time_gps_2 + hours(hours_offset_rtk);

varNames = {'lat','lon','h','p_lat','p_lon'};
gps_1 = timetable(time_gps_1,data_1.lat,data_1.lon,data_1.h,data_1.VarName8,data_1.VarName9,'VariableNames',varNames);
gps_2 = timetable(time_gps_2,data_2.lat,data_2.lon,data_2.h,data_2.VarName8,data_2.VarName9,'VariableNames',varNames);

t1 = datetime(limit_analyse_1,'InputFormat','yyyy-dd-MM HH:mm:ss');
t2 = datetime(limit_analyse_2,'InputFormat','yyyy-dd-MM HH:mm:ss');

%Creation of time range
TR = timerange(t1,t2);
gps_1 = gps_1(TR,:);
gps_2 = gps_2(TR,:);

gps_2 = retime(gps_2,'regular','fillwithmissing','TimeStep',seconds(0.1));
gps_1 = retime(gps_1,'regular','fillwithmissing','TimeStep',seconds(0.1));

gps = synchronize(gps_2,gps_1);


end

