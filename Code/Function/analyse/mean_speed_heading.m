function [speed_mean_uncertainty,heanding_mean_uncertainty,speed_mean_uncertainty_10,heanding_mean_uncertainty_10] = mean_speed_heading(srate,data_orientation_10hz,data_orientation,speed_10hz,speed_100hz)

window_sec = 5;
window_speed = window_sec*srate(1);
speed_mean_uncertainty = zeros(length(speed_100hz(:,1)),1);
heanding_mean_uncertainty  = zeros(length(speed_100hz(:,1)),1);
for i = 1:window_speed:length(speed_100hz(:,1))
    speed_mean_uncertainty(i:i+window_speed-1,1)= mean(speed_100hz(i:i+window_speed-1,1));
    heanding_mean_uncertainty(i:i+window_speed-1,1)= mean(data_orientation.trigo(i:i+window_speed-1,3));
end

window_speed = window_sec*srate(2);
speed_mean_uncertainty_10 = zeros(length(speed_10hz(:,1)),1);
heanding_mean_uncertainty_10  = zeros(length(speed_10hz(:,1)),1);
for i = 1:window_speed:length(speed_10hz(:,1))
    speed_mean_uncertainty_10(i:i+window_speed-1,1)= mean(speed_10hz(i:i+window_speed-1,1));
    heanding_mean_uncertainty_10(i:i+window_speed-1,1)= mean(data_orientation_10hz.trigo(i:i+window_speed-1,3));
end

