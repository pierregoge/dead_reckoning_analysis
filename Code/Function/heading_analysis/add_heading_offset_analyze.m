function [data_heading_s] = add_heading_offset_analyze(data_heading,offset_heading,nb_plot)


    
    yaw(:,1:nb_plot) = (data_heading.madgwick(:,1:nb_plot)+offset_heading(:,1))/180*pi;
    yaw(:,nb_plot+1) = (data_heading.saam(:,1)+offset_heading(:,1))/180*pi;
    yaw_ref(:,1) = (data_heading.ref(:,1)/180*pi);
    
    for i=1:length(yaw(:,1))
        
        if (yaw (i,1) < -pi)
            yaw(i,1) = yaw(i,1)+(2*pi);
        elseif  (yaw (i,1) > pi)
            yaw(i,1) = yaw(i,1)-(2*pi);
        end
        
        if (yaw (i,2) < -pi)
            yaw(i,2) = yaw(i,2)+(2*pi);
        elseif  (yaw (i,2) > pi)
            yaw(i,2) = yaw(i,2)-(2*pi);
        end
        
        if (yaw_ref (i,1) < -pi)
            yaw_ref(i,1) = yaw_ref(i,1)+(2*pi);
        elseif  (yaw_ref (i) > pi)
            yaw_ref(i,1) = yaw_ref(i,1)-(2*pi);
        end
    end
    

yaw_ref = yaw_ref*180/pi;
yaw = yaw*180/pi;

 data_heading_s = data_heading(:,:);
 data_heading_s.madgwick = yaw(:,1:nb_plot);   
 data_heading_s.saam = yaw(:,nb_plot+1);   
 data_heading_s.ref = yaw_ref(:,1);   
 
end

