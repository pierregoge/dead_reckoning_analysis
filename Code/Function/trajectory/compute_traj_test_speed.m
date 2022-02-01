function [X3,Y3,Z3] = compute_traj_test_speed(data_orientation,data_heading,data_speed, decli,srate)


 delX = nan(size(data_heading.madgwick(:,1),1),1);
 delY= nan(size(data_heading.madgwick(:,1),1),1);
 delZ= nan(size(data_heading.madgwick(:,1),1),1);
 X3= nan(size(data_heading.madgwick(:,1),1),1);
 Y3= nan(size(data_heading.madgwick(:,1),1),1);
 Z3= nan(size(data_heading.madgwick(:,1),1),1);
 
Sp = data_speed./srate;
decli = decli.*pi/180;



Pitch = data_orientation.madgwick(:,1)/180*pi;
Head = (data_heading.madgwick(:,1))/180*pi;
Head = Head + decli;

 
 %% path reconstruction 
   


 
 for i=1:size(Head,1)
     
    if (Head (i,1) < -pi)
        Head(i,1) = Head(i,1)+(2*pi);
    elseif  (Head (i) > pi)
        Head(i,1) = Head(i,1)-(2*pi);
    end
 end
            

%  for i=1:size(Sp,1)
%     if (Sp(i,1) < 0.05)
%    Sp(i,1) = 0;
%     end
%  end    
 
 delX(1,1)=0;
 delX(2:size(delX,1),1)=Sp(2:size(delX,1),1).*cos(Pitch(1:size(delX,1)-1,1)).*sin(Head(1:size(delX,1)-1,1));
 delY(1,1)=0;
 delY(2:size(delY,1),1)=Sp(2:size(delX,1),1).*cos(Pitch(1:size(delX,1)-1,1)).*cos(Head(1:size(delX,1)-1,1));
 delZ(1,1)=0;
 delZ(2:size(delZ,1),1)=Sp(2:size(delX,1),1).*tan(Pitch(1:size(delX,1)-1,1));
 
 
   
 X3(1,1)=0;
 Y3(1,1)=0; 
 Z3(1,1)=0; 
 
 for i=2:size(X3,1)
    X3(i,1)=X3(i-1,1)+delX(i,1);
    Y3(i,1)=Y3(i-1,1)+delY(i,1);
    Z3(i,1)=Z3(i-1,1)+delZ(i,1);
 end
 
 
end


