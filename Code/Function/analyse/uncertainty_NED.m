function [uncert_x, uncert_y, CEP] = uncertainty_NED(u_x,u_y,limit_analyse,srate)


uncert_x = zeros(length(limit_analyse),6);
uncert_y = zeros(length(limit_analyse),6);

inc = 1;


for jj=1:length(u_y)
    
    for i=2:length(limit_analyse)
        
        uncert_y(i,inc) = uncert_y(i-1,inc) + u_x(1,jj);
        uncert_x(i,inc) = uncert_x(i-1,inc) + u_y(1,jj);
        
        CEP(i,inc) = 0.69*sqrt(uncert_y(i,inc).^2+uncert_x(i,inc).^2);
        
    end
    inc = inc+1;
end





end