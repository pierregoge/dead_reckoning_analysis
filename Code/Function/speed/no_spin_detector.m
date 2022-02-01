function [no_spin,spin,nb_spin] = no_spin_detector(data_tag,nb_min_spin)

% Function to detect use of speed sensor
inc = 1;
nb_spin = smoothdata(data_tag.spin,'movmean','SmoothingFactor',0.1);
no_spin = zeros(length(data_tag.spin(:,1)),1);
spin = zeros(length(data_tag.spin(:,1)),1);
for i =1:length(data_tag.spin(:,1))
if data_tag.spin(i,1) == 0
no_spin(i,1) = 1;
end
if  data_tag.spin(i,1) < nb_min_spin
    no_spin(i,1) = 1;
    inc = inc+1;
else
    spin(i,1) = 1;
end
end
end

