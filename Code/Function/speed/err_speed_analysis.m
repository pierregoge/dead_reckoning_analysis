function [diff_speed,diff_cumul_speed] = err_speed_analysis(data_speed)

diff_speed(:,:) = data_speed.ref(:,1)-data_speed.r(:,:);
%diff_speed(:,2) = data_speed.ref(:,1)-data_speed.sensor(:,1);
% diff_speed(:,3) = data_speed.ref(:,1)-data_speed.acc_mag(:,1);

diff_cumul_speed = zeros(length(data_speed.ref(:,1)),7);

for i=2:length(data_speed.ref(:,1))
 diff_cumul_speed(i,:) = diff_cumul_speed(i-1,:) + abs(data_speed.ref(i,1)-data_speed.r(i,:));
 %diff_cumul_speed(i,2) = diff_cumul_speed(i-1,2) + abs(data_speed.ref(i,1)-data_speed.sensor(i,1));
% diff_cumul_speed(i,3) = diff_cumul_speed(i-1,3) + abs(data_speed.ref(i,1)-data_speed.acc_mag(i,1));

end


end

