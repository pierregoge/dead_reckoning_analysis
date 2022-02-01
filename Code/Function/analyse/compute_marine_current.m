function [mean_vel_current,angle,strength] = compute_marine_current(seq_var,X,Y)

inc = 1;
for i =1:length(seq_var.rest_lim(:,1))
l_inf = seq_var.rest_lim(i,1);
l_sup = seq_var.rest_lim(i,2);
angle = atan2((Y(l_inf,5) - Y(l_sup,5)),((X(l_inf,5) - X(l_sup,5))));
strength = norm((Y(l_sup,5) - Y(l_inf,5)),((X(l_sup,5) - X(l_inf,5))))/100;
[vec_vel_current(inc,1), vec_vel_current(inc,2)] = pol2cart(angle+pi,strength);
inc =inc+1;
end

mean_vel_current(1,1) = mean(vec_vel_current(:,1));
mean_vel_current(1,2) = mean(vec_vel_current(:,2));

angle = angle *180/pi;
end

