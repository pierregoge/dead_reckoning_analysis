function plot_cep_consumption_2(length_dive,CEP_s,e_cons)


% 1 = S : ODBA / O : Madgwick | 2 = S : Sensor / O : Madgwick
% 3 = S : ODBA / O : SAAM | 4 = S : Sensor / O : SAAM


e_cons_l = [e_cons(1,:) e_cons(2,:)];
CEP_s_l = [CEP_s(1,:) CEP_s(2,:)];

figure(7)

 plot(e_cons_l(1,1),CEP_s_l(1,1),'ro','MarkerSize',20)
 hold on
 plot(e_cons_l(1,2),CEP_s_l(1,2),'rx','MarkerSize',20)
 plot(e_cons_l(1,3),CEP_s_l(1,3),'r+','MarkerSize',20)
 plot(e_cons_l(1,4),CEP_s_l(1,4),'r*','MarkerSize',20)
 
 plot(e_cons_l(1,5),CEP_s_l(1,5),'bo','MarkerSize',20)
 plot(e_cons_l(1,6),CEP_s_l(1,6),'bx','MarkerSize',20)
 plot(e_cons_l(1,7),CEP_s_l(1,7),'b+','MarkerSize',20)
 plot(e_cons_l(1,8),CEP_s_l(1,8),'b*','MarkerSize',20)



legend('Speed : ODBA / Orientation : Madgwick','S = Sensor / 0 : Madgwiwk', 'S : ODBA / O : SAAM' ,...
    'S : Sensor / O : SAAM','Speed : ODBA / Orientation : Madgwick','S = Sensor / 0 : Madgwiwk', 'S : ODBA / O : SAAM' ,...
    'S : Sensor / O : SAAM')


% Create legend

set(legend,...
    'Position',[0.332982469629823 0.790380186895929 0.559999986510528 0.12013422498767],...
    'NumColumns',2);
title(legend,...
    'IMU : 100Hz                                                              IMU : 10Hz');

xlabel('Electrical consumption of the tag (mA)')
 xlim([0 4])
ylabel('CEP (m)')
grid on
hold off


end

