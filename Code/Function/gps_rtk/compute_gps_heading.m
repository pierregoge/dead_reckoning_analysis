function [gps_ref,gps_ref_a] = compute_gps_heading(gps,gps_ref_1)


angle = atan2((gps.lon_gps_2 - gps.lon_gps_1), (gps.lat_gps_2 - gps.lat_gps_1)) * 180 / pi;

lon = (gps.lon_gps_2 + gps.lon_gps_1)/2;
lat = (gps.lat_gps_2 + gps.lat_gps_1)/2;

gps.lon_gps_2 = smoothdata(gps.lon_gps_2,'movmean','SmoothingFactor',0.001);
gps.lon_gps_1 = smoothdata(gps.lon_gps_1,'movmean','SmoothingFactor',0.001);

gps.lat_gps_2 = smoothdata(gps.lat_gps_2,'movmean','SmoothingFactor',0.001);
gps.lat_gps_1 = smoothdata(gps.lat_gps_1,'movmean','SmoothingFactor',0.001);


lon_f = (gps.lon_gps_2 + gps.lon_gps_1)/2;
lat_f = (gps.lat_gps_2 + gps.lat_gps_1)/2;

angle(:,2) = atan2((gps.lon_gps_2 - gps.lon_gps_1), (gps.lat_gps_2 - gps.lat_gps_1)) * 180 / pi;

for i=2:length(gps.lon_gps_1(:,1))
    angle2(i,1) = atan2((gps.lon_gps_1(i,1) - gps.lon_gps_1(i-1,1)), (gps.lat_gps_1(i,1) - gps.lat_gps_1(i-1,1))) * 180 / pi;
    angle3(i,1) = atan2((lon_f(i,1) - lon_f(i-1,1)), (lat_f(i,1) - lat_f(i-1,1))) * 180 / pi;
    angle4(i,1) = atan2((gps.lon_gps_2(i,1) - gps.lon_gps_2(i-1,1)), (gps.lat_gps_2(i,1) - gps.lat_gps_2(i-1,1))) * 180 / pi;
end

x2 = deg2km(gps.lat_gps_2)*1000;
y2 = deg2km(gps.lon_gps_2)*1000;
x1 = deg2km(gps.lat_gps_1)*1000;
y1 = deg2km(gps.lon_gps_1)*1000;
z2 = zeros(length(x2(:,1)),1);

x_f = deg2km(lat_f)*1000;
y_f = deg2km(lon_f)*1000;

x = deg2km(lat)*1000;
y = deg2km(lon)*1000;


d = sqrt((x2-x1).^2+(y2-y1).^2);%+(z2-z1).^2);


angle = angle -90;
for i=1:length(angle(:,1))
    if (angle(i,1) < -180)
        angle(i,1) = angle(i,1)+(2*180);
    elseif  (angle(i,1) > 180)
        angle(i,1) = angle(i,1)-(2*180);
    end
end
            
varNames = {'x','y','x_f','y_f','heading','lat','lon','lat_f','lon_f','heading2'};
gps_ref = timetable(gps.time_gps_2,x,y,x_f,y_f,angle(:,gps_ref_1),lat,lon,lat_f,lon_f,angle3,'VariableNames',varNames);

length_dur = 1:size(gps_ref.Time);
duration = seconds(length_dur/10);

varNames = {'heading','heading2'};
gps_ref_a = timetable(duration',gps_ref.heading,gps_ref.heading2,'VariableNames',varNames);


end

