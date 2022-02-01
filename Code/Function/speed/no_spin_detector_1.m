function [no_spin,spin,nb_spin] = no_spin_detector_1(spin_num,nb_min_spin)

% Function to detect use of speed sensor
inc = 1;
nb_spin = smoothdata(spin_num,'movmean','SmoothingFactor',0.1);
no_spin = zeros(length(spin_num(:,1)),1);
spin = zeros(length(spin_num(:,1)),1);
for i =1:length(spin_num(:,1))
if spin_num(i,1) == 0
no_spin(i,1) = 1;
end
if  spin_num(i,1) < nb_min_spin
    no_spin(i,1) = 1;
    inc = inc+1;
else
    spin(i,1) = 1;
end
end
end

