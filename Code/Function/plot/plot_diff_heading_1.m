function plot_diff_heading_1(gps_ref_100,limit_traj,lat_traj_S,lon_traj_S,diff_eul_yaw,odba,speed_100,plot_speed)

figure(6)
subplot(2, 2, [1 3])
geoscatter(gps_ref_100.lat(limit_traj(1):limit_traj(end),1),gps_ref_100.lon(limit_traj(1):limit_traj(2),1),0.5,'g');
geobasemap("satellite");
hold on
geoscatter(lat_traj_S(:,plot_speed(1)),lon_traj_S(:,plot_speed(1)),0.5,'b');
geoscatter(lat_traj_S(:,plot_speed(2)),lon_traj_S(:,plot_speed(2)),0.5,'r');
geobasemap("satellite");
legend('2D Ground truth track','(1) Speed : ODBA, Orientation : Madgwick','(2) Speed : ODBA, Orientation : SAAM')%,'Position uncertainty')
set(legend,...
    'Position',[0.0259675477475928 0.803706711444409 0.440197276054858 0.150974021910073],...
    'FontSize',12);
title(legend,' a) Georeferenced trajectories');
grid on
%draw for A
hold off

subplot(2, 2, 2)
plot_offset = 6500;
plot((limit_traj(1)+plot_offset:limit_traj(end))/10,abs(smoothdata(diff_eul_yaw(plot_offset:end-1,2),'movmean',10)),'r')
hold on
plot((limit_traj(1)+plot_offset:limit_traj(end))/10,abs(smoothdata(diff_eul_yaw(plot_offset:end-1,1),'movmean',10)),'b')

xlim([(limit_traj(1)+plot_offset)/10 limit_traj(end)/10])

legend('SAAM','Madgwick')
set(legend,...
    'Position',[0.744402199782144 0.833481164777785 0.16223066882791 0.0925572494059114],...
    'FontSize',13);
title('b) Heading estimation error','FontWeight','bold','FontSize',14);
xlabel('Time (s)')
ylabel('Error heading (m/s)')
hold off

subplot(2, 2, 4)
yyaxis left
plot((limit_traj(1)+plot_offset:limit_traj(end))/10,odba(limit_traj(1)+plot_offset:limit_traj(end)))
hold on
yyaxis right
plot((limit_traj(1)+plot_offset:limit_traj(end))/10,speed_100(limit_traj(1)+plot_offset:limit_traj(end)))
% hold on
% plot((limit_traj(1):limit_traj(end))/100,data_speed.ref(limit_traj(1):limit_traj(end)))
hold off
xlim([(limit_traj(1)+plot_offset)/10 limit_traj(end)/10])
ylim([0 2])
title('c) Variables to analyse heading','FontWeight','bold','FontSize',14);
xlabel('Time (s)')
yyaxis left
ylabel('ODBA (m/s^2)')
yyaxis right
ylabel('Speed (m/s)')
legend('ODBA','Reference speed')
set(legend,...
    'Position',[0.689311869388512 0.377442661984014 0.216568042681767 0.0731523358803889],...
    'FontSize',13);

end

