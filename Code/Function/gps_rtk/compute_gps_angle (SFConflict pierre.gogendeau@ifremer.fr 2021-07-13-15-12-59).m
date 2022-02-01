function [gps_ref,gps_ref_a] = compute_gps_angle(gps_1,gps_2)

wgs84 = wgs84Ellipsoid('centimeter');
len = length(gps_2.time_gps_2(:,1));

[x1,y1,z1] = geodetic2ecef(wgs84,gps_1.lat(1:len),gps_1.lon(1:len),gps_1.h(1:len));
[x2,y2,z2] = geodetic2ecef(wgs84,gps_2.lat,gps_2.lon,gps_2.h);


% [x1,y1,z1] = geodetic2ecef(wgs84,gps_1.lat,gps_1.lon,gps_1.h);
% [x2,y2,z2] = geodetic2ecef(wgs84,gps_2.lat,gps_2.lon,gps_2.h);
% 
% varNames = {'x','y','z'};
% pos_1 = timetable(gps_1.time_gps_1,x1,y1,z1,'VariableNames',varNames);
% pos_2 = timetable(gps_2.time_gps_2,x2,y2,z2,'VariableNames',varNames);
% 
% 
% nb_sec = 0.1;
% dt = seconds(nb_sec);
% pos_1 = retime(pos_1,'regular','previous','TimeStep',dt);
% pos_2 = retime(pos_2,'regular','previous','TimeStep',dt);
% 
% %Distance and angle of system
% d = sqrt((pos_2.x-pos_1.x).^2+(pos_2.y-pos_1.y).^2);
% angle = atan2(pos_2.y - pos_1.y, pos_2.x - pos_1.x) * 180 / pi;

d = sqrt((x2-x1).^2+(y2-y1).^2);
angle = atan2(y2 - y1, x2 - x1) * 180 / pi;

varNames = {'x','y','z','angle'};
gps_ref = timetable(gps_2.time_gps_2,x1,y1,z1,angle,'VariableNames',varNames);
%gps_ref = timetable(pos_1.Time,pos_1.x,pos_1.y,pos_1.z,angle,'VariableNames',varNames);

nb_sec = 1;
dt = seconds(nb_sec);
gps_ref = retime(gps_ref,'regular','mean','TimeStep',dt);

length_dur = 1:size(gps_ref.Time);
duration = seconds(length_dur);

varNames = {'angle'};
gps_ref_a = timetable(duration',gps_ref.angle,'VariableNames',varNames);

end

