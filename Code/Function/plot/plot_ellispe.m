function plot_ellispe(plot_nb,uncert_yt_100,uncert_xt_100,X_S,Y_S,gps_ref_100,lat_traj,lon_traj,lat_traj_S,lon_traj_S,limit_traj,limit_plot,heading_avg,offset_heading)

ellipse_X{4} = 0;
ellipse_Y{4} = 0;
ellipse_lat{4} = 0;
ellipse_lon{4} = 0;

ellipse_step = 1200;
length_dive = 300000;
for ii =1:length(uncert_yt_100(1,:))
    
[ellipse_X{ii}, ellipse_Y{ii}] = ellipse_XY(ii,(gps_ref_100.x(limit_traj(1),1)+Y_S(:,:))/1000, (gps_ref_100.y(limit_traj(1),1)+X_S(:,:))/1000, uncert_xt_100/1000/1.5,uncert_xt_100/1000/1.5, (heading_avg(limit_plot(1):limit_plot(2),1)+offset_heading)*pi/180, 1:limit_plot(2)-limit_plot(1),ellipse_step,length_dive);

for j=1:length(ellipse_X{ii}(:,1))
    for i=1:length(ellipse_X{ii}(1,:))
        ellipse_lat{ii}(j,i) = km2deg(ellipse_X{ii}(j,i));
        ellipse_lon{ii}(j,i) = km2deg(ellipse_Y{ii}(j,i));
    end
end

end


%geoscatter(gps_ref_100.lat(limit_plot(1):limit_plot(2),1),gps_ref_100.lon(limit_plot(1):limit_plot(2),1),0.5,'g');
figure(plot_nb);
geoplot(lat_traj(:,7),lon_traj(:,7),'g');
hold on
geoplot(lat_traj_S(1,plot_nb),lon_traj_S(1,plot_nb),'y*');
geoplot(ellipse_lat{plot_nb}(1,:),ellipse_lon{plot_nb}(1,:),'y-');
legend('2D Ground-truth track','Configuration 1 estimated track','Position uncertainty','AutoUpdate','off')
set(legend,'TextColor',[1 1 1],'Color',[0 0 0],'AutoUpdate','off');

geobasemap("satellite");
hold on
geoplot(lat_traj_S(1:300:limit_plot(2)-limit_plot(1),plot_nb),lon_traj_S(1:300:limit_plot(2)-limit_plot(1),plot_nb),'y-');
geoplot(lat_traj_S(1:300:limit_plot(2)-limit_plot(1),plot_nb),lon_traj_S(1:300:limit_plot(2)-limit_plot(1),plot_nb),'y*');

%%'DisplayName','Position uncertainty'
% 
% for i =1:ellipse_step:limit_plot(2)-limit_plot(1)
%  geoplot(lat_traj_S(i,plot_nb),lon_traj_S(i,plot_nb),'yo','MarkerSize',6);
%  geoplot(lat_traj(i,7),lon_traj(i,7),'g*','MarkerSize',6);
% end
% 
%  geoplot(ellipse_lat{plot_nb}(1,:),ellipse_lon{plot_nb}(1,:),'y-');
%     hold on
%     
%     geoplot(lat_traj_S(1,plot_nb),lon_traj_S(1,plot_nb),'yo','MarkerSize',6);
%     geoplot(lat_traj(1200,7),lon_traj(1200,7),'g*','MarkerSize',6);
%     
for j=1:length(ellipse_X{plot_nb}(:,1))
   
         
    geoplot(ellipse_lat{plot_nb}(j,:),ellipse_lon{plot_nb}(j,:),'y-');
    hold on
    
    geoplot(lat_traj_S(j*1200,plot_nb),lon_traj_S(j*1200,plot_nb),'yo','MarkerSize',6);
    geoplot(lat_traj(j*1200,7),lon_traj(j*1200,7),'g*','MarkerSize',6);

end

for i =1:ellipse_step:limit_plot(2)-limit_plot(1)
 geoplot(lat_traj_S(i,plot_nb),lon_traj_S(i,plot_nb),'yo','MarkerSize',6);
 geoplot(lat_traj(i,7),lon_traj(i,7),'g*','MarkerSize',6);
end
% for i =limit_plot(1):ellipse_step:limit_plot(2)
%     geoplot(gps_ref_100.lat(i,1),gps_ref_100.lon(i,1),'g*','MarkerSize',6);
%     
% end

end

