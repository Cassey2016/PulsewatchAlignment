% This func is to prepare watch PPG and ACC 
function [PPG_raw_buffer,...
    PPG_t_msec,...
    PPG_t_datetime,...
    ACC_raw_buffer,...
    ACC_t_msec,...
    ACC_t_datetime,...
    SamsungHR_buffer,...
    SamsungHR_t_msec,...
    SamsungHR_t_datetime,...
    PPG_timestamp_start,...
    PPG_timestamp_end,...
    add_1_day_flag,...
    PPG_t_msec_ver_2,...
    PPG_t_datetime_ver_2,...
    ACC_t_msec_ver_2,...
    ACC_t_datetime_ver_2,...
    PPG_timestamp_ver_2_raw,...
    ACC_timestamp_ver_2_raw] = my_func_prep_watch_PPG_ACC(PPG_file_buffer,...
                                                        ACC_file_buffer,...
                                                        fs_PPG,...
                                                        fs_ACC,...
                                                        PPG_file_name,...
                                                        m_log_path,...
                                                        time_aim23_path,...
                                                        UID,...
                                                        add_1_day_flag)

    m_log_file_name = [m_log_path,filesep,PPG_file_name(1:23),'_m_log.mat']; % 013_2019_11_06_11_46_26_m_log.mat

    % UID 043, 043_2020_08_27_20_16_52 does not have log file but only
    % long file name for PPG and ACC.
    if ~exist(m_log_file_name,'file')
        m_API_ver = cell(1,1); % put it as empty, and see if PPG has three columns.
    else
        load(m_log_file_name); % need to use: m_time, m_time_idx, m_API_ver, m_output_struct.
    end

% --- 10/27/2020: 037, idx 3574, 07_03_21_50_12_log has not enough info ---

    if isempty(m_API_ver) || isempty(m_API_ver{1,1}) % it could be an empty cell like {[]}
        if size(PPG_file_buffer,2) == 4
             temp_m_API_ver = m_API_ver(~cellfun('isempty',m_API_ver));
             if isempty(temp_m_API_ver) && strcmp(PPG_file_name(1:3),'400') % UID 400 has issue with phone app service restarted.
                 m_API_ver{1,1} = ['2.0.1'];
             elseif isempty(temp_m_API_ver) && strcmp(PPG_file_name(1:3),'914')
                 m_API_ver{1,1} = ['2.1.3'];
             elseif isempty(temp_m_API_ver) && (strcmp(PPG_file_name(1:3),'402')...
                     || strcmp(PPG_file_name(1:3),'403')...
                     || strcmp(PPG_file_name(1:3),'405')...
                     || strcmp(PPG_file_name(1:3),'406')...
                     || strcmp(PPG_file_name(1:3),'410')...
                     || strcmp(PPG_file_name(1:3),'411')...
                     || strcmp(PPG_file_name(1:3),'413')...
                     || strcmp(PPG_file_name(1:3),'414')...
                     || strcmp(PPG_file_name(1:3),'415')...
                     || strcmp(PPG_file_name(1:3),'416')...
                     || strcmp(PPG_file_name(1:3),'419')...
                     || strcmp(PPG_file_name(1:3),'420')...
                     || strcmp(PPG_file_name(1:3),'421')...
                     || strcmp(PPG_file_name(1:3),'422')...
                     || strcmp(PPG_file_name(1:3),'417')...
                     || strcmp(PPG_file_name(1:3),'418')...
                     || strcmp(PPG_file_name(1:3),'423'))
                 m_API_ver{1,1} = ['2.0.1'];
                 m_service_var{1,1} = ['2.1.1'];
             else
                 fprintf('func\my_func_prep_watch_PPG_ACC.m: Unknown API, check!\n');
                keyboard; 
             end
        elseif size(PPG_file_buffer,2) == 3
            m_API_ver{1,1} = ['1.0.15']; % there are three columns in PPG, so it is still 1.0.15.
        else
            if isempty(PPG_file_buffer) && str2num(PPG_file_name(1:3)) >= 36 % UID 036 and 043 all have empty PPG segment.
               % PPG idx 47888:
               % For PPG idx 51285, I have to remove
               % 'isempty(ACC_file_buffer)' because ACC txt file does not
               % exist.
                m_API_ver{1,1} = ['1.0.15']; 
            else
                if str2num(PPG_file_name(1:3)) >= 13 && str2num(PPG_file_name(1:3)) < 36
                    m_API_ver{1,1} = ['1.0.11']; 
                elseif str2num(PPG_file_name(1:3)) < 13
                    m_API_ver{1,1} = ['1.0.0'];
                end
            end
        end
    end
   
    if ~exist('m_time_idx','var')
       % in case this variable does not exist.
       m_time_idx = [];
    end
    % there is a version in the log file, but there could be no time
    % stamp:
    if size(m_API_ver,1) == 1 % Only for line 128.
       m_API_ver{2,1} = m_API_ver{1,1}; % Duplicate to extend the size of API version to 2.
    end
    if strcmp(m_API_ver{1,1},'1.0.0') || ((isempty(m_time_idx)) && (strcmp(m_API_ver{1,1},'1.0.11') || strcmp(m_API_ver{1,1},'1.0.13')))
        % no time stamps, so use the time in file name for reference.
        temp_curr_seg = str2num(PPG_file_name(29:32)); %'0000'
%             PPG_timestamp_start = seconds(1 * (temp_curr_seg + 1)) + seconds(30 * temp_curr_seg) + datetime(PPG_file_name(5:23),'InputFormat','yyyy_MM_dd_HH_mm_ss','TimeZone','America/New_York');
        PPG_timestamp_start = seconds(30 * temp_curr_seg) + datetime(PPG_file_name(5:23),'InputFormat','yyyy_MM_dd_HH_mm_ss','TimeZone','America/New_York');
        PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG);

        if ~isempty(PPG_file_buffer) % PPG txt file is not empty.
            temp_timestamp = (1:size(PPG_file_buffer,1))./fs_PPG;
            temp_timestamp = temp_timestamp(:); % make sure temp timestamp is a column vector.
            PPG_t_datetime = (PPG_timestamp_start + seconds(temp_timestamp));
            PPG_t_datetime = PPG_t_datetime(:); % make sure it is a column vector.

            ACC_t_datetime = PPG_t_datetime; % let ACC be the same PPG time.
            PPG_t_msec = milliseconds(temp_timestamp); % I don't know if t in millisecond needs  
            ACC_t_msec = PPG_t_msec;

            PPG_raw_buffer = PPG_file_buffer(:,1);
            if ~isempty(ACC_file_buffer)
                % if ACC txt file is not empty.
                ACC_raw_buffer = ACC_file_buffer(:,1);
            else
                % ACC file is empty like UID 026, index 8614.
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));
            end
        else % PPG txt file is empty.
            PPG_raw_buffer = zeros((fs_PPG * 30),1); % 11/20/2020: I don't know if I should give zero to here.
            ACC_raw_buffer = zeros(size(PPG_raw_buffer));
            PPG_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
            ACC_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
            PPG_t_msec = zeros(size(PPG_raw_buffer));
            ACC_t_msec = zeros(size(PPG_raw_buffer));
        end
        % Get segment index 0000:
        PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
        if strcmp(PPG_4_dig_str,'0000')
            % it is segment 0000:
            % Worked: Plan 1: test cut first few seconds:
            cut_sec = 2;
            PPG_raw_buffer = PPG_raw_buffer(cut_sec*fs_PPG+1:end,1);
            PPG_t_msec = PPG_t_msec(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime = PPG_t_datetime(cut_sec*fs_PPG+1:end,1);
            PPG_file_buffer = PPG_file_buffer(cut_sec*fs_PPG+1:end,:);
%                     PPG_Samsung_HR = PPG_Samsung_HR(cut_sec*fs_PPG+1:end,1);
            SamsungHR_buffer = zeros(size(PPG_raw_buffer)); % no Samsung HR.
            SamsungHR_t_msec = PPG_t_msec; % no Samsung HR t_msec.
            SamsungHR_t_datetime = PPG_t_datetime; % no Samsung HR t datetime.
            % Plan 2: replace first two seconds with 
    %         PPG_raw_buffer = [ones(cut_sec*fs_PPG,1) * PPG_raw_buffer(cut_sec*fs_PPG+1);PPG_raw_buffer(cut_sec*fs_PPG+1:end,1)];

        else
    %         % I only want to replot all seg 0000 now.
    %         continue
    
            % ---Bug fixing for UID 032, seg 0001, idx 32. PPG file only has
            % 1366 samples, not 1500. 01/02/2022. ---
            if size(PPG_raw_buffer,1) < fs_PPG * 30
                % I have no way to figure out if I should fill the
                % beginning or the end, so I decided to fill the end with
                % the value of last sample to avoid sudden jump of the
                % signal.
                compensate_samples = fs_PPG * 30 - size(PPG_raw_buffer,1);
                
                PPG_raw_buffer = [PPG_raw_buffer;ones(compensate_samples,1) * PPG_raw_buffer(end,1)];
                temp_timestamp = (1:size(PPG_raw_buffer,1))./fs_PPG;
                temp_timestamp = temp_timestamp(:);
                PPG_t_msec = milliseconds(temp_timestamp);
                PPG_t_datetime = PPG_timestamp_start + seconds(temp_timestamp);
                PPG_file_buffer = [PPG_file_buffer;ones(compensate_samples,1) * PPG_file_buffer(end,1)];
                
                if size(ACC_raw_buffer,1) < fs_ACC * 30
                    ACC_raw_buffer = [ACC_raw_buffer;ones(compensate_samples,1) * ACC_raw_buffer(end,1)];
                end
                if size(ACC_t_msec,1) < fs_ACC * 30
                    ACC_t_msec = PPG_t_msec;
                end
                if size(ACC_t_datetime,1) < fs_ACC * 30
                    ACC_t_datetime = PPG_t_datetime;
                end
            end
            SamsungHR_buffer = zeros(size(PPG_raw_buffer)); % no Samsung HR.
            SamsungHR_t_msec = PPG_t_msec; % no Samsung HR t_msec.
            SamsungHR_t_datetime = PPG_t_datetime; % no Samsung HR t datetime.
        end
        PPG_t_msec_ver_2 = []; % For ver 2.0.1 testing. 03/02/2021.
        PPG_t_datetime_ver_2 = [];
        ACC_t_msec_ver_2 = [];
        ACC_t_datetime_ver_2 = [];
    elseif strcmp(m_API_ver{1,1},'1.0.11') || strcmp(m_API_ver{1,1},'1.0.13') || strcmp(m_API_ver{2,1},'1.0.13') && ~isempty(m_time_idx)
        if isempty(m_time_idx)
            % UID 012 might not have time stamp in log file.
           disp('No time stamp in log file, cannot align!'); 
           keyboard;
        else
            % UID 013 ~ 
            % There is time stamp in log file.

            % 1. extract the time stamp cell for each segment.
            m_seg_start_row_idx = m_output_struct.m_seg_start_row_idx;
            m_seg_end_row_idx = m_output_struct.m_seg_end_row_idx;
            m_seg_num = m_output_struct.m_seg_num;
            m_index = m_output_struct.m_index;

            m_seg_time = cell(size(m_index,1),1); % store the cut time string.
            for sss = 1:size(m_index,1)
                if isnan(m_seg_start_row_idx(sss,1))
                   if sss > 1
                        % not missing the beginning row index:
                        disp('middle seg missed row index, check!');
                        keyboard;
                   else
                       % the first segment is missing a start row
                       % index.
                       temp_start = m_time_idx(1,1); % the row num in time row index.
                       temp_end = find(ismember(m_time_idx,m_seg_end_row_idx(sss,1))); 
                       m_seg_time{sss,1} = m_time(temp_start:temp_end,1);
                   end
                else
                       temp_start = find(ismember(m_time_idx,m_seg_start_row_idx(sss,1)));  % the row num in time row index.
                       temp_end = find(ismember(m_time_idx, m_seg_end_row_idx(sss,1))); 
                       m_seg_time{sss,1} = m_time(temp_start:temp_end,1);
                end
            end
        end

        % get the time for this segment of PPG and ACC:
        temp_curr_seg = str2num(PPG_file_name(29:32)); %'0000'
% %             temp_seg_num_idx = find(ismember(m_seg_num,temp_curr_seg+1+count_all_PPG_seg)); % segment index starts from one.
%             temp_seg_num_idx = find(ismember(m_seg_num,temp_curr_seg+1+count_prev_log_PPG_seg));
%             if isempty(temp_seg_num_idx)
%                 disp('no matching seg num!');
%                 keyboard;
%             end
        temp_index_idx = find(ismember(m_index,temp_curr_seg)); % index starts from zero.

%             if temp_seg_num_idx ~= temp_index_idx
%                % the seg and index doesn't start at the same.
%                disp('seg and index array not start same, check!');
%                keyboard;
%             else
        % seg num and index are matching.
        if isempty(temp_index_idx)
            % no matching segment index
            if temp_curr_seg > 0
                % there is previous segment at least not empty.
                % load the time of last PPG segment. 
                prev_time_file_name = [time_aim23_path,filesep,PPG_file_name(1:28),num2str(temp_curr_seg-1,'%04d'),'_time_aim23.mat']; % 013_2019_11_06_11_46_26_ppg_0000_time_aim23
                if ~exist(prev_time_file_name,'file')
%                         disp('Prev segment''s time does not exist, check!');
%                         keyboard;
                    % no time stamps, so use the time in file name for reference.
                    temp_curr_seg = str2num(PPG_file_name(29:32)); %'0000'
                    PPG_timestamp_start = seconds(1 * (temp_curr_seg + 1)) + seconds(30 * temp_curr_seg) + datetime(PPG_file_name(5:23),'InputFormat','yyyy_MM_dd_HH_mm_ss','TimeZone','America/New_York');
                    PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG);
                else
                    load(prev_time_file_name); % using var: this_PPG_timestamp_end
                    PPG_timestamp_start = this_PPG_timestamp_end + seconds(1);
                    PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG); % this should not be 30-sec, but the size of PPG buffer.
                end
            elseif temp_curr_seg == 0
                % this is the first segment, so I am going to use the
                % time in PPG file name.
%                     temp_date = PPG_file_name(5:14);
%                     temp_time = PPG_file_name(16:23);
                PPG_timestamp_start = seconds(1) + datetime(PPG_file_name(5:23),'InputFormat','yyyy_MM_dd_HH_mm_ss','TimeZone','America/New_York'); % 11/20/2020: from my experience, the time is always 1 sec delay from the beginn
                PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG);
            else
                disp('unseen type of PPG file name seg, check!');
                keyboard;
            end
        else
            temp_m_seg_time = unique(m_seg_time{temp_index_idx,1});
            if  size(temp_m_seg_time,1) < 1
                % no time in log file, probably caused by power off the
                % watch early.s
                if temp_curr_seg > 0
                    % there is previous segment at least not empty.
                    % load the time of last PPG segment. 
                    prev_time_file_name = [time_aim23_path,filesep,PPG_file_name(1:28),num2str(temp_curr_seg-1,'%04d'),'_time_aim23.mat']; % 013_2019_11_06_11_46_26_ppg_0000_time_aim23
                    if ~exist(prev_time_file_name,'file')
%                             disp('Prev segment''s time does not exist, check!');
%                             keyboard;
                        % no time stamps, so use the time in file name for reference.
                        temp_curr_seg = str2num(PPG_file_name(29:32)); %'0000'
                        PPG_timestamp_start = seconds(1 * (temp_curr_seg + 1)) + seconds(30 * temp_curr_seg) + datetime(PPG_file_name(5:23),'InputFormat','yyyy_MM_dd_HH_mm_ss','TimeZone','America/New_York');
                        PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG);

                    else
                        load(prev_time_file_name); % using var: this_PPG_timestamp_end
                        PPG_timestamp_start = this_PPG_timestamp_end + seconds(1);
                        PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG); % this should not be 30-sec, but the size of PPG buffer.
                    end
                elseif temp_curr_seg == 0
                    % this is the first segment, so I am going to use the
                    % time in PPG file name.
%                     temp_date = PPG_file_name(5:14);
%                     temp_time = PPG_file_name(16:23);
                    PPG_timestamp_start = seconds(1) + datetime(PPG_file_name(5:23),'InputFormat','yyyy_MM_dd_HH_mm_ss','TimeZone','America/New_York'); % 11/20/2020: from my experience, the time is always 1 sec delay from the beginn
                    PPG_timestamp_end = PPG_timestamp_start + seconds(size(PPG_file_buffer,1)/fs_PPG);
                else
                    disp('unseen type of PPG file name seg, check!');
                    keyboard;
                end
            else %if size(temp_m_seg_time,1) >= 2
                % it is fine to have more than two. I will still use
                % the 2nd time.

                temp_date = PPG_file_name(5:14);
                temp_time = temp_m_seg_time{1,1}; % 1st time is the end of this 30-sec segment.
                
                % 03/11/2021: fix bug for ver 1.0.11 no timestamp PPG
                % spanning two days.
                span_two_days_flag = false; % Mark from 23:59 to 00:00.
                this_m_seg_time = m_seg_time{1,1};
                if isempty(this_m_seg_time)
                    if size(m_seg_time,1) > 1
                        this_m_seg_time = m_seg_time{2,1}; % For UID 310, the first cell is empty.
                    else
                        fprinft('my_func_prep_watch_PPG_ACC: m_seg_time is empty, check!\n');
                        keyboard;
                    end
                end
                first_m_seg_time = this_m_seg_time{1,1};
                this_hour_char = first_m_seg_time(1:2);
                if strcmp(PPG_file_name(16:17),'23') && strcmp(this_hour_char,'00') % 017_2019_12_04_23_59_49_ppg_0000.txt
                    % The file name starts before the 00:00 AM.
                    span_two_days_flag = true;
                else
                    temp_start_flag = true;
                    for tttt = 1:size(m_seg_time,1)
                        this_m_seg_time = m_seg_time{tttt,1};
                        if isempty(this_m_seg_time)
                            % this_m_seg_time is empty cell.
                            continue;
                        else
                            first_m_seg_time = this_m_seg_time{1,1};
                            if temp_start_flag% Initial previous hour char.
                                prev_hour_char = first_m_seg_time(1:2);
                                temp_start_flag = false;
                            end
                            this_hour_char = first_m_seg_time(1:2);
                            if strcmp(prev_hour_char,'23') && strcmp(this_hour_char,'00')
                                span_two_days_flag = true;
                                break;
                            end
                            prev_hour_char = this_hour_char; % Update previous hour char.
                        end
                    end
                end
                if size(temp_time,2) > 8 
                    % with millisecond.
                    if size(temp_time,2) == 14 % UID 018, index 1, time: 12:18:16:100:0
                        PPG_timestamp_end = datetime([temp_date,',',temp_time(1:12)],'InputFormat','yyyy_MM_dd,HH:mm:ss:SSS','TimeZone','America/New_York');
                    elseif size(temp_time,2) == 13
                        % 12:18:16:94:0
                        PPG_timestamp_end = datetime([temp_date,',',temp_time(1:11)],'InputFormat','yyyy_MM_dd,HH:mm:ss:SS','TimeZone','America/New_York');
                    elseif size(temp_time,2) == 12
                        % UID 018, index 502, 20:41:18:9:
                        PPG_timestamp_end = datetime([temp_date,',',temp_time(1:10)],'InputFormat','yyyy_MM_dd,HH:mm:ss:S','TimeZone','America/New_York');
                    else
                        disp('Unseen num of digit, check!');
                        keyboard;
                    end
                elseif size(temp_time,2) == 8
                    % without millisecond.
                    % 03/11/2021: check if it is a 5-min spanning 2 days.
                    PPG_timestamp_end = datetime([temp_date,',',temp_time],'InputFormat','yyyy_MM_dd,HH:mm:ss','TimeZone','America/New_York');
                else
                    disp('Unseen number of time digit, check!');
                    keyboard;
                end
                prev_time = PPG_file_name(16:17); % Initial the hour of previous 30-sec segment.
                if temp_index_idx > 1
                    prev_m_seg_time = unique(m_seg_time{temp_index_idx-1,1});
                    if ~isempty(prev_m_seg_time)
                        prev_time = prev_m_seg_time{1,1}; % For UID 310, the m_seg_time{1,1} is empty. 07/12/2021.
                    end
                end
                if span_two_days_flag && strcmp(temp_time(1:2),'00') && strcmp(prev_time(1:2),'23') % This is the transit 30-sec segment.
                    PPG_timestamp_end = PPG_timestamp_end + days(1);
                    add_1_day_flag = true;
                elseif add_1_day_flag % the 30-sec segment after the span in this 5-min period.
                    PPG_timestamp_end = PPG_timestamp_end + days(1);
                end
                PPG_timestamp_start = PPG_timestamp_end - seconds(size(PPG_file_buffer,1)/fs_PPG); % test with 30 sec.
            end
        end

        if ~isempty(PPG_file_buffer) % PPG txt file is not empty.
            temp_timestamp = (1:size(PPG_file_buffer,1))./fs_PPG;
            temp_timestamp = temp_timestamp(:); % make sure temp timestamp is a column vector.
            PPG_t_datetime = (PPG_timestamp_start + seconds(temp_timestamp));
            PPG_t_datetime = PPG_t_datetime(:); % make sure it is a column vector.

            ACC_t_datetime = PPG_t_datetime; % let ACC be the same PPG time.
            PPG_t_msec = milliseconds(temp_timestamp); % I don't know if t in millisecond needs  
            ACC_t_msec = PPG_t_msec;

            PPG_raw_buffer = PPG_file_buffer(:,1);
            if ~isempty(ACC_file_buffer)
                % if ACC txt file is not empty.
                ACC_raw_buffer = ACC_file_buffer(:,1);
            else
                % ACC file is empty like UID 026, index 8614.
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));
            end
        else % PPG txt file is empty.
            PPG_raw_buffer = zeros((fs_PPG * 30),1); % 11/20/2020: I don't know if I should give zero to here.
            ACC_raw_buffer = zeros(size(PPG_raw_buffer));
            PPG_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
            ACC_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
            PPG_t_msec = zeros(size(PPG_raw_buffer));
            ACC_t_msec = zeros(size(PPG_raw_buffer));
        end
        % tonight, test the timestamp. Try to align with ECG
        % time??? 09/01/2020.
        % === Added 06/28/2020: ====
        % Get segment index 0000:
        PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
        if strcmp(PPG_4_dig_str,'0000')
            % it is segment 0000:PPG_4_dig_str
            % Worked: Plan 1: test cut first few seconds:
            cut_sec = 2;
            PPG_raw_buffer = PPG_raw_buffer(cut_sec*fs_PPG+1:end,1);
            PPG_t_msec = PPG_t_msec(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime = PPG_t_datetime(cut_sec*fs_PPG+1:end,1);
            PPG_file_buffer = PPG_file_buffer(cut_sec*fs_PPG+1:end,:);
%                     PPG_Samsung_HR = PPG_Samsung_HR(cut_sec*fs_PPG+1:end,1);
            SamsungHR_buffer = zeros(size(PPG_raw_buffer)); % no Samsung HR.
            SamsungHR_t_msec = PPG_t_msec; % no Samsung HR t_msec.
            SamsungHR_t_datetime = PPG_t_datetime; % no Samsung HR t datetime.
            % Plan 2: replace first two seconds with 
    %         PPG_raw_buffer = [ones(cut_sec*fs_PPG,1) * PPG_raw_buffer(cut_sec*fs_PPG+1);PPG_raw_buffer(cut_sec*fs_PPG+1:end,1)];

        else
    %         % I only want to replot all seg 0000 now.
    %         continue
            SamsungHR_buffer = zeros(size(PPG_raw_buffer)); % no Samsung HR.
            SamsungHR_t_msec = PPG_t_msec; % no Samsung HR t_msec.
            SamsungHR_t_datetime = PPG_t_datetime; % no Samsung HR t datetime.
        end
        PPG_t_msec_ver_2 = []; % For ver 2.0.1 testing. 03/02/2021.
        PPG_t_datetime_ver_2 = [];
        ACC_t_msec_ver_2 = [];
        ACC_t_datetime_ver_2 = [];
    elseif strcmp(m_API_ver{1,1},'1.0.14') || strcmp(m_API_ver{1,1},'1.0.15') || strcmp(m_API_ver{1,1},'2.0.0')
        % both API version should have independent PPG time stamp.
        % interpolate PPG based on its timestamp:
        if ~isempty(PPG_file_buffer) % PPG txt file is empty.
            [PPG_raw_buffer,PPG_t_msec,PPG_t_datetime] = my_func_interpolate_watch_data(PPG_file_buffer,fs_PPG);
% ===== Testing for UID 036: why UID 019 has clean PPG HR? =====
%                 PPG_timestamp = PPG_file_buffer(:,1);
%                         
%                 % convert Epoch time (msec) to MATLAB datetime (msec):
%                 PPG_t_datetime = datetime(PPG_timestamp./1000,'ConvertFrom','posixTime','Format','dd-MMM-yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % 
%                 diff_PPG_t_msec = milliseconds(diff(PPG_t_datetime)); % calculate the sampling time (msec) between two samples.
%                 cumsum_PPT_t_msec = cumsum(diff_PPG_t_msec); % cumulative sum between sampling time (msec)
%                 rm_idx = find(cumsum_PPT_t_msec < 0);         % 036_2020_06_27_04_44_53_accel_0003 last sample is wrong time.
%                 PPG_t_datetime(rm_idx + 1) = []; % remove negative time samples.
%     
%                 PPG_t_msec = [0:(1/fs_PPG*1000):cumsum_PPT_t_msec(end)]; % 30sec into msec.
%                 PPG_t_msec = PPG_t_msec(:);
%                 
%                 PPG_raw_buffer = PPG_file_buffer(:,2);
% ===== End of Testing for UID 036 =====
            PPG_Samsung_HR = PPG_file_buffer(:,3); % get Samsung HR.

            if ~isempty(ACC_file_buffer) && size(ACC_file_buffer,2) > 1 % Cassey: 054_2020_10_10_13_02_59_ppg_0001, ACC file does not exits.
                [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime] = my_func_interpolate_watch_data(ACC_file_buffer,fs_ACC);
            else
                % ACC file does not exist.
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));
                ACC_t_msec = PPG_t_msec;
                ACC_t_datetime = PPG_t_datetime;
            end
        else
            if ~isempty(ACC_file_buffer) && size(ACC_file_buffer,2) > 1 % Cassey: 036, segment idx 51285.
                [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime] = my_func_interpolate_watch_data(ACC_file_buffer,fs_ACC);
                PPG_raw_buffer = zeros(size(ACC_raw_buffer));
                PPG_t_msec = ACC_t_msec;
                PPG_t_datetime = ACC_t_datetime;

                PPG_Samsung_HR = zeros(size(ACC_raw_buffer));
            else
                disp('both PPG and ACC are empty.');
%                     keyboard; 

                PPG_raw_buffer = zeros((fs_PPG * 30),1);
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));

                PPG_t_msec = zeros(size(PPG_raw_buffer));
                ACC_t_msec = zeros(size(PPG_raw_buffer));

                PPG_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
                ACC_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');

                PPG_Samsung_HR = zeros(size(ACC_raw_buffer));
            end
        end
        % interpolate ACC based on its timestamp:
%             [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime] = my_func_interpolate_watch_data(ACC_file_buffer,fs_PPG);

%             ACC_timestamp = ACC_file_buffer(:,1);
%             ACC_raw_buffer = ACC_file_buffer(:,2);

        % --- Only for UID 119A, watch was idle. 12/16/2021 ---
        % 1st PPG file datetime: 01/01/2018, 10:49:53.432 AM.
        % ECG start time: 08/03/2021, 09:04 AM.
        % 1st PPG file name: 08/03/2021, 10:49:51 AM.
        if strcmp(PPG_file_name(1:3),'119')
            formatOut = 'yyyy';
            PPG_year_this = datestr(PPG_t_datetime(1),formatOut); % Get the PPG year of the first cell in the array.
            if strcmp(PPG_year_this,'2018')
                PPG_wrong_datetime = datetime(['01/01/2018'],'InputFormat','MM/dd/yyyy','TimeZone','America/New_York');
                ECG_right_datetime = datetime(['08/03/2021'],'InputFormat','MM/dd/yyyy','TimeZone','America/New_York');

                PPG_add_sec = seconds(ECG_right_datetime - PPG_wrong_datetime);
                PPG_t_datetime = PPG_t_datetime + seconds(PPG_add_sec);
                ACC_t_datetime = ACC_t_datetime + seconds(PPG_add_sec);
            end
        end
        
        % === Added 06/28/2020: ====
        % Get segment index 0000:
        PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
        if strcmp(PPG_4_dig_str,'0000')
            % it is segment 0000:
            % Worked: Plan 1: test cut first few seconds:
            cut_sec = 2;
            PPG_raw_buffer = PPG_raw_buffer(cut_sec*fs_PPG+1:end,1);
            PPG_t_msec = PPG_t_msec(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime = PPG_t_datetime(cut_sec*fs_PPG+1:end,1);
            PPG_file_buffer = PPG_file_buffer(cut_sec*fs_PPG+1:end,:);
            PPG_Samsung_HR = PPG_Samsung_HR(cut_sec*fs_PPG+1:end,1);
            % Plan 2: replace first two seconds with 
    %         PPG_raw_buffer = [ones(cut_sec*fs_PPG,1) * PPG_raw_buffer(cut_sec*fs_PPG+1);PPG_raw_buffer(cut_sec*fs_PPG+1:end,1)];

        else
    %         % I only want to replot all seg 0000 now.
    %         continue
        end
    % === end of Added 06/28/2020 ===
        PPG_timestamp_start = PPG_t_datetime(1,1);
        PPG_timestamp_end = PPG_t_datetime(end,1);
        % check file name time lapse vs timestamp lapse:
        % file name time lapse is in PPG_struct;

        %     if ii > 1
                % I didn't use these variables. 09/01/2020.
        %         file_name_lapse(ii,1) = PPG_struct(ii-1).PPG_dur;
        %         PPG_timestamp_lapse(ii,1) = milliseconds(PPG_timestamp_start(ii,1) - PPG_timestamp_start(ii-1,1)); % same as file name lapse.
        %         for_ECG_timestamp(ii,1) = milliseconds(PPG_timestamp_start(ii,1) - PPG_timestamp_end(ii-1,1)); % for ECG start index interpolation.

        %     end
        if ~isempty(PPG_file_buffer)
            temp_HR_file_buffer = [PPG_file_buffer(:,1),PPG_Samsung_HR];
            [SamsungHR_buffer,SamsungHR_t_msec,SamsungHR_t_datetime] = my_func_interpolate_watch_data(temp_HR_file_buffer,fs_PPG);
        else
                if ~isempty(ACC_file_buffer)
                    SamsungHR_t_msec = ACC_t_msec;
                    SamsungHR_t_datetime = ACC_t_datetime;

                    SamsungHR_buffer = zeros(size(ACC_raw_buffer));

                    % I put the cutting inside the empty PPG because I cut
                    % the PPG_file_buffer if PPG txt is not empty.
                    % === Added 06/28/2020: ====
                    % Get segment index 0000:
                    PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
                    if strcmp(PPG_4_dig_str,'0000')
                        % it is segment 0000:
                        % Worked: Plan 1: test cut first few seconds:
                        cut_sec = 2;
                        SamsungHR_buffer = SamsungHR_buffer(cut_sec*fs_PPG+1:end,1);
                        SamsungHR_t_msec = SamsungHR_t_msec(cut_sec*fs_PPG+1:end,1);
                        SamsungHR_t_datetime = SamsungHR_t_datetime(cut_sec*fs_PPG+1:end,1);
                        % Plan 2: replace first two seconds with 
                %         PPG_raw_buffer = [ones(cut_sec*fs_PPG,1) * PPG_raw_buffer(cut_sec*fs_PPG+1);PPG_raw_buffer(cut_sec*fs_PPG+1:end,1)];

                    else
                %         % I only want to replot all seg 0000 now.
                %         continue
                    end
                    % === end of Added 06/28/2020 ===

                else
                    disp('both PPG and ACC are empty.');
    %                     keyboard; 
                    SamsungHR_buffer = zeros(size(ACC_raw_buffer));
                    SamsungHR_t_msec = zeros(size(ACC_raw_buffer));
                    SamsungHR_t_datetime = zeros(size(ACC_raw_buffer));
                end

        end
        PPG_t_msec_ver_2 = []; % For ver 2.0.1 testing. 03/02/2021.
        PPG_t_datetime_ver_2 = [];
        ACC_t_msec_ver_2 = [];
        ACC_t_datetime_ver_2 = [];
    elseif (strcmp(m_API_ver{1,1},'2.0.1') || strcmp(m_API_ver{2,1},'2.0.1')) && ~strcmp(m_service_var{1,1},'2.1.1')
        % Get the initial recording time for PPG, it was hand-copied
            % from the 1st segment of the entire recording.
        [PPG_timestamp_ver_2_start_datetime,...
            PPG_timestamp_ver_2_start_msec,...
            ACC_timestamp_ver_2_start_datetime,...
            ACC_timestamp_ver_2_start_msec] = my_func_ver_2_timestamp_start_datetime(UID);
        if ~isempty(PPG_file_buffer) % PPG txt file is empty.
            flag_ACC = false; % this input is PPG data.
            [PPG_raw_buffer,PPG_t_msec,PPG_t_datetime,...
                PPG_t_msec_ver_2,...
                PPG_t_datetime_ver_2,...
                PPG_timestamp_ver_2_raw] = my_func_interpolate_watch_data(PPG_file_buffer,fs_PPG,...
                flag_ACC,...
                PPG_timestamp_ver_2_start_datetime,...
                PPG_timestamp_ver_2_start_msec);

            PPG_Samsung_HR = PPG_file_buffer(:,3); % get Samsung HR.

            if ~isempty(ACC_file_buffer) && size(ACC_file_buffer,2) > 1 % Cassey: 054_2020_10_10_13_02_59_ppg_0001, ACC file does not exits.
                flag_ACC = true; % this input is ACC data.
                [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime,...
                    ACC_t_msec_ver_2,...
                    ACC_t_datetime_ver_2,...
                    ACC_timestamp_ver_2_raw] = my_func_interpolate_watch_data(ACC_file_buffer,fs_ACC,...
                    flag_ACC,...
                    ACC_timestamp_ver_2_start_datetime,...
                    ACC_timestamp_ver_2_start_msec);
            else
                % ACC file does not exist.
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));
                ACC_t_msec = PPG_t_msec;
                ACC_t_datetime = PPG_t_datetime;
            end
        else
            if ~isempty(ACC_file_buffer)
                flag_ACC = true; % this input is ACC data.
                [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime,...
                    ACC_t_msec_ver_2,...
                    ACC_t_datetime_ver_2,...
                    ACC_timestamp_ver_2_raw] = my_func_interpolate_watch_data(ACC_file_buffer,fs_ACC,...
                    flag_ACC,...
                    ACC_timestamp_ver_2_start_datetime,...
                    ACC_timestamp_ver_2_start_msec);                
                PPG_raw_buffer = zeros(size(ACC_raw_buffer));
                PPG_t_msec = ACC_t_msec;
                PPG_t_datetime = ACC_t_datetime;

                PPG_Samsung_HR = zeros(size(ACC_raw_buffer));
            else
                disp('both PPG and ACC are empty.');

                PPG_raw_buffer = zeros((fs_PPG * 30),1);
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));

                PPG_t_msec = zeros(size(PPG_raw_buffer));
                ACC_t_msec = zeros(size(PPG_raw_buffer));

                PPG_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
                ACC_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');

                PPG_Samsung_HR = zeros(size(ACC_raw_buffer));
            end
        end

        PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
        if strcmp(PPG_4_dig_str,'0000')
            % it is segment 0000:
            % Worked: Plan 1: test cut first few seconds:
            cut_sec = 2;
            PPG_raw_buffer = PPG_raw_buffer(cut_sec*fs_PPG+1:end,1);
            PPG_t_msec = PPG_t_msec(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime = PPG_t_datetime(cut_sec*fs_PPG+1:end,1);
            PPG_file_buffer = PPG_file_buffer(cut_sec*fs_PPG+1:end,:);
            PPG_Samsung_HR = PPG_Samsung_HR(cut_sec*fs_PPG+1:end,1);
            
            PPG_t_msec_ver_2 = PPG_t_msec_ver_2(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime_ver_2 = PPG_t_datetime_ver_2(cut_sec*fs_PPG+1:end,1);
        else
            
        end
        PPG_timestamp_start = PPG_t_datetime(1,1);
        PPG_timestamp_end = PPG_t_datetime(end,1);
        % check file name time lapse vs timestamp lapse:
        % file name time lapse is in PPG_struct;
        if ~isempty(PPG_file_buffer)
%             temp_HR_file_buffer = [PPG_file_buffer(:,1),PPG_Samsung_HR];
            temp_HR_file_buffer = [PPG_file_buffer(:,4),PPG_Samsung_HR]; % 4th column is the old timestamp.
            [SamsungHR_buffer,SamsungHR_t_msec,SamsungHR_t_datetime] = my_func_interpolate_watch_data(temp_HR_file_buffer,fs_PPG);
        else
            if ~isempty(ACC_file_buffer)
                SamsungHR_t_msec = ACC_t_msec;
                SamsungHR_t_datetime = ACC_t_datetime;

                SamsungHR_buffer = zeros(size(ACC_raw_buffer));

                PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
                if strcmp(PPG_4_dig_str,'0000')
                    % it is segment 0000:
                    % Worked: Plan 1: test cut first few seconds:
                    cut_sec = 2;
                    SamsungHR_buffer = SamsungHR_buffer(cut_sec*fs_PPG+1:end,1);
                    SamsungHR_t_msec = SamsungHR_t_msec(cut_sec*fs_PPG+1:end,1);
                    SamsungHR_t_datetime = SamsungHR_t_datetime(cut_sec*fs_PPG+1:end,1);
                end

            else
                disp('both PPG and ACC are empty.');
                SamsungHR_buffer = zeros(size(ACC_raw_buffer));
                SamsungHR_t_msec = zeros(size(ACC_raw_buffer));
                SamsungHR_t_datetime = zeros(size(ACC_raw_buffer));
            end
        end
    elseif (strcmp(m_API_ver{1,1},'2.0.1') && strcmp(m_service_var{1,1},'2.1.1')) || (strcmp(m_API_ver{1,1},'2.0.2') && strcmp(m_service_var{1,1},'2.1.1'))% Another column for different PPG timestamp.

        if ~isempty(PPG_file_buffer) % PPG txt file is empty.
            flag_ACC = false; % this input is PPG data.
            [PPG_raw_buffer,PPG_t_msec,PPG_t_datetime,...
                    PPG_t_msec_ver_2,PPG_t_datetime_ver_2,...
                    PPG_timestamp_ver_2_raw] = my_func_interpolate_watch_data_2_1_1(PPG_file_buffer,fs_PPG,...
                    flag_ACC);

            PPG_Samsung_HR = PPG_file_buffer(:,3); % get Samsung HR.

            if ~isempty(ACC_file_buffer) && size(ACC_file_buffer,2) > 1 % Cassey: 054_2020_10_10_13_02_59_ppg_0001, ACC file does not exits.
                flag_ACC = true; % this input is ACC data.
                
                [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime,...
                    ACC_t_msec_ver_2,ACC_t_datetime_ver_2,...
                    ACC_timestamp_ver_2_raw] = my_func_interpolate_watch_data_2_1_1(ACC_file_buffer,fs_ACC,...
                    flag_ACC);

            else
                % ACC file does not exist.
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));
                ACC_t_msec = PPG_t_msec;
                ACC_t_datetime = PPG_t_datetime;
            end
        else
            if ~isempty(ACC_file_buffer)
                flag_ACC = true; % this input is ACC data.
                [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime,...
                    ACC_t_msec_ver_2,ACC_t_datetime_ver_2,...
                    ACC_timestamp_ver_2_raw] = my_func_interpolate_watch_data_2_1_1(ACC_file_buffer,fs_ACC,...
                    flag_ACC);            
                PPG_raw_buffer = zeros(size(ACC_raw_buffer));
                PPG_t_msec = ACC_t_msec;
                PPG_t_datetime = ACC_t_datetime;

                PPG_Samsung_HR = zeros(size(ACC_raw_buffer));
            else
                disp('both PPG and ACC are empty.');

                PPG_raw_buffer = zeros((fs_PPG * 30),1);
                ACC_raw_buffer = zeros(size(PPG_raw_buffer));

                PPG_t_msec = zeros(size(PPG_raw_buffer));
                ACC_t_msec = zeros(size(PPG_raw_buffer));

                PPG_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');
                ACC_t_datetime = NaT(size(PPG_raw_buffer,1),1,'TimeZone','America/New_York');

                PPG_Samsung_HR = zeros(size(ACC_raw_buffer));
            end
        end

        PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
        if strcmp(PPG_4_dig_str,'0000')
            % it is segment 0000:
            % Worked: Plan 1: test cut first few seconds:
            cut_sec = 2;
            PPG_raw_buffer = PPG_raw_buffer(cut_sec*fs_PPG+1:end,1);
            PPG_t_msec = PPG_t_msec(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime = PPG_t_datetime(cut_sec*fs_PPG+1:end,1);
            PPG_file_buffer = PPG_file_buffer(cut_sec*fs_PPG+1:end,:);
            PPG_Samsung_HR = PPG_Samsung_HR(cut_sec*fs_PPG+1:end,1);
            
            PPG_t_msec_ver_2 = PPG_t_msec_ver_2(cut_sec*fs_PPG+1:end,1);
            PPG_t_datetime_ver_2 = PPG_t_datetime_ver_2(cut_sec*fs_PPG+1:end,1);
        else
            
        end
        PPG_timestamp_start = PPG_t_datetime(1,1);
        PPG_timestamp_end = PPG_t_datetime(end,1);
        % check file name time lapse vs timestamp lapse:
        % file name time lapse is in PPG_struct;
        if ~isempty(PPG_file_buffer)
%             temp_HR_file_buffer = [PPG_file_buffer(:,1),PPG_Samsung_HR];
            temp_HR_file_buffer = [PPG_file_buffer(:,4),PPG_Samsung_HR]; % 4th column is the old timestamp.
            [SamsungHR_buffer,SamsungHR_t_msec,SamsungHR_t_datetime] = my_func_interpolate_watch_data(temp_HR_file_buffer,fs_PPG);
        else
            if ~isempty(ACC_file_buffer)
                SamsungHR_t_msec = ACC_t_msec;
                SamsungHR_t_datetime = ACC_t_datetime;

                SamsungHR_buffer = zeros(size(ACC_raw_buffer));

                PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
                if strcmp(PPG_4_dig_str,'0000')
                    % it is segment 0000:
                    % Worked: Plan 1: test cut first few seconds:
                    cut_sec = 2;
                    SamsungHR_buffer = SamsungHR_buffer(cut_sec*fs_PPG+1:end,1);
                    SamsungHR_t_msec = SamsungHR_t_msec(cut_sec*fs_PPG+1:end,1);
                    SamsungHR_t_datetime = SamsungHR_t_datetime(cut_sec*fs_PPG+1:end,1);
                end

            else
                disp('both PPG and ACC are empty.');
                SamsungHR_buffer = zeros(size(ACC_raw_buffer));
                SamsungHR_t_msec = zeros(size(ACC_raw_buffer));
                SamsungHR_t_datetime = zeros(size(ACC_raw_buffer));
            end
        end
        
    elseif strcmp(m_API_ver{1,1},'2.1.3')
        PPG_raw_buffer = PPG_file_buffer(:,2);
        ACC_raw_buffer = ACC_file_buffer(:,2);
        PPG_t_msec = [];
        PPG_t_datetime = [];
        ACC_t_msec = [];
        ACC_t_datetime = [];
        SamsungHR_buffer = [];
        SamsungHR_t_msec = [];
        SamsungHR_t_datetime = [];
        PPG_timestamp_start = [];
        PPG_timestamp_end = [];
        add_1_day_flag = [];
        PPG_t_msec_ver_2 = [];
        PPG_t_datetime_ver_2 = [];
        ACC_t_msec_ver_2 = [];
        ACC_t_datetime_ver_2 = [];
        PPG_timestamp_ver_2_raw = [];
        ACC_timestamp_ver_2_raw = [];
    else
        % unknown API version occurred.
        disp('unknown API occurred!');
        keyboard;
    end
    
    if ~exist('ACC_timestamp_ver_2_raw','var')
        PPG_timestamp_ver_2_raw = [];
        ACC_timestamp_ver_2_raw = [];
    end
end