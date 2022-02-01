function [speed_predict_2,speed_predict_2_10hz,speed_predict_2_1hz] = speed_regression_acc_mag(speed_acc_mag,speed_acc_mag_1,speed_acc_mag_10,data_tag,data_tag_10hz,data_tag_1hz)

accel_mag = [data_tag.accel data_tag.mag];
accel_mag_10hz = [data_tag_10hz.accel data_tag_10hz.mag];
accel_mag_1hz = [data_tag_1hz.accel data_tag_1hz.mag];

speed_predict_2 = speed_acc_mag.predictFcn(accel_mag);
speed_predict_2_10hz = speed_acc_mag_10.predictFcn(accel_mag_10hz);
speed_predict_2_1hz = speed_acc_mag_1.predictFcn(accel_mag_1hz);

end
