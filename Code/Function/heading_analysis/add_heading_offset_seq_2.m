function [data_heading_s] = add_heading_offset_seq_2(data_heading,step_traj,offset_heading,nb_plot)

yaw = zeros(step_traj(end),nb_plot+1);
yaw_ref = zeros(step_traj(end),1);

for j=1:length(step_traj)-1
    
    yaw(step_traj(j):step_traj(j+1),1:nb_plot) = (data_heading.madgwick(step_traj(j):step_traj(j+1),1:nb_plot)+offset_heading(j,1))/180*pi;
    yaw(step_traj(j):step_traj(j+1),nb_plot+1) = (data_heading.saam(step_traj(j):step_traj(j+1),1)+offset_heading(j,1))/180*pi;
    yaw_ref(step_traj(j):step_traj(j+1),1) = (data_heading.ref(step_traj(j):step_traj(j+1),1)/180*pi);
    
    for i=step_traj(j):step_traj(j+1)
        
        if (yaw (i,1) < -pi)
            yaw(i,1) = yaw(i,1)+(2*pi);
        elseif  (yaw (i) > pi)
            yaw(i,1) = yaw(i,1)-(2*pi);
        end
        
        if (yaw (i,2) < -pi)
            yaw(i,2) = yaw(i,2)+(2*pi);
        elseif  (yaw (i) > pi)
            yaw(i,2) = yaw(i,2)-(2*pi);
        end
        
        if (yaw_ref (i,1) < -pi)
            yaw_ref(i,1) = yaw_ref(i,1)+(2*pi);
        elseif  (yaw_ref (i) > pi)
            yaw_ref(i,1) = yaw_ref(i,1)-(2*pi);
        end
    end
    
end

yaw_ref = yaw_ref*180/pi;
yaw = yaw*180/pi;

 data_heading_s = data_heading(1:step_traj(end),:);
 data_heading_s.madgwick = yaw(:,1:nb_plot);   
 data_heading_s.saam = yaw(:,2);   
 data_heading_s.ref = yaw_ref(:,1);   


end

