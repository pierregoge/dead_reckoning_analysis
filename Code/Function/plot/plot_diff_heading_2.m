function plot_diff_heading_2(gps_ref_100,limit_traj,lat_traj_S,lon_traj_S,diff_eul_yaw,odba,speed_100,plot_speed)

figure(7)
subplot(2, 2, [1 3])

geoplot(gps_ref_100.lat(limit_traj(1):limit_traj(end),1),gps_ref_100.lon(limit_traj(1):limit_traj(2),1),'g');
%geoscatter(gps_ref_100.lat(limit_traj(1):limit_traj(end),1),gps_ref_100.lon(limit_traj(1):limit_traj(2),1),0.5,'g');
geobasemap("satellite");
hold on
geoplot(lat_traj_S(:,plot_speed(1)),lon_traj_S(:,plot_speed(1)),'b');
geoplot(lat_traj_S(:,plot_speed(2)),lon_traj_S(:,plot_speed(2)),'r');
geobasemap("satellite");
legend('2D Ground truth track','(1) Speed : ODBA, Orientation : Gyro','(2) Speed : ODBA, Orientation : No Gyro')%,'Position uncertainty')
set(legend,...
    'Position',[0.0259675477475928 0.803706711444409 0.440197276054858 0.150974021910073],...
    'FontSize',13);
title(legend,' a) Georeferenced trajectories');
grid on
%draw for A
hold off

subplot(2, 2, [2 4])
plot_offset = 650;
plot((limit_traj(1)+plot_offset:limit_traj(end))/10,abs(smoothdata(diff_eul_yaw(plot_offset:end-1,2),'movmean',10)),'r')
hold on
plot((limit_traj(1)+plot_offset:limit_traj(end))/10,abs(smoothdata(diff_eul_yaw(plot_offset:end-1,1),'movmean',10)),'b')

xlim([(limit_traj(1)+plot_offset)/10 limit_traj(end)/10])

legend('No Gyro','Gyro')
set(legend,...
    'Position',[0.744402199782144 0.833481164777785 0.16223066882791 0.0925572494059114],...
    'FontSize',13);
title('b) Heading estimation error','FontWeight','bold','FontSize',14);
xlabel('Time (s)')
ylabel('Error heading (m/s)')
hold off

end

