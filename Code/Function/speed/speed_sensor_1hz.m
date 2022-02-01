function [speed_sensor_1hz,speed_sensor_10hz,speed_sensor_100hz] = speed_sensor_1hz(speed_1hz,speed_10hz,speed_100hz,srate)

% Speed sensor 1hz
speed_sensor_1hz = speed_1hz;

% Speed sensor 10hz
speed_sensor_10hz  = zeros(length(speed_10hz(:,1)),1);
window_speed = srate(2);
inc = 1;
for i = 1:window_speed:length(speed_10hz(:,1))-window_speed
    speed_sensor_10hz(i:i+window_speed-1,1)= speed_1hz(inc);
    inc = inc +1;
end

% Speed sensor 100hz
speed_sensor_100hz  = zeros(length(speed_100hz(:,1)),1);
window_speed = srate(1);
inc = 1;
for i = 1:window_speed:length(speed_100hz(:,1))
    speed_sensor_100hz(i:i+window_speed-1,1)= speed_1hz(inc);
    inc = inc +1;
end

end

