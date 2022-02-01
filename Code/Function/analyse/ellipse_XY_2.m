function  [ellipse_X, ellipse_Y] = ellipse_XY_2(plot_nb,pos_X_NED,pos_Y_NED,uncertainty_y, uncertainty_s, yaw_r,ellipse_step,length_dive)

inc = 1;
inc_2 = 1;


for i = 1:length(pos_X_NED(:,1))
    
 if mod(i,ellipse_step) == 0
 phi = yaw_r(i,1);
 [ellipse_X(inc_2,:), ellipse_Y(inc_2,:)] = compute_ellipse(uncertainty_s(inc,plot_nb),uncertainty_y(inc,plot_nb),pos_X_NED(i,plot_nb),pos_Y_NED(i,plot_nb),phi);
 inc_2 = inc_2 + 1;
 end
 if inc == length_dive
     inc = 0;
 end
    inc = inc+1;
end

end

