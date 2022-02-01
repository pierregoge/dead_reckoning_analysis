function [lat_traj_S,lon_traj_S,X_S,Y_S,data_heading_s] = compute_traj_seq(step_traj,data_pitch,data_heading,data_speed,offset_heading_s,srate,limit_traj,gps_ref_100)

X_S_b = zeros(step_traj(end)-step_traj(1),6);
Y_S_b = zeros(step_traj(end)-step_traj(1),6);

for i=1:length(step_traj)-1
   

[X_S_buff(step_traj(i):step_traj(i+1),1:2),Y_S_buff(step_traj(i):step_traj(i+1),1:2),Z_S_buff(step_traj(i):step_traj(i+1),1:2)]...
    = compute_traj_2(data_pitch(step_traj(i):step_traj(i+1),:),data_heading(step_traj(i):step_traj(i+1),:),data_speed.odba(step_traj(i):step_traj(i+1),1),offset_heading_s(i,1),srate);

[X_S_buff(step_traj(i):step_traj(i+1),3:4),Y_S_buff(step_traj(i):step_traj(i+1),3:4),Z_S_buff(step_traj(i):step_traj(i+1),3:4)]...
    = compute_traj_2(data_pitch(step_traj(i):step_traj(i+1),:),data_heading(step_traj(i):step_traj(i+1),:),data_speed.sensor(step_traj(i):step_traj(i+1),1),offset_heading_s(i,1),srate);

[X_S_buff(step_traj(i):step_traj(i+1),5:6),Y_S_buff(step_traj(i):step_traj(i+1),5:6),Z_S_buff(step_traj(i):step_traj(i+1),5:6)]...
    = compute_traj_2(data_pitch(step_traj(i):step_traj(i+1),:),data_heading(step_traj(i):step_traj(i+1),:),data_speed.ref(step_traj(i):step_traj(i+1),1),offset_heading_s(i,1),srate);

X_S_b(step_traj(i):step_traj(i+1),1:6) = X_S_buff(step_traj(i):step_traj(i+1),1:6) + X_S_b(step_traj(i),1:6);
Y_S_b(step_traj(i):step_traj(i+1),1:6) = Y_S_buff(step_traj(i):step_traj(i+1),1:6) + Y_S_b(step_traj(i),1:6);

end

X_S(1:limit_traj(2)-limit_traj(1)+1,1:6) = X_S_b(limit_traj(1):limit_traj(2),1:6);
Y_S(1:limit_traj(2)-limit_traj(1)+1,1:6) = Y_S_b(limit_traj(1):limit_traj(2),1:6);

[data_heading_s] = add_heading_offset_seq(data_heading,step_traj,offset_heading_s,1);

% Geolocate traj with the first GPS position of the analysis
lat_traj_S = km2deg((gps_ref_100.x(limit_traj(1),1)+Y_S(:,:))/1000);
lon_traj_S = km2deg((gps_ref_100.y(limit_traj(1),1)+X_S(:,:))/1000);

end

