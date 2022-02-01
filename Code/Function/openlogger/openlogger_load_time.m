function INER = openlogger_load_time()

%% Load data from CSV file 
[FileName,PathName,FilterIndex] = uigetfile({'*.CSV','CSV files (*.CSV)'},'Select a CSV file');
if isequal(FileName,0)|isequal(PathName,0)
   return
end

%% Import data from file
opts = delimitedTextImportOptions("NumVariables", 18);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "date", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18"];
opts.SelectedVariableNames = "date";
opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Specify variable properties
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "date", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "date", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18"], "EmptyFieldRule", "auto");


cd(PathName);
% Import the data
time_raw = readmatrix(FileName, opts);


clear opts
% Import the data
%time_raw = readmatrix("D:\Seafile\These Pierre\Code\Matlab\Scripts_analyse\Article_1\Script\analyse_data_logger_rtk\test_11_08_lagon_paddle\opentag\110821T151057.csv", opts);


%% function for time correction
inc=1;
for i =100:length(time_raw(:,1))
if ~ismissing(time_raw(i,1))

buf = char(time_raw(i,1));
b(inc,:)=(buf(11:18));
inc = inc + 1;
miss(inc,1)= 0;

end

if ismissing(time_raw(i,1))
miss(inc,1)= miss(inc,1)+ 1;
end
end

%a = string(FileName(1:6));
a = strcat(FileName(1:2),{'/'},FileName(3:4),{'/20'},FileName(5:6));

time_log = datetime(strcat(a,{' '},b),'InputFormat','dd/MM/yyyy HH:mm:ss');

%time_log = datetime(a,'InputFormat','HH:mm:ss');

for j = 1:99
time_log_100(j,1) = time_log(1,1) + seconds(0.01*j) - seconds(1);
end

inc = 100;
for i=1:length(time_log(:,1))
for j = 1:100
time_log_100(inc,1) = time_log(i,1) + seconds(0.01*j-0.01);
inc = inc+1;
end
end

%% DATA
% % Setup the Import Options
% opts = delimitedTextImportOptions("NumVariables", 9);
% 
% Specify range and delimiter
% opts.DataLines = [2, Inf];
% opts.Delimiter = ";";
% 
% Specify column names and types
% opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9"];
% opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double"];
% opts.ExtraColumnsRule = "ignore";
% opts.EmptyLineRule = "read";%% Setup the Import Options

% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 18);

% Specify range and delimiter
opts.DataLines = [2, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["VarName1", "VarName2", "VarName3", "VarName4", "VarName5", "VarName6", "VarName7", "VarName8", "VarName9", "VarName10", "VarName11", "VarName12", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
opts = setvaropts(opts, 10, "TrimNonNumeric", true);
opts = setvaropts(opts, 10, "ThousandsSeparator", ",");
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";


cd(PathName);
% Import the data
M = readtable(FileName, opts);

%time = 
%% Convert to output type
M = table2array(M);

% = csvread(FileName, 1, 0);

% Calibration factors
accelFullRange = 2.0;
gyroFullRange = 1000.0;
magFullRange = 4800.0e-6; % Tesla
magFullRange = magFullRange * 10000.0; % 1 tesla = 10000 Gauss

accel_cal = accelFullRange / 32768.0;  
gyro_cal = gyroFullRange / 32768.0; 
mag_cal = magFullRange / 32768.0;

% calibrate and re-orient magnetometer to align with accel and gyro
INER=[];
INER.accel(:,1) = M(:,1) * accel_cal * -1;      %X
INER.accel(:,2) = M(:,2) * accel_cal; %Y
INER.accel(:,3) = M(:,3) * accel_cal * -1; %Z

INER.mag(:,1) = M(:,5) * mag_cal;     % X: swap magnetometer X & Y
INER.mag(:,2) = M(:,4) * mag_cal * -1;          % Y
INER.mag(:,3) = M(:,6) * mag_cal;     % Z

INER.gyro(:,1) = M(:,7) * gyro_cal;   % X
INER.gyro(:,2) = M(:,8) * gyro_cal * -1;   % Y
INER.gyro(:,3) = M(:,9) * gyro_cal;        % Z

INER.data(:,1) = M(:,10);

INER.depth = M(:,15); % Depth in m
INER.spin = M(:,end); % Spin in tr/min
INER.name = FileName;

INER.time = time_log_100(1:length(M(:,1)),1);

end