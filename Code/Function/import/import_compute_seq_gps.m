function [gps_ref_100, gps_ref_10,seq_var] = import_compute_seq_gps(seq_var,data)

if seq_var.seq_id ==1
    
seq_var.gps_orientation = 180;

%Import GPS file
data_1 = import_reach_data('reachBody-solution_202111171344.LLH');
data_2 = import_reach_data('reachExplorer-solution_202111171344.LLH');
hours_offset_rtk= 4; % GPS offset time

end

if seq_var.seq_id ==2
    
seq_var.gps_orientation = 180;

%Import GPS file
data_1 = import_reach_data('reachBody-solution_202111180847.LLH');
data_2 = import_reach_data('reachExplorer-solution_202111180847.LLH');
hours_offset_rtk= 4; % GPS offset time

end

if seq_var.seq_id ==3
    
seq_var.gps_orientation = 180;

%Import GPS file
data_1 = import_reach_data('reachBody-solution_202111200955.LLH');
data_2 = import_reach_data('reachExplorer-solution_202111200955.LLH');
hours_offset_rtk= 4; % GPS offset time

end

% Compute GPS RTK
% Creation time table GPS with time range of analysis
[gps] = compute_gps(data_1,data_2,hours_offset_rtk,seq_var.limit_analyse_1,seq_var.limit_analyse_2);
clear data_1 data_2 hours_offset_rtk

[gps] = fill_missing_gps(gps);

% Compute angle grom GPS
gps_ref_1 = 1; % 1 equal dual RTK, no filter fill missing with linear function
[gps_ref_10,gps_ref_a] = compute_gps_heading(gps,gps_ref_1);
clear gps_ref_1

% Resample GPS
[gps_ref_100] = resample_gps_1(data,gps_ref_10,seq_var.srate(1));



end

