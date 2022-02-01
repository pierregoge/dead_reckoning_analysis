function [speed_predict_1,speed_predict_1_10hz] = speed_regression_acc(speed_acc,speed_acc_10,data_tag,data_tag_10hz)

accel_mag = [data_tag.accel data_tag.mag];
accel_mag_10hz = [data_tag_10hz.accel data_tag_10hz.mag];
%accel_mag_1hz = [data_tag_1hz.accel data_tag_1hz.mag];

speed_predict_1 = speed_acc.predictFcn(accel_mag);
speed_predict_1_10hz = speed_acc_10.predictFcn(accel_mag_10hz(:,1:3));
%speed_predict_1_1hz = speed_acc_1.predictFcn(accel_mag_1hz(:,1:3));

end

