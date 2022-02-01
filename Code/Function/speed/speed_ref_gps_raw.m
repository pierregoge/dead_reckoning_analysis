function [speed] = speed_ref_gps_raw(data_tag,gps_ref,srate)

speed = zeros(length(data_tag.Time(:,1)),1);
d = zeros(length(data_tag.Time(:,1)),1);
for i=2:size(gps_ref(:,1))
    d(i,1) = sqrt((gps_ref.x(i,1)-gps_ref.x(i-1,1)).^2+(gps_ref.y(i,1)-gps_ref.y(i-1,1)).^2);
    speed(i,1) = d(i,1)*srate;
end


end

