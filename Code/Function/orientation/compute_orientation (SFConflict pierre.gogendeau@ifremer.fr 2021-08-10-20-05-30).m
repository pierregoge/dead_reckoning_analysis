function [data_orientation] = compute_orientation(srate,data_imu,coeff_filter)

%% 100 hz
AHRS = MadgwickAHRS('SamplePeriod', 1/srate(1), 'Beta', 0.01);
%AHRS = MahonyAHRS('SamplePeriod', 1/srate(1), 'Kp', 0.5,'Ki',0.3);

quaternion = zeros(length(data_imu.gyro(:,1)), 4);

for t = 1:length(data_imu.gyro(:,1))
    AHRS.Update(data_imu.gyro(t,:) * (pi/180), data_imu.accel(t,:), data_imu.mag(t,:));	% gyroscope units must be radians
    quaternion(t, :) = AHRS.Quaternion;
end
euler = quatern2euler(quaternConj(quaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.

q_ecompass = ecompass(data_imu.accel_g, data_imu.mag_g);
euler_ecompass = eulerd(q_ecompass,'XYZ','frame');

varNames = {'gyro','trigo'};
data_orientation = timetable(data_imu.Time,euler,euler_ecompass*-1,'VariableNames',varNames);


end

