function [each_ECG_start_time,...
    each_ECG_end_time,...
    output_ECG_file_name,...
    ECG_init_datetime] = my_func_know_each_ECG_start_end_time(ECG_path,...
    ECG_Date_sting)

% This func is to generate the start and end of time for each ECG segment
% according to the UMass ECG patch start time.
list = dir(ECG_path); % for now I will let the code run the first one, later I will change to load according to PPG time. 09/03/2020.
list = list(3:end); % first two cells are . and ..
output_ECG_file_name = cell(size(list,1),1);
for ii = 1:size(list,1)
    output_ECG_file_name{ii,1} = list(ii).name;
end

ECG_init_datetime = datetime(ECG_Date_sting,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
%% 4. Know each ECG file start and end time.
each_ECG_start_time = NaT(size(list,1),1,'TimeZone','America/New_York'); % stores the start time (datetime) for the beginning of ECG file.
each_ECG_end_time = NaT(size(list,1),1,'TimeZone','America/New_York'); % stores the end time (datetime) for the ending of ECG file.

for ii = 1:size(list,1)
    load([ECG_path,filesep,output_ECG_file_name{ii,1}]); % Data col 1 is time.
    temp_t = Data(:,1);
    temp_start = temp_t(1); % time in seconds (double).
    temp_end = temp_t(end);
    temp_start_time = seconds(temp_start) + ECG_init_datetime;
    temp_start_time.Format = 'MM/dd/yyyy HH:mm:ss.SSS';
    temp_end_time = seconds(temp_end) + ECG_init_datetime;
    temp_end_time.Format = 'MM/dd/yyyy HH:mm:ss.SSS';
    
    each_ECG_start_time(ii,1) = temp_start_time;
    each_ECG_end_time(ii,1) = temp_end_time;
end
end
