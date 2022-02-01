function [offset_heading_s] = compute_offset_heading_seq(step_traj,data_heading)
offset_heading_s = zeros(length(step_traj),1);
for i=1:length(step_traj)-1
   
[diff_heading_s,diff_cumul_heading_s] = err_heading_analysis_seq_2(data_heading(step_traj(i):step_traj(i+1),:),data_heading(step_traj(i):step_traj(i+1),:)...
    ,(step_traj(i):step_traj(i+1)),offset_heading_s(i,:),1);
%offset_heading_s(i,1) = mean(diff_heading_s(1:step_traj(i+1)-step_traj(i),1:2));
offset_heading_s(i,1) = (mean(diff_heading_s(1:step_traj(i+1)-step_traj(i),1))+mean(diff_heading_s(1:step_traj(i+1)-step_traj(i),1)))/2;

end
end

