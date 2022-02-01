function plot_ellipse_traj(plot_nb,pos_X_NED,pos_Y_NED,uncert_xt_100,uncert_yt_100,data_heading,limit_plot,ellipse_step,length_dive)

figure(10)
%Plot 2D uncertainty
ellipse_plot(plot_nb,pos_X_NED, pos_Y_NED,uncert_xt_100,uncert_yt_100, (data_heading.ref(limit_plot,1))*pi/180, limit_plot,ellipse_step,length_dive);
% hold on
% plot_nb = 7;
% ellipse_plot(plot_nb,pos_X_NED, pos_Y_NED,uncert_xt_100,uncert_yt_100,  heanding_mean_uncertainty(limit_plot,1)*pi/180, limit_plot,ellipse_step,length_dive);

end

