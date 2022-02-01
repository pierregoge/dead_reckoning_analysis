function plot_traj_speed_heading_error(data_ref_10,lat_traj_1,lat_traj_2,lon_traj_1,lon_traj_2,diff_speed_1,diff_speed_2,diff_heading_1,diff_heading_2,lim1,lim2,data_speed,seq_var)

figure2 = figure('OuterPosition',[117 224 821 638]);

subplot(2, 2, [1 3])
geoscatter(data_ref_10.lat(lim1:lim2,1),data_ref_10.lon(lim1:lim2,1),0.5,'g');
geobasemap("satellite");
hold on
geoscatter(lat_traj_1(:,1),lon_traj_1(:,1),0.5,'b');
geoscatter(lat_traj_2(:,1),lon_traj_2(:,1),0.5,'r');
geobasemap("satellite");
for i=1:length(seq_var.rest_lim(:,1))
geoscatter(data_ref_10.lat(seq_var.rest_lim(i,1),1),data_ref_10.lon(seq_var.rest_lim(i,1),1),100,'g*');
end
legend('2D Ground truth track','(1) Speed : Sensor, Orientation : Madgwick','(7) Speed : ODBA, Orientation : SAAM','Resting phase')%,'Position uncertainty')
set(legend,...
    'Position',[0.0243270610045314 0.757634092242788 0.443478249540981 0.210091737377534],...
    'FontSize',12);
title(legend,' a) Georeferenced trajectories');


%title('2D track estimation with uncertainty')
grid on
%draw for A
hold off

diff_speed_1_d = downsample(diff_speed_1,10);
diff_speed_2_d = downsample(diff_speed_2,10);

subplot(2, 2, 2)
plot(abs(smoothdata(diff_speed_2_d(:,1),'movmean',10)),'r')
hold on
plot(abs(smoothdata(diff_speed_1_d(:,1),'movmean',10)),'b')
%set(gca,'XTickLabel',0:500:length(smoothdata(diff_speed_2(:,1)))/10)
% plot(abs(diff_speed_2(:,1)),'b')
% hold on
% plot(abs(diff_speed_1(:,1)),'r')

%plot((smoothdata(data_speed.ref(lim1:lim2,1),'movmean',50)),'black')
ylim([0 0.4])
xlim([1 (lim2-lim1)/10])
legend('ODBA Regression','Speed sensor Regression')
title('b) Speed estimation error','FontSize',12,'FontWeight','bold')
xlabel('Time (s)')

ylabel('Error speed (m/s)','FontSize',12,'FontWeight','bold')
hold off

subplot(2, 2, 4)
% plot(abs(smoothdata(diff_heading(:,1),'movmean',100)),'b')
% hold on
% plot(abs(smoothdata(diff_heading(:,2),'movmean',100)),'r')
diff_heading_1_d = downsample(diff_heading_1,10);
diff_heading_2_d = downsample(diff_heading_2,10);

plot(abs(diff_heading_1_d(:,1)),'r')
hold on
plot(abs(diff_heading_2_d(:,1)),'b')
%set(gca,'XTickLabel',0:500:length(smoothdata(diff_speed_2(:,1)))/10)

xlim([1 (lim2-lim1)/10])
%hold on
%plot((limit_traj(1):limit_traj(end))/100,data_speed.ref(limit_traj(1):limit_traj(end)))
%hold off
%xlim([limit_traj(1)/100 limit_traj(end)/100])
title('c) Heading estimation error','FontSize',12,'FontWeight','bold')
xlabel('Time (s)')
%yyaxis left
ylabel('Heading error (°)','FontSize',12,'FontWeight','bold')
legend('SAAM','Madgwick')

% Create arrow
annotation(figure2,'arrow',[0.324223602484472 0.304347826086957],...
    [0.260550458715596 0.319266055045872],'Color',[1 1 1],'LineWidth',1.5);

% Create arrow
annotation(figure2,'arrow',[0.318012422360248 0.31304347826087],...
    [0.658715596330275 0.697247706422018],'Color',[1 1 1],'LineWidth',1.5);

% Create textbox
annotation(figure2,'textbox',...
    [0.304105590062112 0.209174313074952 0.0981366434082482 0.0568807327966078],...
    'Color',[1 1 1],...
    'String',{'START'},...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure2,'textbox',...
    [0.29292546583851 0.616513762616236 0.0981366434082482 0.0568807327966078],...
    'Color',[1 1 1],...
    'String','END',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');


end

