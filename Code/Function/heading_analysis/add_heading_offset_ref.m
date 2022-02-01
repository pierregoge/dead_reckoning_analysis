function [data_heading_s] = add_heading_offset_ref(data_heading,offset_heading)


  
    yaw(:,1) = ((data_heading.ref(:,1)+offset_heading)/180*pi);
    
    for i=1:length(yaw(:,1))
        
        if (yaw (i,1) < -pi)
            yaw(i,1) = yaw(i,1)+(2*pi);
        elseif  (yaw (i,1) > pi)
            yaw(i,1) = yaw(i,1)-(2*pi);
        end
        
        
    end
    


yaw = yaw*180/pi;

 data_heading_s = data_heading(:,:);
  
 data_heading_s.ref = yaw(:,1);   
 
end

