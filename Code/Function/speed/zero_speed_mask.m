function [speed_mask] = zero_speed_mask(odba,limit_speed_analyse)
% Resting detection and speed correction
odba_smooth = smoothdata(odba,'movmean','SmoothingFactor',0.25);
%speed_predict= zeros(length(odba(limit_speed_analyse,1)),7);
for  i=1:length(odba(limit_speed_analyse,1))

if odba_smooth(i,1) < 0.02
speed_mask(i,:) = 0;
else
speed_mask(i,:) = 1;
end

end
end

