function plot_debug_traj(limit_traj,x,y,X,Y)

figure(16)
nb_plot = 1;
plot((+y(limit_traj)-y(limit_traj(1),1)),(+x(limit_traj)-x(limit_traj(1),1)));
axis equal
hold on
plot(-X(limit_traj,nb_plot),-Y(limit_traj,nb_plot));
plot(-X(limit_traj,nb_plot+1),-Y(limit_traj,nb_plot+1));
plot(-X(limit_traj,nb_plot+2),-Y(limit_traj,nb_plot+2));
plot(-X(limit_traj,nb_plot+3),-Y(limit_traj,nb_plot+3));
plot(-X(limit_traj,nb_plot+4),-Y(limit_traj,nb_plot+4));
plot(-X(limit_traj,nb_plot+5),-Y(limit_traj,nb_plot+5));
hold off

end

