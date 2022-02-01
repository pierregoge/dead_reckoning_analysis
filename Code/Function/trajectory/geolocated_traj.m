function [lat_traj,lon_traj,z_traj,x,y,z] = geolocated_traj(gps_ref,X,Y,Z,limit_traj,wgs84)


x = gps_ref.x(limit_traj,1);
y = gps_ref.y(limit_traj,1);
z = gps_ref.z(limit_traj,1);

%Tranform traj to GPS pos with GPS speed
[lat_traj(:,1:length(X(1,:))),lon_traj(:,1:length(X(1,:))),z_traj(:,1:length(X(1,:)))] = ecef2geodetic(wgs84,x(1,1)-Y(:,:),y(1,1)-X(:,:),z(:,1));


end

