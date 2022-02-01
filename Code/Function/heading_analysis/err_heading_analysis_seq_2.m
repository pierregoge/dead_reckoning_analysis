function [diff_eul_yaw,diff_cumul_eul_yaw] = err_heading_analysis_seq_2(data_heading,data_heading_ref,limit_analyse,offset_heading,nb_plot)

yaw(:,1:nb_plot) = data_heading.madgwick(:,1:nb_plot)+offset_heading(:,1);
%yaw(:,nb_plot+1:2*nb_plot) = data_heading.mahony(:,:)+offset_heading(1,nb_plot+1:2*nb_plot);
yaw(:,nb_plot+1) = data_heading.saam(:,1)+offset_heading(:,1);
yaw_ref = (data_heading_ref.ref)/180*pi;

 for i=1:size(yaw_ref(:,1))
     
    if (yaw_ref (i,1) < -pi)
        yaw_ref(i,1) = yaw_ref(i,1)+(2*pi);
    elseif  (yaw_ref (i) > pi)
        yaw_ref(i,1) = yaw_ref(i,1)-(2*pi);
    end
 end
 yaw_ref = yaw_ref*180/pi;   


diff_cumul_eul_yaw = zeros(length(yaw(:,1)),length(yaw(1,1:end)));
diff_eul_yaw = zeros(length(yaw(:,1)),length(yaw(1,1:end)));


%diff_eul_yaw = (yaw_ref-yaw);


for i=2:limit_analyse(end)-limit_analyse(1)
    for j=1:length(yaw(1,1:end))
        
        buff_diff_eul_yaw =  (yaw_ref(i,1)-yaw(i,j));
        %add_eul_yaw(i,j) = (yaw_ref(i,attitude_ref)+yaw(i,j));
        
        if buff_diff_eul_yaw >= 180
            
            buff_diff_eul_yaw = buff_diff_eul_yaw-360;
            diff_cumul_eul_yaw(i,j)  = diff_cumul_eul_yaw(i-1,j) +abs( buff_diff_eul_yaw);
            diff_eul_yaw(i,j)  = buff_diff_eul_yaw;
            
        elseif buff_diff_eul_yaw < -180
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


end

