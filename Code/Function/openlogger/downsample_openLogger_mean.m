function [data_10hz, data_tag_10hz] = downsample_openLogger_mean(srate,data,data_tag)

dt = seconds(1/srate);
data_10hz = retime(data,'regular','mean','TimeStep',dt);
data_tag_10hz = retime(data_tag,'regular','mean','TimeStep',dt);

data_tag_10hz = data_tag_10hz(1:length(data_tag.Time(:,1))/srate,:);

data_10hz = data_10hz(1:length(data.Time(:,1))/srate,:);

end