function [speed_1hz,speed_10hz,speed_100hz] = speed_ref_gps(data_tag_1hz,gps_ref_1hz,data_tag_10hz,gps_ref_10hz,data_tag,gps_ref_100hz)

speed_1hz = zeros(length(data_tag_1hz.Time(:,1)),1);
d = zeros(length(data_tag_1hz.Time(:,1)),1);
for i=2:size(speed_1hz(:,1))
    d(i,1) = sqrt((gps_ref_1hz.x(i,1)-gps_ref_1hz.x(i-1,1)).^2+(gps_ref_1hz.y(i,1)-gps_ref_1hz.y(i-1,1)).^2);
    speed_1hz(i,1) = d(i,1)*1;
end

speed_10hz = zeros(length(data_tag_10hz.Time(:,1)),1);
d = zeros(length(data_tag_10hz.Time(:,1)),1);
for i=2:size(gps_ref_10hz(:,1))
    d(i,1) = sqrt((gps_ref_10hz.x(i,1)-gps_ref_10hz.x(i-1,1)).^2+(gps_ref_10hz.y(i,1)-gps_ref_10hz.y(i-1,1)).^2);
    speed_10hz(i,1) = d(i,1)*10;
end

speed_100hz = zeros(length(data_tag.Time(:,1)),1);
d = zeros(length(data_tag.Time(:,1)),1);
for i=2:size(gps_ref_100hz(:,1))
    d(i,1) = sqrt((gps_ref_100hz.x(i,1)-gps_ref_100hz.x(i-1,1)).^2+(gps_ref_100hz.y(i,1)-gps_ref_100hz.y(i-1,1)).^2);
    speed_100hz(i,1) = d(i,1)*100;
end

% speed_1hz = zeros(length(data_tag_1hz.Time(:,1)),1);
% d = zeros(length(data_tag_1hz.Time(:,1)),1);
% for i=2:size(speed_1hz(:,1))
%     d(i,1) = sqrt((gps_ref_1hz.x(i,1)-gps_ref_1hz.x(i-1,1)).^2+(gps_ref_1hz.y(i,1)-gps_ref_1hz.y(i-1,1)).^2);
%     speed_1hz(i,1) = d(i,1)*1;
% end
% 
% speed_10hz = zeros(length(data_tag_10hz.Time(:,1)),1);
% d = zeros(length(data_tag_10hz.Time(:,1)),1);
% for i=2:size(gps_ref_10hz(:,1))
%     d(i,1) = sqrt((gps_ref_10hz.lat(i,1)-gps_ref_10hz.lat(i-1,1)).^2+(gps_ref_10hz.lon(i,1)-gps_ref_10hz.lon(i-1,1)).^2);
%     speed_10hz(i,1) = deg2km(d(i,1))*10/1000;
% end
% 
% speed_100hz = zeros(length(data_tag.Time(:,1)),1);
% d = zeros(length(data_tag.Time(:,1)),1);
% for i=2:size(gps_ref_100hz(:,1))
%     d(i,1) = sqrt((gps_ref_100hz.lat(i,1)-gps_ref_100hz.lat(i-1,1)).^2+(gps_ref_100hz.lon(i,1)-gps_ref_100hz.lon(i-1,1)).^2);
%     speed_100hz(i,1) =  deg2km(d(i,1))*100/1000;
% end

end

