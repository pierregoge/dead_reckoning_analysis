function [heading,pitch,roll] = compute_trigo_orientation_2(data_imu)

data_imu.accel_g(:,3) = data_imu.accel_g(:,3);
data_imu.accel_g(:,1) = data_imu.accel_g(:,2);
data_imu.accel_g(:,2) = data_imu.accel_g(:,1);

data_imu.mag_g(:,3) = data_imu.mag_g(:,3);
data_imu.mag_g(:,1) = data_imu.mag_g(:,1);
data_imu.mag_g(:,2) = data_imu.mag_g(:,2);

% 
% [euler_trig(:,1)] = pitch_a(data_imu.accel_g(:,1),data_imu.accel_g(:,2),data_imu.accel_g(:,3));
% [euler_trig(:,2)] = roll_a(data_imu.accel_g(:,2),data_imu.accel_g(:,3));
% [euler_trig(:,3)] = yaw_a(data_imu.mag_g(:,1),data_imu.mag_g(:,2),data_imu.mag_g(:,3),euler_trig(:,1),euler_trig(:,2));
% 

% 
% q_ecompass_1 = ecompass(data_imu.accel_g, data_imu.mag_g);
% euler_ecompass_1 = eulerd(q_ecompass_1,'XYZ','frame');
% 
% for j = 1:length(data_imu.accel_g(:,3))
%        for i = 1:3
%            data_imu.accel_g(j,i) = data_imu.accel_g(j,i)/sqrt(data_imu.accel_g(j,1)*data_imu.accel_g(j,1)+data_imu.accel_g(j,2)*data_imu.accel_g(j,2)+data_imu.accel_g(j,3)*data_imu.accel_g(j,3));
%            data_imu.mag_g(j,i) = data_imu.mag_g(j,i)/sqrt(data_imu.mag_g(j,1)*data_imu.mag_g(j,1)+data_imu.mag_g(j,2)*data_imu.mag_g(j,2)+data_imu.mag_g(j,3)*data_imu.mag_g(j,3));
%        end
% end
% q_ecompass = ecompass(data_imu.accel_g, data_imu.mag_g);
% 
% 
% Reference vector (magnetic field) - Nota: Gravity field not needed as it
% is already known [0;0;1]

% Measures definition (Normalization of magnetic vector meas., Accel vector
% meas. already normalized)
norm_acc_meas = sqrt((data_imu.accel_g(:,1)).^2 + (data_imu.accel_g(:,2)).^2 + (data_imu.accel_g(:,3)).^2);
ax =  data_imu.accel_g(:,1)./norm_acc_meas;
ay =  data_imu.accel_g(:,2)./norm_acc_meas;
az =  data_imu.accel_g(:,3)./norm_acc_meas;
norm_magn_meas = sqrt((data_imu.mag_g(:,1)).^2 + (data_imu.mag_g(:,3)).^2 + (data_imu.mag_g(:,2)).^2);
mx =  data_imu.mag_g(:,1)./(norm_magn_meas);
my =  data_imu.mag_g(:,2)./(norm_magn_meas);
mz =  data_imu.mag_g(:,3)./(norm_magn_meas);

md = ax.*mx + ay.*my + az.*mz;
mn = sqrt(1 - md.^2);

% % Quaternion calculation
q0 = -ay.*(mn + mx) + ax.*my;
q1 = (az - 1).*(mn + mx) + ax.*(md - mz);
q2 = (az - 1).*my + ay.*(md - mz);
q3 = az.*md -ax.*mn - mz;

% Quaternion normalization
% norm_q = sqrt(q0.^2 + q1.^2 + q2.^2 + q3.^2);
% q_SAAM = [q0; q1; q2; q3]./norm_q(:,1);
% 
q_SAAM(:,1) = q0 ./ norm([q0; q1; q2; q3]);
q_SAAM(:,2) = q1 ./ norm([q0; q1; q2; q3]);
q_SAAM(:,3) = q2 ./ norm([q0; q1; q2; q3]);
q_SAAM(:,4) = q3 ./ norm([q0; q1; q2; q3]);

% %q_SAAM = SAAM(data_imu.accel_g, data_imu.mag_g);
% 
% % euler_ecompass = eulerd(q_ecompass,'XYZ','frame');
% % 
q_SAAM = quaternion(q_SAAM(:,1),q_SAAM(:,2),q_SAAM(:,3),q_SAAM(:,4));
euler_trig = eulerd(q_SAAM,'XYZ','frame');
%euler_trig =euler_SAAM*180/pi;


% euler_trig =euler_trig*180/pi;

heading =euler_trig(:,3);
pitch = euler_trig(:,1);
roll = euler_trig(:,2);


% heading = euler_SAAM(:,3);
% pitch = euler_SAAM(:,1);
% roll = euler_SAAM(:,2);
end
