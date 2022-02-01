function plot_cep_consumption(length_dive,CEP_s,e_cons)


e_cons_l = [e_cons(1,:) e_cons(2,:)];
% 
% CEP_s(1,:) = [CEP_s(1,4:6) CEP_s(1,1:3)];
% CEP_s(2,:) = [CEP_s(2,4:6) CEP_s(2,1:3)];
CEP_s_l = [CEP_s(1,:) CEP_s(2,:)]*length_dive;

figure(6)

 plot(e_cons_l(1,1),CEP_s_l(1,1),'ro','MarkerSize',20)
 hold on
 plot(e_cons_l(1,2),CEP_s_l(1,2),'rx','MarkerSize',20)
 plot(e_cons_l(1,3),CEP_s_l(1,3),'r+','MarkerSize',20)
 plot(e_cons_l(1,4),CEP_s_l(1,4),'r*','MarkerSize',20)
 
 plot(e_cons_l(1,5),CEP_s_l(1,5),'bx','MarkerSize',20)
 plot(e_cons_l(1,6),CEP_s_l(1,6),'b+','MarkerSize',20)
 plot(e_cons_l(1,7),CEP_s_l(1,7),'bo','MarkerSize',20)
 plot(e_cons_l(1,8),CEP_s_l(1,8),'b*','MarkerSize',20)
 

legend('100hz Speed : sensor ', '100hz, Speed : Regression acc' ,'100hz Speed : Regression acc + mag',...
    '10hz Speed : sensor', '10hz, Speed : Regression acc' ,'10hz Speed : Regression acc + mag')
title('Tradeoff CEP (20min dive) vs Power consumption')
xlabel('Electrical consumption of the tag (mA)')
ylabel('CEP (20min dive)')
grid on
hold off


end

