function  plot_debug_geo_traj(gps_ref_100,limit_traj,lat_traj,lon_traj)
    figure(15)
    geoscatter(gps_ref_100.lat(:),gps_ref_100.lon(:),0.5,'g');
    geobasemap("satellite");
    hold on
    
end

