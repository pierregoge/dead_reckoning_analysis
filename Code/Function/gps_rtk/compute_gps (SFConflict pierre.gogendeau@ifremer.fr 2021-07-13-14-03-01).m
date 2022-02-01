function [gps_1,gps_2] = compute_gps(data_1,data_2,hours_offset_rtk,limit_analyse_1,limit_analyse_2)

a = string(data_1.time);
b = string(data_1.date);
time_gps_1 = datetime(strcat(b,{' '},a),'InputFormat','yyyy/MM/dd HH:mm:ss.S');
time_gps_1 = time_gps_1 + hours(hours_offset_rtk);

a = string(data_2.time);
b = string(data_2.date);
time_gps_2 = datetime(strcat(b,{' '},a),'InputFormat','yyyy/MM/dd HH:mm:ss.S');
time_gps_2 = time_gps_2 + hours(hours_offset_rtk);

varNames = {'lat','lon','h','p_lat','p_lon','x','y','z'};
gps_1 = timetable(time_gps_1,data_1.lat,data_1.lon,data_1.h,data_1.VarName8,data_1.VarName9,data_1.lat,data_1.lat,data_1.lat,'VariableNames',varNames);
gps_2 = timetable(time_gps_2,data_2.lat,data_2.lon,data_2.h,data_2.VarName8,data_2.VarName9,data_2.lat,data_2.lat,data_2.lat,'VariableNames',varNames);

%Creation of time range
TR = timerange(limit_analyse_1,limit_analyse_2);
gps_1 = gps_1(TR,:);
gps_2 = gps_2(TR,:);

end

