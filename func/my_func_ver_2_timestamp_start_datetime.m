% This func is to get the first PPG segment datetime, so we can convert
% watch app ver 2.0.1 CLOCK_MONOTONIC time into MATLAB datetime.

function [PPG_timestamp_ver_2_start_datetime,...
    PPG_timestamp_ver_2_start_msec,...
    ACC_timestamp_ver_2_start_datetime,...
    ACC_timestamp_ver_2_start_msec] = my_func_ver_2_timestamp_start_datetime(UID)

switch UID
    case '913_02042021'
        % The start time of first 30-sec segment.
        PPG_timestamp_ver_2_start_datetime_string = '02/04/2021 14:36:26.544'; % 24 hours time.
        PPG_timestamp_ver_2_start_datetime = datetime(PPG_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        PPG_timestamp_ver_2_start_msec = [1882515]; % milisecond.
        
        ACC_timestamp_ver_2_start_datetime_string = '02/04/2021 14:36:26.543'; % 24 hours time.
        ACC_timestamp_ver_2_start_datetime = datetime(ACC_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        ACC_timestamp_ver_2_start_msec = [1882515]; % milisecond. ACC is same as PPG.
    case '914_2021042601'
        % The start time of first 30-sec segment.
        PPG_timestamp_ver_2_start_datetime_string = '04/26/2021 11:27:00.042'; % 24 hours time.
        PPG_timestamp_ver_2_start_datetime = datetime(PPG_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        PPG_timestamp_ver_2_start_msec = [42243]; % milisecond.
        
        ACC_timestamp_ver_2_start_datetime_string = '04/26/2021 11:27:00.042'; % 24 hours time.
        ACC_timestamp_ver_2_start_datetime = datetime(ACC_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        ACC_timestamp_ver_2_start_msec = [42243]; % milisecond. ACC is same as PPG.
    case '400' % AF trial patient 1.
        % The start time of first 30-sec segment.
        PPG_timestamp_ver_2_start_datetime_string = '05/24/2021 12:17:53.691'; % 24 hours time. Column 4 in the txt file.
        PPG_timestamp_ver_2_start_datetime = datetime(PPG_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        PPG_timestamp_ver_2_start_msec = [646596]; % milisecond. Column 1 in the txt file.
        
        ACC_timestamp_ver_2_start_datetime_string = '05/24/2021 12:17:53.681'; % 24 hours time. Column 3 in the txt file.
        ACC_timestamp_ver_2_start_datetime = datetime(ACC_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        ACC_timestamp_ver_2_start_msec = [646586]; % milisecond. Column 1 in the txt file.
    case '914' % For Billal and Youngsun temporary.
        % The start time of first 30-sec segment.
        PPG_timestamp_ver_2_start_datetime_string = '07/29/2021 14:58:07.866'; % 24 hours time. Column 4 in the txt file.
        PPG_timestamp_ver_2_start_datetime = datetime(PPG_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        PPG_timestamp_ver_2_start_msec = [1627585087866]; % milisecond. Column 1 in the txt file.
        
        ACC_timestamp_ver_2_start_datetime_string = '05/24/2021 14:58:07.799'; % 24 hours time. Column 3 in the txt file.
        ACC_timestamp_ver_2_start_datetime = datetime(ACC_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        ACC_timestamp_ver_2_start_msec = [1627585087799]; % milisecond. Column 1 in the txt file.
    case '117'
        % The start time of first 30-sec segment.
        PPG_timestamp_ver_2_start_datetime_string = '08/16/2021 11:18:34.180'; % 24 hours time. Column 4 in the txt file.
        PPG_timestamp_ver_2_start_datetime = datetime(PPG_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        PPG_timestamp_ver_2_start_msec = [1629127114180]; % milisecond. Column 1 in the txt file.
        
        ACC_timestamp_ver_2_start_datetime_string = '08/16/2021 11:18:34.180'; % 24 hours time. Column 3 in the txt file.
        ACC_timestamp_ver_2_start_datetime = datetime(ACC_timestamp_ver_2_start_datetime_string,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        ACC_timestamp_ver_2_start_msec = [1629127114180]; % milisecond. Column 1 in the txt file.
    otherwise
        disp('UID was not documented, check!');
        keyboard;
end
end