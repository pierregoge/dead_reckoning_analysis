function [diff_speed,diff_cumul_speed, diff_eul_yaw,diff_cumul_eul_yaw] = err_speed_yaw(data_heading,data_speed,offset_heading)

yaw(:,1) = -1*data_heading.madgwick(:,1)+offset_heading;
yaw(:,2) = data_heading.saam(:,1)+offset_heading;
yaw_ref = (data_heading.ref-180)/180*pi;

 for i=1:size(yaw_ref(:,1))
     
    if (yaw_ref (i,1) < -pi)
        yaw_ref(i,1) = yaw_ref(i,1)+(2*pi);
    elseif  (yaw_ref (i) > pi)
        yaw_ref(i,1) = yaw_ref(i,1)-(2*pi);
    end
 end
 yaw_ref = yaw_ref*180/pi;           

%Transform yaw before filtering
for i=2:length(yaw(:,1))
    for j=1:length(yaw(1,:))
    
    if  yaw(i-1,j) < -170 && yaw(i,j) > 170
        yaw(i,j) = yaw(i,j) - 360;
    end
    if  yaw(i-1,j) > 170 && yaw(i,j) < -170
        yaw(i,j) = yaw(i,j) + 360;
    end

    end
end

j = 1;
for i=2:length(yaw_ref(:,1))
    
    
    if  yaw_ref(i-1,j) < -170 && yaw_ref(i,j) > 170
        yaw_ref(i,j) = yaw_ref(i,j) - 360;
    end
    if  yaw_ref(i-1,j) > 170 && yaw_ref(i,j) < -170
        yaw_ref(i,j) = yaw_ref(i,j) + 360;
    end

end

% for i=2:length(yaw_ref(limit_analyse,1))
%     for j=1:length(yaw(1,1:end))
%         
%         diff_eul_yaw(i,j) = (yaw_ref(i,1)-yaw(i,j));
%         %add_eul_yaw(i,j) = (yaw_ref(i,attitude_ref)+yaw(i,j));
%         
%         if diff_eul_yaw(i,j) > 100
%             
%             diff_eul_yaw(i,j) = diff_eul_yaw(i,j)-360;
%         end
%         if diff_eul_yaw(i,j) < -100
% %             yaw_ref_buf = yaw_ref(i,attitude_ref)-360;
%             diff_eul_yaw(i,j) = diff_eul_yaw(i,j)+360;
%         end
%         
%   
%     end
% end
diff_cumul_eul_yaw = zeros(length(yaw_ref(:,1)),length(yaw(1,1:end)));
diff_eul_yaw = zeros(length(yaw_ref(:,1)),length(yaw(1,1:end)));

for i=2:length(yaw_ref(:,1))
    for j=1:length(yaw(1,1:end))
        
        buff_diff_eul_yaw =  (yaw_ref(i,1)-yaw(i,j));
        %add_eul_yaw(i,j) = (yaw_ref(i,attitude_ref)+yaw(i,j));
        
        if buff_diff_eul_yaw >= 100
            
            buff_diff_eul_yaw = buff_diff_eul_yaw-360;
            diff_cumul_eul_yaw(i,j)  = diff_cumul_eul_yaw(i-1,j) +abs( buff_diff_eul_yaw);
            diff_eul_yaw(i,j)  = buff_diff_eul_yaw;
            
        elseif buff_diff_eul_yaw < -100
            %             yaw_ref_buf = yaw_ref(i,attitude_ref)-360;
            buff_diff_eul_yaw = buff_diff_eul_yaw+360;
            diff_cumul_eul_yaw(i,j)  = diff_cumul_eul_yaw(i-1,j) + abs(buff_diff_eul_yaw);
            diff_eul_yaw(i,j)  =  buff_diff_eul_yaw;
            
        else
            diff_cumul_eul_yaw(i,j)  = diff_cumul_eul_yaw(i-1,j) + abs(buff_diff_eul_yaw);
            diff_eul_yaw(i,j)  = buff_diff_eul_yaw;
            
        end
        
        
    end
end


diff_eul_yaw = filloutliers(diff_eul_yaw,'nearest','mean');

diff_speed = zeros(length(data_speed.ref(:,1)),3);

diff_speed(:,1) = data_speed.ref(:,1)-data_speed.sensor(:,1);
diff_speed(:,2) = data_speed.ref(:,1)-data_speed.acc(:,1);
diff_speed(:,3) = data_speed.ref(:,1)-data_speed.acc_mag(:,1);

diff_cumul_speed = zeros(length(data_speed.ref(:,1)),3);

for i=2:length(data_speed.ref(:,1))
diff_cumul_speed(i,1) = diff_cumul_speed(i-1,1) + abs(data_speed.ref(i,1)-data_speed.sensor(i,1));
diff_cumul_speed(i,2) = diff_cumul_speed(i-1,2) + abs(data_speed.ref(i,1)-data_speed.acc(i,1));
diff_cumul_speed(i,3) = diff_cumul_speed(i-1,3) + abs(data_speed.ref(i,1)-data_speed.acc_mag(i,1));

end

end

