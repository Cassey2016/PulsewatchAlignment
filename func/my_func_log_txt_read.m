% thisfunction is to load log file with different format:
% First version of log file:
% 001, 002, 003, 004, 005, 006, 007, 009.

% Dong, 08/18/2020.
function [m_output_struct,m_API_ver,m_service_var,m_time,m_time_idx] = my_func_log_txt_read(long_ECG_txt_filename)

    max_seg = 30; % maximum of segment inside one log file is less than 30 segments.

    m_op = NaN(max_seg,1);

    m_HR_DATPD = NaN(max_seg,1);
    m_HR_SWEPD = NaN(max_seg,1);
    m_HR_WEPD = NaN(max_seg,1);
    m_comb = NaN(max_seg,1);
    m_RMSSD = NaN(max_seg,1);
    m_SampEn = NaN(max_seg,1);
    m_IsAF_1 = NaN(max_seg,1);% Mr. Cho has 3 different IsAF sentence.
    m_IsAF_2 = NaN(max_seg,1);
    m_IsAF_3 = NaN(max_seg,1);
    m_PACPVC_pred_1 = NaN(max_seg,1);% Mr. Cho has 2 different PACPVC pred sentence.
    m_PACPVC_pred_2 = NaN(max_seg,1);
    m_FastAF_1 = NaN(max_seg,1); % Mr. Cho has 2 different FastAF sentence.
    m_FastAF_2 = NaN(max_seg,1);
    
    m_HR_1 = NaN(max_seg,1); % Mr. Cho has 3 different HR sentence.
    m_HR_2 = NaN(max_seg,1);
    m_HR_3 = NaN(max_seg,1);

    m_seg_num = NaN(max_seg,1);
    m_index = NaN(max_seg,1);
    m_mSensorEnable = NaN(max_seg,1); % msensorenable is double.
    m_seg_start_row_idx = NaN(max_seg,1);
    m_seg_end_row_idx = NaN(max_seg,1); % time inside each segment.
    
    m_API_ver = cell(max_seg,1); % API is string.
    m_service_var = cell(max_seg,1); % service is string.
    
    m_storage_total_size = NaN(max_seg,1);
    m_storage_avail_size = NaN(max_seg,1);
    m_battery_perc = NaN(max_seg,1);
%% ---------- Open txt file -------
    f = fopen(long_ECG_txt_filename,'r');
    fseek(f,0,'eof');           %Move to end of file
    end_pos = ftell(f);         % save the end position of current file.
    fseek(f,0,'bof');           %Move to beginning of file

    % load time.
    num_row = 0;
    count_row = 0; % count current row.
    max_row = 500; % max lines in log txt.
    m_time = cell(max_row,1); % create an empty txt.
    m_time_idx = NaN(max_row,1); % the row index of time.
    time_flag = false; % mark if this log file contains time.
    
    while ftell(f) <= end_pos - 1
        TLINE = fgets(f);
        count_row = count_row + 1;
        contain_flag = contains(TLINE, ']'); % time ends with ']' like '11:50:00]'
        if contain_flag
            time_flag = true; % this log contains time.
            temp_loc = strfind(TLINE,']'); % where time ends.
            num_row = num_row + 1; % make it one since start from zero.
            m_time{num_row,1} = TLINE(1,1:temp_loc-1);% I don't want the ']'
            m_time_idx(num_row,1) = count_row;% for later m_seg_start_row_idx, m_seg_end_row_idx.
        end
    end
    
    m_time = m_time(1:num_row,1); % remove useless cell.
    m_time_idx = m_time_idx(1:num_row,1); % remove useless NaN.
%% ------- Read Data ----------
fseek(f,0,'bof');           %Move to beginning of file
count_seg = 0; % start with one
count_row = 0; % count the row.
last_pos = 1; % last row starts with one.
while ftell(f) <= end_pos - 1
        
    TLINE = fgets(f); % Read line from file, keeping newline characters
    count_row = count_row + 1; % read a new line.
    fprintf('%s\n',TLINE);
    TLINE_len = length(TLINE); % length of char.
    C = strsplit(TLINE,' ');
    str_cell = my_dictionary_sentence(); % string cell that contains all possible log sentence.
    for cc = 1:size(str_cell,1)
        contain_flag = contains(TLINE, str_cell{cc,1}); % check if contains wanted string.
        if contain_flag
            fprintf('Search: %s\n',str_cell{cc,1});
            temp_loc = strfind(TLINE,str_cell{cc,1}); % which location started the matching string.
           % there is a string contained here:
           if cc == 1
               count_seg = count_seg + 1; % this is a new segment, so add one.
               m_seg_num(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']); % seg index is integer.
               % --- added 08/31/2020: for segment time ---
               m_seg_start_row_idx(count_seg,1) = count_row; % the line index of new 30-sec seg.
               % --- end of added 08/31/2020: for segment time ---
           end
           % in case the first seg does not start with 'segment and index'
           if cc > 1 && count_seg < 1
              % no 'segment' sentence before the first segment:
              count_seg = count_seg + 1; % I will ignore index is not accurately recorded. 08/20/2020.
           end

           if cc == 2
               m_HR_WEPD(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']); % seg index is integer.
           end
           if cc == 3
               m_comb(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 4
               m_RMSSD(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end           
           if cc == 5
               m_SampEn(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 6
                m_IsAF_1(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
           end
           if cc == 7
               m_HR_DATPD(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 8
                m_HR_SWEPD(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 9
               m_PACPVC_pred_1(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
           end
           if cc == 10
                m_FastAF_1(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
           end
           if cc == 11
               m_index(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']); % index is integer.
           end
           if cc == 12
               % PACPVC_predict_label has two form:
                % PACPVC_predict_label is 
                % PACPVC_predict_label 
               temp = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']); % see if read empty.
               if isempty(temp)
                   temp = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'is %d']); % try another form.
                   if isempty(temp)
                      % I have never met this case. Check.
                      keyboard;
                   else
                       m_PACPVC_pred_2(count_seg,1) = temp;
                   end
               else
                  % not empty:
                m_PACPVC_pred_2(count_seg,1) = temp;
               end
           end           
           if cc == 13
               temp = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
               if isempty(temp)
                   % I don't want to update
%                    my_stop = 1;
               else
                    m_op(count_seg,1) = temp;
               end
           end
           if cc == 14
                m_HR_1(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 15
               m_FastAF_2(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
           end
           if cc == 16
                m_API_ver{count_seg,1} = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%s']);
           end
           if cc == 17
               m_service_var{count_seg,1} = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%s']);
           end
           if cc == 18
                m_HR_2(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 19
               m_IsAF_2(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
           end
           if cc == 20
                m_mSensorEnable(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
                % from 017, when mSensorEnable occurs, it is the end of
                % this segment.
                m_seg_end_row_idx(count_seg,1) = count_row; % the line index of last 30-sec seg.
           end
           if cc == 21
                m_HR_3(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']);
           end
           if cc == 22
               m_IsAF_3(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%d']);
           end
           if cc == 23
               m_storage_total_size(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']); % Float var.
               if count_seg == 1
                   count_seg = 0; % reset the pointer to first index.
               else
                  disp('Not beginning of log file has count seg, check!'); 
                  keyboard;
               end
           end
           if cc == 24
               m_storage_avail_size(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']); % Float var.
               if count_seg == 1
                   count_seg = 0; % reset the pointer to first index.
               else
                  disp('Not beginning of log file has count seg, check!'); 
                  keyboard;
               end
           end
           if cc == 25
               m_battery_perc(count_seg,1) = sscanf(TLINE(temp_loc:TLINE_len),[str_cell{cc,1},'%f']); % Float var.
               if count_seg == 1
                   count_seg = 0; % reset the pointer to first index.
               else
                  disp('Not beginning of log file has count seg, check!'); 
                  keyboard;
               end
           end
        end
    end
end

fclose(f);

% clean up arrays:
    m_op = m_op(1:count_seg,1); % after these number of seg, remove them.

    m_HR_DATPD = m_HR_DATPD(1:count_seg,1);
    m_HR_SWEPD = m_HR_SWEPD(1:count_seg,1);
    m_HR_WEPD = m_HR_WEPD(1:count_seg,1);
    m_comb = m_comb(1:count_seg,1);
    m_RMSSD = m_RMSSD(1:count_seg,1);
    m_SampEn = m_SampEn(1:count_seg,1);
    m_IsAF_1 = m_IsAF_1(1:count_seg,1);
    m_IsAF_2 = m_IsAF_2(1:count_seg,1);
    m_IsAF_3 = m_IsAF_3(1:count_seg,1);
    m_PACPVC_pred_1 = m_PACPVC_pred_1(1:count_seg,1);
    m_PACPVC_pred_2 = m_PACPVC_pred_2(1:count_seg,1);
    m_FastAF_1 = m_FastAF_1(1:count_seg,1);
    m_FastAF_2 = m_FastAF_2(1:count_seg,1);
    
    m_HR_1 = m_HR_1(1:count_seg,1);
    m_HR_2 = m_HR_2(1:count_seg,1);
    m_HR_3 = m_HR_3(1:count_seg,1);

    m_seg_num = m_seg_num(1:count_seg,1);
    m_index = m_index(1:count_seg,1);
    m_mSensorEnable = m_mSensorEnable(1:count_seg,1);
    
    m_API_ver = m_API_ver(1:count_seg,1); % not sure if cell can work like this.
    m_service_var = m_service_var(1:count_seg,1);
    
    m_seg_start_row_idx = m_seg_start_row_idx(1:count_seg,1);
    m_seg_end_row_idx = m_seg_end_row_idx(1:count_seg,1);
    
    m_storage_total_size = m_storage_total_size(1:count_seg,1);
    m_storage_avail_size = m_storage_avail_size(1:count_seg,1);
    m_battery_perc = m_battery_perc(1:count_seg,1);
    
m_output_struct = struct('m_op',m_op,...
    'm_HR_DATPD',m_HR_DATPD,...
    'm_HR_SWEPD',m_HR_SWEPD,...
    'm_HR_WEPD',m_HR_WEPD,...
    'm_comb',m_comb,...
    'm_RMSSD',m_RMSSD,...
    'm_SampEn',m_SampEn,...
    'm_IsAF_1',m_IsAF_1,...
    'm_IsAF_2',m_IsAF_2,...
    'm_IsAF_3',m_IsAF_3,...
    'm_PACPVC_pred_1',m_PACPVC_pred_1,...
    'm_PACPVC_pred_2',m_PACPVC_pred_2,...
    'm_FastAF_1',m_FastAF_1,...
    'm_FastAF_2',m_FastAF_2,...
    'm_HR_1',m_HR_1,...
    'm_HR_2',m_HR_2,...
    'm_HR_3',m_HR_3,...
    'm_seg_num',m_seg_num,...
    'm_index',m_index,...
    'm_mSensorEnable',m_mSensorEnable,...
    'm_seg_start_row_idx',m_seg_start_row_idx,...
    'm_seg_end_row_idx',m_seg_end_row_idx,...
    'm_storage_total_size',m_storage_total_size,...
    'm_storage_avail_size',m_storage_avail_size,...
    'm_battery_perc',m_battery_perc);

% next step is to put time here.
end

function str_cell = my_dictionary_sentence()
% Below are all the possible output from Mr. Cho's log file:
    str_1_seg_num = 'segment number is ';
    str_2_HR_WEPD = 'heart rate(WEPD) is ';
    str_3_comb = 'comb is ';
    str_4_RMSSD = 'Rmssd_mean is ';
    str_5_SampEn = 'SampEn is ';
    str_6_IsAF_1 = 'IsAF is ';
    str_7_HR_DATPD = 'heart rate(DATPD) is ';
    str_8_HR_SWEPD = 'heart rate(SWEPD) is ';
    str_9_PACPVC_pred_1 = 'PVCPAC flag is ';
    str_10_FastAF_1 = 'fast_AF_flag is ';
    str_11_index = 'index:';
    str_12_PACPVC_pred_2 = 'PACPVC_predict_label ';
    str_13_op = 'Noise ';
    str_14_HR_1 = 'HR is ';
    str_15_FastAF_2 = 'Fast_AF_flag is ';
    str_16_API_ver = 'API Version Number is ';
    str_17_service_ver = 'Service Version is ';
    str_18_HR_2 = 'PPG:hr is ';
    str_19_IsAF_2 = 'afib is ';
    str_20_mSensorEnable = 'mSensorEnable is ';
    str_21_HR_3 = 'PPG:mHR is ';
    str_22_IsAF_3 = 'mAFib is ';
    str_23_storage_total = 'check_storage : Total : ';
    str_24_storage_avail = ', Available : ';
    str_25_battery_perc = 'Percentage : ';
    
    str_cell = {str_1_seg_num;...
        str_2_HR_WEPD;...
        str_3_comb;...
        str_4_RMSSD;...
        str_5_SampEn;...
        str_6_IsAF_1;...
        str_7_HR_DATPD;...
        str_8_HR_SWEPD;...
        str_9_PACPVC_pred_1;...
        str_10_FastAF_1;...
        str_11_index;...
        str_12_PACPVC_pred_2;...
        str_13_op;...
        str_14_HR_1;...
        str_15_FastAF_2;...
        str_16_API_ver;...
        str_17_service_ver;...
        str_18_HR_2;...
        str_19_IsAF_2;...
        str_20_mSensorEnable;...
        str_21_HR_3;...
        str_22_IsAF_3;...
        str_23_storage_total;...
        str_24_storage_avail;...
        str_25_battery_perc};
end