function plot_traj_speed_error(data_ref_10,lat_traj_1,lat_traj_2,lon_traj_1,lon_traj_2,diff_speed_1,diff_speed_2,diff_heading_1,diff_heading_2,lim1,lim2,data_speed,seq_var)


figure1 = figure('OuterPosition',[117 224 821 638]);
subplot(2, 2, [1 3])
geoscatter(data_ref_10.lat(lim1:lim2,1),data_ref_10.lon(lim1:lim2,1),0.5,'g');
geobasemap("satellite");
hold on
geoscatter(lat_traj_1(:,1),lon_traj_1(:,1),0.5,'b');
geoscatter(lat_traj_2(:,1),lon_traj_2(:,1),0.5,'r');
geobasemap("satellite");
for i=1:length(seq_var.rest_lim(:,1))
geoscatter(data_ref_10.lat(seq_var.rest_lim(i,1):50:seq_var.rest_lim(i,2),1),data_ref_10.lon(seq_var.rest_lim(i,1):50:seq_var.rest_lim(i,2),1),100,'g*');
end
legend('2D Ground truth track','(1) Speed : Sensor, Orientation : Madgwick','(1) Speed : Sensor current correction','Resting phase')%,'Position uncertainty')
set(legend,...
    'Position',[0.0259675477475928 0.803706711444409 0.440197276054858 0.150974021910073],...
    'FontSize',12);
title(legend,' a) Georeferenced trajectories');

%title('2D track estimation with uncertainty')
grid on
%draw for A
hold off

diff_speed_1_d = downsample(diff_speed_1,10);
diff_speed_2_d = downsample(diff_speed_2,10);

subplot(2, 2, [2 4])
plot(abs(smoothdata(diff_speed_1_d(:,1),'movmean',10)),'b')
hold on
plot(abs(smoothdata(diff_speed_2_d(:,1),'movmean',10)),'r')
%set(gca,'XTickLabel',0:500:length(smoothdata(diff_speed_2(:,1)))/10)

% 
% plot(abs(diff_speed_1(:,1)),'b')
% hold on
% plot(abs(diff_speed_2(:,1)),'r')


%plot((smoothdata(data_speed.ref(lim1:lim2,1),'movmean',50)),'black')
ylim([0 0.35])
xlim([1 (lim2-lim1)/10])
legend('Speed Regression','Speed regression current correction','FontSize',12)
title('b) Speed estimation error','FontSize',12)
xlabel('Time (s)')
ylabel('Error speed (m/s)','FontSize',12,'FontWeight','bold')
hold off


% Create arrow
annotation(figure1,'arrow',[0.324223602484472 0.304347826086957],...
    [0.260550458715596 0.319266055045872],'Color',[1 1 1],'LineWidth',1.5);

% Create arrow
annotation(figure1,'arrow',[0.318012422360248 0.31304347826087],...
    [0.658715596330275 0.697247706422018],'Color',[1 1 1],'LineWidth',1.5);

% Create textbox
annotation(figure1,'textbox',...
    [0.304105590062112 0.209174313074952 0.0981366434082482 0.0568807327966078],...
    'Color',[1 1 1],...
    'String',{'START'},...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');

% Create textbox
annotation(figure1,'textbox',...
    [0.29292546583851 0.616513762616236 0.0981366434082482 0.0568807327966078],...
    'Color',[1 1 1],...
    'String','END',...
    'FontWeight','bold',...
    'FontSize',12,...
    'FitBoxToText','off',...
    'EdgeColor','none');



end

