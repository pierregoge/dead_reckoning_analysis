function [elec_cons] = compute_electrical_consumption(data,algo_attitude,speed_method,sampling_rate_imu)

inc = 1;

for i = 1:length(data(:,1))

   for j = 1:length(data(1,:))
       
       if sampling_rate_imu(i) == 100 && algo_attitude(j) == 2
       elec_cons(inc) = 5;
       end
       if sampling_rate_imu(i) == 100 && algo_attitude(j) == 5 
       elec_cons(inc) = 100;
       end
       if sampling_rate_imu(i) == 100 && algo_attitude(j) == 6
       elec_cons(inc) = 100;
       end
       
       if sampling_rate_imu(i) == 5 && algo_attitude(j) == 2
       elec_cons(inc) = 1;
       end
       if sampling_rate_imu(i) == 5 && algo_attitude(j) == 5 
       elec_cons(inc) = 5;
       end
       if sampling_rate_imu(i) == 5 && algo_attitude(j) == 6
       elec_cons(inc) = 5;
       end
      
       if sampling_rate_imu(i) == 1 && algo_attitude(j) == 2
       elec_cons(inc) = 0.5;
       end
       if sampling_rate_imu(i) == 1 && algo_attitude(j) == 5 
       elec_cons(inc) = 1;
       end
       if sampling_rate_imu(i) == 1 && algo_attitude(j) == 6
       elec_cons(inc) = 1;
       end
       
       inc=inc+1;
       
   end
   
end

