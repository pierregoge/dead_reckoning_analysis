function [gps_ref_hz] = resample_gps_1(data,gps_ref,srate)

% Resample GPS from analysis
dt = seconds(1/srate);
%gps_z = retime(gps_1,'regular','linear','TimeStep',dt);
gps_ref = retime(gps_ref,'regular','pchip','TimeStep',dt);
% gps_ref_1hz = synchronize(data_tag_1hz,gps_ref_1hz);
gps_ref_hz = synchronize(data,gps_ref);
gps_ref_hz = fillmissing(gps_ref_hz,'pchip');



end

