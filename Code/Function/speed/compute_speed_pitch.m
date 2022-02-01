function data_vel_100hz = compute_speed_pitch(time_100hz,pitch_ref,depth)

for k=2:length(time_100hz)
vel_X_turtle(k,1) = abs((depth(k-1,1)-depth(k,1))/sin(pitch_ref(k,1)*pi/180))/100;
% if vel_X_turtle(k,1) >=1
%     vel_X_turtle(k,1) =1;
% end
% if vel_X_turtle(k,1) <=-1
%     vel_X_turtle(k,1) =-1;
% end
vel_Y_turtle(k,1) = 0;
vel_Z_turtle(k,1) = 0;
end

varNames = {'vel_X_turtle', 'vel_Y_turtle', 'vel_Z_turtle'};
data_vel_100hz = timetable(time_100hz',vel_X_turtle(1:end,1),vel_Y_turtle(1:end,1),vel_Z_turtle(1:end,1),'VariableNames', varNames);

end