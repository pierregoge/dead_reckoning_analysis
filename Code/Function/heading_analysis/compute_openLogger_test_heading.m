function [data_tag, data,duration] = compute_openLogger_test_heading(srate,limit_analyse_1,limit_analyse_2,seconds_offset_openlogger,plot_raw_data_logger,debug_signal_analyzer)

%Values from calib file Denis
%magoffset = [0.152927182306639,0.208748056831841,-1.248804735707136];
%gyrooffset = [-1.939845894149202,-1.568274583645210,0.270577010042415];
%acceloffset = [-0.103780476157061,0.007614166198852,-1.036751691928643];

% 31/07 cap lahoussaye
%magoffset = [0.136818346243489,0.268855986138463,-1.175620929897863]; % magcal of matlab
% gyrooffset = [-20.988130652883655,48.612831533327610,3.596444333740783];
% acceloffset = [-0.187224220556189,-0.015817578808423,0.394435021615690];
%%magoffset = [0.120117187500000,0.274658203125000,-1.171875000000000]; % Matcal of openlogger

% 30/07 cap lahoussaye
%magoffset = [0.180513836644155,0.356303244960032,-1.484244505380358];
%magoffset = [0,0,0];
%gyrooffset = [0,0,0];
%acceloffset = [0,0,0];

% 28/07 Lagon
%magoffset =  [0.078150902944115,0.215528876471920,-1.186365526925765];
%acceloffset= [-0.043788911183251,0.030465878235901, -0.981116849396555];  % -0.981116849396555
% gyrooffset = [-2.050545326037154,-1.406808488967219,-0.344032051165237];

% % 09/08 Lagon sans balise acoustique
% %magoffset = [0.484949243515582,-0.080399279952091,1.125456899085779]; %
% %Normal
% magoffset = [0.522672009672795,-0.093203009082204,1.094853786041187]; % Normal 2
% %magoffset = [0.495117187500000,-0.048339843750000,-1.127929687500000]; % Mag monté sur nageur
% %magoffset = [0.558566214006135,-0.139782803970343,-1.102273805985928]; % 640 -> 3000
% %acceloffset= [0.001599423142261,0.023299381453465,1.049577388367752];  
% acceloffset = [0.224028600778445,-0.004705686585712,0.955060244319432]; % Mean when swimming
% %gyrooffset = [-2.151660876284835,-1.424486712794458,-0.196506964567452];
% gyrooffset = [-2.244574722221528,-1.413909200751742,-0.320587614436356]; %Mean when swimming

% 11/08 Lagon paddle
magoffset = [0.574558328221043,-0.134819654953681,-1.151682278333546];
%1 On the water
% gyrooffset = [-2.172209601048540,-1.355069562259423,0.167636150504274];
% acceloffset = [0.014422994307389,0.021201033230854,-0.977077167574298];
% 2 on the desk with x,y,z to 0
% gyrooffset = [-2.193317906794854,-1.349997571104393,0.135782435154590];
% acceloffset = [0.019028856134194,0.015263854347308,-0.977832513367470];
% 3 on the desf with x,y to à z -1
gyrooffset = [-2.209456178405597,-1.372186389759462,0.164250542719166];
acceloffset = [0.014100494247450,-0.005173908878643,1.052594252293521];


data_raw = openlogger_load_time(); % load data file

[data, time] = openlogger_compute_data(data_raw,gyrooffset,acceloffset,magoffset,srate);

if (plot_raw_data_logger == 1)
openlogger_plot_data(data.gyro,data.accel,data.mag,data.depth,data.spin,time)
end

% if (debug_signal_analyzer == 1)
%     data_a = struct2table(data);
%     data_array = table2array(data_a);
% end
% 
% FileName = data_raw.name;
% 
% a = string(FileName(1:6));
% a = strcat(FileName(1:2),{'/'},FileName(3:4),{'/20'},FileName(5:6));
% b = string(FileName(8:13));
% b = strcat(FileName(8:9),{':'},FileName(10:11),{':'},FileName(12:13),{'.0'});
% time_log = datetime(strcat(a,{' '},b),'InputFormat','dd/MM/yyyy HH:mm:ss.S');
% time_log = time_log + seconds(seconds_offset_openlogger);
% %time_analyse = (time_log:seconds(1):limit_analyse_2)';
% 
% sec = seconds(length((data.accel(:,1)))/100);
% time_end_log = time_log +sec;
% 
% 
% time_analyse = (time_log:milliseconds(10):time_end_log-seconds(0.01))';

% time_log_start = data.time(1,1) + seconds(seconds_offset_openlogger);
% time_log_end = data.time(end,1) + seconds(seconds_offset_openlogger);

t1 = datetime(limit_analyse_1,'InputFormat','yyyy-dd-MM HH:mm:ss');
t2 = datetime(limit_analyse_2,'InputFormat','yyyy-dd-MM HH:mm:ss');

data_raw.time = data_raw.time + seconds(seconds_offset_openlogger);
%Creation of timetable
%length_d = 1:length(time_analyse(:,1));
varNames = {'gyro','accel','mag','depth','spin'};
data_tt = timetable(data_raw.time,data.gyro(:,1:3),data.accel(:,1:3),data.mag(:,1:3),data.depth(:,1),data.spin(:,1),'VariableNames',varNames);
%data_s = timetable(time_analyse,data.gyro(length_d,1));
%Creation of time range
TR = timerange(t1,t2);
data_tt = data_tt(TR,:);

data_tt = retime(data_tt,'regular','fillwithmissing','TimeStep',seconds(0.01));
data_tt = fillmissing(data_tt,'linear');

length_dur = 1:size(data.accel(:,1));
duration = milliseconds(length_dur)*10;
varNames = {'accel','mag','depth','spin','gyro'};
data_tag = timetable(duration',data.accel(:,1:3),data.mag(:,1:3),data.depth(:,1),data.spin(:,1),data.gyro(:,1:3),'VariableNames',varNames);



end

