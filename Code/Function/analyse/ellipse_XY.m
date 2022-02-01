function  [ellipse_X, ellipse_Y] = ellipse_XY(plot_nb,pos_X_NED,pos_Y_NED,uncertainty_y, uncertainty_s, yaw_r, size_analyse,ellipse_step,length_dive)

inc = 1;
inc_2 = 1;
% plot(pos_X_NED(size_analyse,plot_nb),pos_Y_NED(size_analyse,plot_nb),'b')
% 
% 
% hold on
% plot(pos_X_NED(size_analyse,1),pos_Y_NED(size_analyse,1),'g')

% ellipse_X = zeros(size_analyse(end)/ellipse_step,64);
% ellipse_Y = zeros(size_analyse(end)/ellipse_step,64);
 
%Simulate 30min dive
for i = size_analyse(1):1:size_analyse(end)
    
 if mod(i,ellipse_step) == 0
 phi = yaw_r;
 %phi = yaw_ref(i,1)*pi/180;;
 %[ellipse_X(i,:), ellipse_Y(i,:)] = ellipsedraw(uncertainty_s(inc,plot_nb-1),uncertainty_y(inc,plot_nb-1),pos_X_NED(i,plot_nb),pos_Y_NED(i,plot_nb),phi,'r');
 [ellipse_X(inc_2,:), ellipse_Y(inc_2,:)] = compute_ellipse(uncertainty_s(inc,plot_nb),uncertainty_y(inc,plot_nb),pos_X_NED(i,plot_nb),pos_Y_NED(i,plot_nb),phi);
 inc_2 = inc_2 + 1;
 end
 if inc == length_dive
     inc = 0;
 end
    inc = inc+1;
end

end

