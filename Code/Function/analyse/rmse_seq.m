function [RMSE_S_SEQ,RMSE_H_SEQ] = rmse_seq(offset_heading_s,step_traj,data_speed,data_heading_s,data_heading)
offset_heading_s(:,:) = offset_heading_s(:,:)*0;

for i=1:length(step_traj)-1
[diff_speed_SEQ,diff_cumul_speed_SEQ] = err_speed_analysis_2(data_speed(step_traj(i):step_traj(i+1),:));
[diff_heading_SEQ,diff_cumul_heading_SEQ] = err_heading_analysis_seq_2(data_heading_s(step_traj(i):step_traj(i+1),:),data_heading(step_traj(i):step_traj(i+1),:)...
    ,(step_traj(i):step_traj(i+1)),offset_heading_s(i,:),1);

RMSE_S_SEQ(i,:) = sqrt(sum(diff_speed_SEQ(:,:).^2)/(step_traj(i+1)-step_traj(i)));
RMSE_H_SEQ(i,:) = sqrt(sum(diff_heading_SEQ(:,:).^2)/(step_traj(i+1)-step_traj(i)));

end
end

