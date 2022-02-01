function [heading,pitch,roll] = compute_trigo_orientation(data_imu)

data_imu.accel_g(:,3) = data_imu.accel_g(:,3);
data_imu.accel_g(:,1:2) = data_imu.accel_g(:,1:2);%*-1;

data_imu.mag_g(:,3) = data_imu.mag_g(:,3);

q_ecompass = ecompass(data_imu.accel_g, data_imu.mag_g);


euler_ecompass = eulerd(q_ecompass,'XYZ','frame');

heading = euler_ecompass(:,3)*-1;
pitch = euler_ecompass(:,1);
roll = euler_ecompass(:,2);
end
