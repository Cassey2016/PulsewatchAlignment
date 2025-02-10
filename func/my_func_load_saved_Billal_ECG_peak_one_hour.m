function [ECG_raw_all_data,...
    ECG_Billal_filt_all_data,...
    ECG_Billal_peak_all_data,...
    ECG_Billal_HR_all_data,...
    ECG_time_all_data,...
    start_ECG_hour_idx,...
    end_ECG_hour_idx,...
    start_ECG_point_idx,...
    end_ECG_point_idx,...
    my_suggest_time_shift] = my_func_load_saved_Billal_ECG_peak_one_hour(PPG_start_time,...
                            PPG_end_time,...
                            each_ECG_start_time,...
                            each_ECG_end_time,...
                            show_ECG_min_left,...
                            show_ECG_min_right,...
                            output_ECG_file_name,...
                            ECG_path,...
                            fs_ECG,...
                            ECG_init_datetime,...
                            Patch_ECG_Billal_Peak_1_hr_path,...
                            Billal_one_hour_file_name,...
                            LinearInterp_path)
                        
% --- know the starting ECG hour for PPG start: ---
start_ECG_hour_idx = []; % the hour segment idx.
end_ECG_hour_idx = []; % the hour segment idx.
start_ECG_point_idx = []; % the point idx inside one hour.
end_ECG_point_idx = []; % the point idx inside one hour.

% ---  know the starting ECG hour for extended the left and right look time: ---
start_ECG_hour_left_idx = []; % the hour segment idx.
end_ECG_hour_right_idx = []; % the hour segment idx.
start_ECG_point_left_idx = []; % the point idx inside one hour.
end_ECG_point_right_idx = []; % the point idx inside one hour.

my_suggest_time_shift = NaN; % Storing the potential time shift we need to make.
for jj = 1:size(each_ECG_start_time,1)
    curr_ECG_start_time = each_ECG_start_time(jj,1);
    curr_ECG_end_time = each_ECG_end_time(jj,1);
    % --- PPG start time: ---
    temp_check_time = PPG_start_time;
    if curr_ECG_start_time <= temp_check_time && curr_ECG_end_time >= temp_check_time
        exact_ECG_seg = jj;%str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % {'314_001.mat'}

        load([ECG_path,filesep,output_ECG_file_name{jj,1}]); % Data col 1 is time.
        load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]); % "precise_time_linear": load the linear interpolated time.
        temp_t = precise_time_linear(:,1);%Data(:,1);
        temp_t_datetime = seconds(temp_t) + ECG_init_datetime;
        [~,I] = min(abs(temp_t_datetime - temp_check_time)); % first exact ECG start point.
        exact_ECG_pt = I;

        % Dong 05/27/2022: I am calculating the time shift from ideal timestamp
        % vs. the precise timestamp.
        if exact_ECG_pt > size(Data,1)
            % For UID 022, seg 5760.
            exact_ECG_pt = size(Data,1);
        end
        start_ECG_hour_idx = exact_ECG_seg;
        start_ECG_point_idx = exact_ECG_pt;
        
        ideal_time = Data(exact_ECG_pt,1);
        precise_time = precise_time_linear(exact_ECG_pt,1);
        my_suggest_time_shift = ideal_time - precise_time; % Unit is second.
    end

    % --- PPG end time: ---
    temp_check_time = PPG_end_time;
    if curr_ECG_start_time <= temp_check_time && curr_ECG_end_time >= temp_check_time
        exact_ECG_seg = jj;%str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % {'314_001.mat'}

        load([ECG_path,filesep,output_ECG_file_name{jj,1}]); % Data col 1 is time.
        load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]); % "precise_time_linear": load the linear interpolated time.
        temp_t = precise_time_linear(:,1);%Data(:,1);
        temp_t_datetime = seconds(temp_t) + ECG_init_datetime;
        [~,I] = min(abs(temp_t_datetime - temp_check_time)); % first exact ECG start point.
        exact_ECG_pt = I;

        end_ECG_hour_idx = exact_ECG_seg;
        end_ECG_point_idx = exact_ECG_pt;
    end
    % --- PPG extend left start time: ---
    temp_check_time = PPG_start_time - minutes(show_ECG_min_left);
    if curr_ECG_start_time <= temp_check_time && curr_ECG_end_time >= temp_check_time
        exact_ECG_seg = jj;%str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % {'314_001.mat'}

        load([ECG_path,filesep,output_ECG_file_name{jj,1}]); % Data col 1 is time.
        load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]); % "precise_time_linear": load the linear interpolated time.
        temp_t = precise_time_linear(:,1);%Data(:,1);
        temp_t_datetime = seconds(temp_t) + ECG_init_datetime;
        [~,I] = min(abs(temp_t_datetime - temp_check_time)); % first exact ECG start point.
        exact_ECG_pt = I;

        start_ECG_hour_left_idx = exact_ECG_seg;
        start_ECG_point_left_idx = exact_ECG_pt;
    end
    % --- PPG extend right end time: ---
    temp_check_time = PPG_end_time + minutes(show_ECG_min_right);
    if curr_ECG_start_time <= temp_check_time && curr_ECG_end_time >= temp_check_time
        exact_ECG_seg = jj;%str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % {'314_001.mat'}

        load([ECG_path,filesep,output_ECG_file_name{jj,1}]); % Data col 1 is time.
        load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]); % "precise_time_linear": load the linear interpolated time.
        temp_t = precise_time_linear(:,1);%Data(:,1);
        temp_t_datetime = seconds(temp_t) + ECG_init_datetime;
        [~,I] = min(abs(temp_t_datetime - temp_check_time)); % first exact ECG start point.
        exact_ECG_pt = I;
        
        if exact_ECG_pt > size(Data,1)
            % For UID 022, seg 5749.
            exact_ECG_pt = size(Data,1);
        end
        end_ECG_hour_right_idx = exact_ECG_seg;
        end_ECG_point_right_idx = exact_ECG_pt;
    end
end
% concatenate all ECG hours, and return.
if isempty(start_ECG_hour_left_idx) 
    % looking left is far too left, it is beyond the ECG start time.
    start_ECG_hour_left_idx = 1; % first hour of ECG.
    start_ECG_point_left_idx = 1; % first point of ECG.
end

if isempty(end_ECG_hour_right_idx)
    % looking left is far too left, it is beyond the ECG start time.
    end_ECG_hour_right_idx = size(each_ECG_start_time,1); % first hour of ECG.
    load([ECG_path,filesep,output_ECG_file_name{size(each_ECG_start_time,1),1}]); % Data col 1 is time.
    load([LinearInterp_path,filesep,output_ECG_file_name{size(each_ECG_start_time,1),1}]);
    end_ECG_point_right_idx = size(Data,1); % the size of the last hour of ECG.
    if size(Data,1) > size(precise_time_linear,1)
        end_ECG_point_right_idx =  size(precise_time_linear,1); % For UID 027, seg 18882. 08/15/2022.
    end
end
all_ECG_hour_idx = [start_ECG_hour_left_idx:end_ECG_hour_right_idx];
all_ECG_hour_idx = all_ECG_hour_idx(:);
ECG_raw_all_data = NaN(fs_ECG*50*3600,1); % initial a 50-hour buffer.
ECG_Billal_filt_all_data = NaN(fs_ECG*50*3600,1); % initial a 50-hour buffer.
ECG_Billal_peak_all_data = NaN(fs_ECG*50*3600,1); % initial a 50-hour buffer.
ECG_Billal_HR_all_data = NaN(fs_ECG*50*3600,1); % initial a 50-hour buffer.
ECG_time_all_data = NaN(fs_ECG*50*3600,1); % initial a 50-hour buffer.

start_idx_raw = 1;
end_idx_raw = [];
start_idx_peak = 1;
end_idx_peak = [];
start_idx_HR = 1;
end_idx_HR = [];


for jj = all_ECG_hour_idx(1):all_ECG_hour_idx(end)
    % load raw ECG and ECG time.
    load([ECG_path,filesep,output_ECG_file_name{jj,1}]); % Data col 1 is time.
    load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]); % "precise_time_linear": load the linear interpolated time.
    
    if jj == all_ECG_hour_idx(1)
        temp_start_idx = start_ECG_point_left_idx;
    else
        temp_start_idx = 1;
    end
    if jj == all_ECG_hour_idx(end)
        temp_end_idx = end_ECG_point_right_idx;
    else
        temp_end_idx = size(Data,1);
    end

%     temp_time = precise_time_linear(temp_start_idx:temp_end_idx,1);%Data(temp_start_idx:temp_end_idx,1);
    temp_raw_ECG = Data(temp_start_idx:temp_end_idx,2);
    
    % load Billal's processed ECG one hour.
    load([Patch_ECG_Billal_Peak_1_hr_path,filesep,Billal_one_hour_file_name{jj,1}]);
    
    % first, check if Billal's one hour ECG has same size as raw ECG.
    if size(Data,1) ~= size(ECG_time_1_hr_this,1) || size(Data,1) ~= size(Billal_ECG_filt_1_hr_this,1)
        disp('Billal''s ECG has different size of raw ECG, check!');
        if size(Data,1) > size(Billal_ECG_filt_1_hr_this,1)
            % For AF trial 301, since there is only 1 hour of data,O
            % Billal's ECG is only 300,000 samples long, but the raw ECG
            % data is 300,466 samples long.
            
            % I was planning to reduce the size of Data, but it seems that
            % we did not return Data.
            temp_rm_idx = any(isnan(Data),2);
%             keyboard; % Cassey 05/10/2022: only need this for debugging
%             purpose. Cassey comment out on 08/13/2022 for 013A seg 8123.
            if size(temp_rm_idx,1) > size(precise_time_linear,1)
                temp = temp_rm_idx(1:size(precise_time_linear,1));
                precise_time_linear(temp,:) = [];
            else
                precise_time_linear(temp_rm_idx,:) = []; % Cassey 05/10/2022: remove NaN for timestamp as well? Please debug and check!
            end
            Data(temp_rm_idx,:) = []; % remove all the rows that contains NaN data.
            if size(Data,1) ~= size(Billal_ECG_filt_1_hr_this,1)
                % UID 012, 14367, Data forgot to remove NaN rows. But after
                % removal NaN rows, Data and Billal ECG has same length.
%                 keyboard;
            end
            temp_end_idx = size(Billal_ECG_filt_1_hr_this,1); % the end of the index has to change to the shorter one.
            if temp_end_idx > size(precise_time_linear,1) % Added on 08/15/2022, for UID 020B.
                temp_end_idx = size(precise_time_linear,1); 
            end
            % Has to reset the loading of temp_raw_ECG.
%             temp_time = precise_time_linear(temp_start_idx:temp_end_idx,1);%Data(temp_start_idx:temp_end_idx,1);
            temp_raw_ECG = Data(temp_start_idx:temp_end_idx,2);
        else
            keyboard;
        end
    end
    temp_time_Billal = precise_time_linear(temp_start_idx:temp_end_idx,1);%ECG_time_1_hr_this(temp_start_idx:temp_end_idx,1);

%     if ~isequal(temp_time,temp_time_Billal)
%         disp('Billal''s time is different with raw ECG''time, check!');
%         keyboard;
%     end
    temp_Billal_ECG_filt = Billal_ECG_filt_1_hr_this(temp_start_idx:temp_end_idx,1);
    temp_idx = find(Billal_ECG_peak_1_hr_this >= temp_start_idx & Billal_ECG_peak_1_hr_this <= temp_end_idx);
    if isempty(temp_idx) || length(temp_idx) < 2
        end_idx_raw = start_idx_raw + size(temp_raw_ECG,1) - 1;
        ECG_time_all_data(start_idx_raw:end_idx_raw,1) = temp_time_Billal;
        ECG_raw_all_data(start_idx_raw:end_idx_raw,1) = temp_raw_ECG;
        ECG_Billal_filt_all_data(start_idx_raw:end_idx_raw,1) = temp_Billal_ECG_filt;
        
        start_idx_raw = end_idx_raw + 1;
        
        % There is no ECG peak, so no updates to peak or HR.
    else % There is at least one ECG peak.
        temp_Billal_ECG_peak = Billal_ECG_peak_1_hr_this(temp_idx,1);
        temp_Billal_ECG_HR = Billal_ECG_HR_1_hr_this(temp_idx(1:end-1),1); % HR array len is one element smaller than peak.

        end_idx_raw = start_idx_raw + size(temp_raw_ECG,1) - 1;
        ECG_time_all_data(start_idx_raw:end_idx_raw,1) = temp_time_Billal;
        ECG_raw_all_data(start_idx_raw:end_idx_raw,1) = temp_raw_ECG;
        ECG_Billal_filt_all_data(start_idx_raw:end_idx_raw,1) = temp_Billal_ECG_filt;

        end_idx_peak = start_idx_peak + size(temp_Billal_ECG_peak,1) - 1;
        ECG_Billal_peak_all_data(start_idx_peak:end_idx_peak,1) = temp_Billal_ECG_peak - temp_start_idx + start_idx_raw;
        end_idx_HR = start_idx_HR + size(temp_Billal_ECG_HR,1) - 1;
        ECG_Billal_HR_all_data(start_idx_HR:end_idx_HR,1) = temp_Billal_ECG_HR;

        start_idx_raw = end_idx_raw + 1;
        start_idx_peak = end_idx_peak + 1;
        start_idx_HR = end_idx_HR + 1;
    end
end
ECG_raw_all_data(isnan(ECG_raw_all_data)) = [];
ECG_Billal_filt_all_data(isnan(ECG_Billal_filt_all_data)) = [];
ECG_Billal_peak_all_data(isnan(ECG_Billal_peak_all_data)) = [];
ECG_Billal_HR_all_data(isnan(ECG_Billal_HR_all_data)) = [];
ECG_time_all_data(isnan(ECG_time_all_data)) = [];
end
