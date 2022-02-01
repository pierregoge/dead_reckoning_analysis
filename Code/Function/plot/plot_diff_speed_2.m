function  plot_diff_speed_2(gps_ref_100,limit_traj,lat_traj_S,lon_traj_S,diff_speed,odba,data_tag,data_speed,plot_speed)
figure(5)
subplot(2, 2, [1 3])
geoplot(gps_ref_100.lat(limit_traj(1):limit_traj(end),1),gps_ref_100.lon(limit_traj(1):limit_traj(2),1),'g');
geobasemap("satellite");
hold on
geoplot(lat_traj_S(:,plot_speed(1)),lon_traj_S(:,plot_speed(1)),'b');
geoplot(lat_traj_S(:,plot_speed(2)),lon_traj_S(:,plot_speed(2)),'r');
geobasemap("satellite");
legend('2D Ground truth track','(1) Speed : ODBA, Orientation : Madgwick','(2) Speed : Sensor, Orientation : Madgwick')%,'Position uncertainty')
set(legend,...
    'Position',[0.0259675477475928 0.803706711444409 0.440197276054858 0.150974021910073],...
    'FontSize',12);
title(legend,' a) Georeferenced trajectories');

%title('2D track estimation with uncertainty')
grid on
%draw for A
hold off

subplot(2, 2, 2)
plot((limit_traj(1):limit_traj(end))/10,abs(smoothdata(diff_speed(:,1),'movmean',10)),'b')
hold on
plot((limit_traj(1):limit_traj(end))/10,abs(smoothdata(diff_speed(:,2),'movmean',10)),'r')
xlim([limit_traj(1)/10 limit_traj(end)/10])
legend('ODBA Regression','ODBA + speed sensor Regression')
title('b) Speed estimation error')
xlabel('Time (s)')
ylabel('Error speed (m/s)')
hold off

subplot(2, 2, 4)
yyaxis left
plot((limit_traj(1):limit_traj(end))/10,data_speed.ref(limit_traj(1):limit_traj(end)),'color',[0 0.4470 0.7410])
%hold on
yyaxis right
plot((limit_traj(1):limit_traj(end))/10,data_tag.spin(limit_traj(1):limit_traj(end)),'color',[0.8500 0.3250 0.0980])

%hold on
%plot((limit_traj(1):limit_traj(end))/100,data_speed.ref(limit_traj(1):limit_traj(end)))
%hold off
xlim([limit_traj(1)/10 limit_traj(end)/10])
title('c) Main variables to calculate speed')
xlabel('Time (s)')
yyaxis left
ylabel('Speed (m/s^2)')
yyaxis right
ylabel('Spin (rps)')
legend('ODBA','Speed sensor rotation','Reference speed')

end

