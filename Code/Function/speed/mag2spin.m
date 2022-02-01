function [spin_num] = mag2spin(datal_tag_2)

[a, b] = findpeaks(datal_tag_2.mag(:,3),'MinPeakProminence',0.04);

spin_tab = zeros(length(datal_tag_2.mag(:,3)),1);
for i=1:length(b(:,1))
    spin_tab(b(i,1),1) = 1;
    
end

spin_sum = zeros(length(datal_tag_2.mag(:,3))/100,1);
inc=1;
spin_sum(1,1) = sum(spin_tab(1:100,1));
for i=1:length(spin_tab(:,1))
    if spin_tab(i,1) == 1
    spin_sum(inc,1) = spin_sum(inc,1)+1;
    end
    
    if mod(i,100) == 0
        inc = inc+1;
    end 
    
end

spin_num = zeros(length(datal_tag_2.mag(:,3)),1);
inc = 1;
for i=1:100:length(spin_num(:,1))-100
        spin_num(i:i+100,1) = spin_sum(inc,1);
        inc = inc + 1;   
        
end

end

