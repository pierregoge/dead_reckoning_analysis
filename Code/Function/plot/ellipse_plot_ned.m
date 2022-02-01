function ellipse_plot_ned(plot_nb,pos_X_NED, pos_Y_NED,uncert_x...
, uncert_y, size_analyse,ellipse_step,length_dive)


inc = 1;

plot(pos_X_NED(size_analyse,plot_nb),pos_Y_NED(size_analyse,plot_nb),'b')

hold on
plot(pos_X_NED(size_analyse,1),pos_Y_NED(size_analyse,1),'g')

%Simulate 30min dive
for i = size_analyse(1):1:size_analyse(end)
    
 if mod(i,ellipse_step) == 0
 phi = 90*pi/180;
 %phi = yaw_ref(i,1)*pi/180;;
 ellipsedraw(uncert_x(inc,plot_nb-1),uncert_y(inc,plot_nb-1),pos_X_NED(i,plot_nb),pos_Y_NED(i,plot_nb),phi,'r');
 hold on
 end
 if inc == length_dive
     inc = 0;
 end
    inc = inc+1;
end

hold on
plot(pos_X_NED(size_analyse,1),pos_Y_NED(size_analyse,1),'g')
legend('2D track', 'Ground truth track','Position uncertainty')
xlabel('East (m)')
ylabel('North (m)')
title('2D track estimation with uncertainty')
grid on
axis equal

end
