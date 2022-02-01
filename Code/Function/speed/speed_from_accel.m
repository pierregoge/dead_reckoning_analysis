function [v_acc_ned_3axis_f,v_acc_turtle_3axis] = speed_from_accel(data_imu)

for j = 2:length(data_imu.accel_d(:,1))
       %   Rotation  ref matrix calculation
       %eul_ref(j,1:3) = [data_orientation.trigo(j,3), data_orientation.trigo(j,1), data_orientation.trigo(j,2)]';
       %r_turtleToEarth_ref = eul2rotm(deg2rad(eul_ref(j,1:3)));
       %Change accel frame from Earth to turtle
       v_acc_ned(j,:) =  (data_imu.accel_d(j,:)+data_imu.accel_d(j-1,:))*0.5;
       %data_imu.accel_d(j,1:3) = (r_turtleToEarth_ref' * [data_imu.accel_d(j,1); data_imu.accel_d(j,2);data_imu.accel_d(j,3)])';
       v_acc_turtle(j,:) =  (data_imu.accel_d(j,:)+data_imu.accel_d(j-1,:))*0.5;
              
end   

v_acc_ned_d = (abs(detrend(v_acc_ned)));
v_acc_ned_3axis = v_acc_ned_d(:,1) + v_acc_ned_d(:,1) +v_acc_ned_d(:,3);
v_acc_ned_3axis_f = filloutliers(v_acc_ned_3axis,'nearest','mean');

v_acc_turtle_d = abs(detrend(v_acc_turtle));
v_acc_turtle_3axis = v_acc_turtle_d(:,1) + v_acc_turtle_d(:,1) +v_acc_turtle_d(:,3);

end

