function [gps_ref_hz] = fill_missing_gps(gps_ref)

gps_ref_hz = fillmissing(gps_ref,'linear');

end