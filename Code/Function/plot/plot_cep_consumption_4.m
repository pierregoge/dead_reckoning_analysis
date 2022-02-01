function plot_cep_consumption_4(CEP_s,e_cons)


% 1 = S : ODBA / O : Madgwick | 2 = S : Sensor / O : Madgwick
% 3 = S : ODBA / O : SAAM | 4 = S : Sensor / O : SAAM


e_cons_l = [e_cons(1,:) e_cons(2,:)];
CEP_s_l = [CEP_s(1,:) CEP_s(2,:)];

figure(8)

plot(e_cons_l(1,1),CEP_s_l(1,1),'ko','MarkerSize',20);
hold on
plot(e_cons_l(1,2),CEP_s_l(1,2),'kx','MarkerSize',20);
plot(e_cons_l(1,3),CEP_s_l(1,3),'k+','MarkerSize',20);
plot(e_cons_l(1,4),CEP_s_l(1,4),'k*','MarkerSize',20);
%  


set(legend,...
    'Position',[0.332982469629823 0.790380186895929 0.559999986510528 0.12013422498767],...
    'NumColumns',1);

legend('Speed : ODBA / Orientation : Gyro','S = Sensor / O : Gyro', 'S : ODBA / O : No Gyro' ,...
    'S : Sensor / O : No Gyro');
hold off

figure(7)

%ax = axes();

h(1) = plot(e_cons_l(1,1),CEP_s_l(1,1),'ro','MarkerSize',20);
hold on
h(2) =  plot(e_cons_l(1,2),CEP_s_l(1,2),'rx','MarkerSize',20);
h(3) =  plot(e_cons_l(1,3),CEP_s_l(1,3),'r+','MarkerSize',20);
h(4) = plot(e_cons_l(1,4),CEP_s_l(1,4),'r*','MarkerSize',20);

 h(5) = plot(e_cons_l(1,5),CEP_s_l(1,5),'bo','MarkerSize',20);
 h(6) = plot(e_cons_l(1,6),CEP_s_l(1,6),'bx','MarkerSize',20);
 h(7) = plot(e_cons_l(1,7),CEP_s_l(1,7),'b+','MarkerSize',20);
 h(8) = plot(e_cons_l(1,8),CEP_s_l(1,8),'b*','MarkerSize',20);


set(legend,...
    'Position',[0.332982469629823 0.790380186895929 0.559999986510528 0.12013422498767],...
    'NumColumns',1);


legend('Speed : ODBA / Orientation : Gyro','S = Sensor / O : Gyro', 'S : ODBA / O : No Gyro' ,...
    'S : Sensor / O : No Gyro');



% Create legend
xlabel('Electrical consumption of the tag (mA)')
% xlim([0 4])
% ylim([195 230])
ylabel('CEP (m)')

grid on




a=axes('position',get(gca,'position'),'visible','off');
legend(a,[h(1) h(5)],'IMU : 100Hz','IMU : 10Hz');





end

