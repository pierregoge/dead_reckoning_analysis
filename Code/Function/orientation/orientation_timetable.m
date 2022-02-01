function [data_heading, data_pitch] = orientation_timetable(data_tag,gps_ref_100,madgwick,saam)

%Creation of timetables for heading
varNames = {'ref','madgwick','saam','ref2'};
%100hz
data_heading = timetable(data_tag.Time,gps_ref_100.heading(:,1),madgwick(:,3),saam(:,3),gps_ref_100.heading2(:,1),'VariableNames',varNames);

%Creation of timetables for pitch
varNames = {'madgwick','saam'};
%100hz
data_pitch = timetable(data_tag.Time,madgwick(:,1),saam(:,1),'VariableNames',varNames);


end

