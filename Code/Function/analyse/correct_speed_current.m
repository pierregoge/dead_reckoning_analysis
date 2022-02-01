function [data_speed_c,data_speed_10_c] = correct_speed_current(data_heading,data_speed,data_heading_10,data_speed_10,vec_vel_current)

for i =1:length(data_heading.ref(:,1))
   % 100Hz
   [vec_vel(i,1), vec_vel(i,2)] = pol2cart(data_heading.ref(i,1)*pi/180,data_speed.odba(i,1));
   [vec_vel_2(i,1), vec_vel_2(i,2)] = pol2cart(data_heading.ref(i,1)*pi/180,data_speed.sensor(i,1)); 
   % 10Hz
   [vec_vel_10(i,1), vec_vel_10(i,2)] = pol2cart(data_heading_10.ref(i,1)*pi/180,data_speed_10.odba(i,1));
   [vec_vel_2_10(i,1), vec_vel_2_10(i,2)] = pol2cart(data_heading_10.ref(i,1)*pi/180,data_speed_10.sensor(i,1)); 
   
   % 100Hz
   vec_vel_with_current(i,:) = [vec_vel(i,1), vec_vel(i,2)] - [vec_vel_current(1,1), vec_vel_current(1,2)];
   vec_vel_with_current_2(i,:) = [vec_vel_2(i,1), vec_vel_2(i,2)] - [vec_vel_current(1,1), vec_vel_current(1,2)];
   
   % 10Hz
   vec_vel_with_current_10(i,:) = [vec_vel_10(i,1), vec_vel_10(i,2)] - [vec_vel_current(1,1), vec_vel_current(1,2)];
   vec_vel_with_current_2_10(i,:) = [vec_vel_2_10(i,1), vec_vel_2_10(i,2)] - [vec_vel_current(1,1), vec_vel_current(1,2)];
   
   % 100Hz
   norm_speed(i,1) = norm([vec_vel_with_current(i,1), vec_vel_with_current(i,2)]);
   norm_speed_2(i,1) = norm([vec_vel_with_current_2(i,1), vec_vel_with_current_2(i,2)]);
   % 10Hz
   norm_speed_10(i,1) = norm([vec_vel_with_current_10(i,1), vec_vel_with_current_10(i,2)]);
   norm_speed_2_10(i,1) = norm([vec_vel_with_current_2_10(i,1), vec_vel_with_current_2_10(i,2)]);
   

end

   % Creation of timetables to compute trajectories
%Create of timetables for speed
varNames = {'ref','odba','sensor'};
% 100Hz
data_speed_c = timetable(data_speed.Time,data_speed.ref(:,1),norm_speed(:,1),norm_speed_2(:,1),'VariableNames',varNames);
% 10Hz
data_speed_10_c = timetable(data_speed_10.Time,data_speed_10.ref(:,1),norm_speed_10(:,1),norm_speed_2_10(:,1),'VariableNames',varNames);

   

end

