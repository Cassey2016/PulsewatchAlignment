function [ECG_raw_data,ECG_time] = my_func_load_ECG_segment(align_output,...
                                                ECG_path,...
                                                UID,...
                                                my_holter_flag)
% reference code: R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Offline_Processing\IEEE_Access_Results\main_wRespRate_API_98segpeakdet.m
    T_1_ECG_patch_name = align_output.T_1_ECG_patch_name;
%     T_1_ECG_patch_name = [UID]; % I typed the wrong patch name.
    T_2_ECG_one_hr_idx = align_output.T_2_ECG_one_hr_idx;
    T_3_ECG_start_idx = align_output.T_3_ECG_start_idx;
    T_4_ECG_end_idx = align_output.T_4_ECG_end_idx;
    T_5_last_modify_time = align_output.T_5_last_modify_time;
    T_6_last_modify_person = align_output.T_6_last_modify_person;
    T_7_last_base_point_PPG_file = align_output.T_7_last_base_point_PPG_file;
    T_8_ECG_contain_empty = align_output.T_8_ECG_contain_empty; % whether ECG is partly empty.
    T_9_pad_zero_front = align_output.T_9_pad_zero_front; % add zero at the beginning.
    T_10_pad_zero_end = align_output.T_10_pad_zero_end; % add zero at the ending. (if ECG duration is less than 30 sec for that segment, this could happen)
    fs_ECG = align_output.T_11_fs_ECG; % fs_ECG
    
    % 1. check if ECG is all empty or partly empty:
    if T_8_ECG_contain_empty
       % not enough ECG, zero at beginning or end;
       % 2. Check if zero occurs at beginning or end, or both.
       if T_9_pad_zero_front && T_10_pad_zero_end
           % Both beginning and end has zero value.
           
           % 3. Check if entire ECG is empty.
           if isnan(T_3_ECG_start_idx) && isnan(T_4_ECG_end_idx)
               ECG_raw_data = []; % I will give empty to warn
               ECG_time = [];
               return;
           else
               disp('Both beginning and end are zero but there is non nan index, check!');
               keyboard;
           end
       else
           % Either beginning or end has zero padding:
           if ~isnan(T_3_ECG_start_idx) && ~isnan(T_4_ECG_end_idx)
               % decide how many zeros we need to add:
               remain_len = fs_ECG * 30 - (T_4_ECG_end_idx - T_3_ECG_start_idx + 1); % one length longer.
               add_zero = zeros(remain_len,1);
               % load ECG portions.
               ECG_seg_idx = align_output.T_2_ECG_one_hr_idx(1);
               if my_holter_flag
                    ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               else
                   if strcmp(T_1_ECG_patch_name(1:1),'3')
                       % this is AF trial ECG patch:
                       ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   else
                       ECG_file_name = strcat(ECG_path,'/','Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   end
               end
               load(ECG_file_name); % loaded variable: Data.
               ECG_start_idx = T_3_ECG_start_idx;
               ECG_end_idx = T_4_ECG_end_idx;
               ECG_raw_data = Data(ECG_start_idx:ECG_end_idx,2);
               ECG_time = Data(ECG_start_idx:ECG_end_idx,1);
               % even sampling interpolation:
               [ECG_time,ECG_raw_data] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG);
               if T_9_pad_zero_front
                   % add zero at the beggining
                   ECG_raw_data = [add_zero;ECG_raw_data];
                   add_t = (-remain_len:1:-1)./fs_ECG + ECG_time(1); % trace back ECG time, it will most likely to be negative time.
                   add_t = add_t(:); % make sure it is column vector.
                   ECG_time = [add_t;ECG_time];
                   return;
               elseif T_10_pad_zero_end
                   % add zero at the ending
                   ECG_raw_data = [ECG_raw_data;add_zero];
                   add_t = ECG_time(end) + (1:remain_len)./fs_ECG; % trace back ECG time, it will most likely to be negative time.
                   add_t = add_t(:); % make sure it is column vector.
                   ECG_time = [ECG_time;add_t];
                   return;
               else
                   % both start and end need zero padding:
                   disp('Both beginning and end are zero, check!');
                   keyboard;
               end
               
               
               % give time
           else
               % both the start and end idx are zero, check
               disp('Both start and end idx are zero, check!');
               keyboard;
           end
       end
    else
        % 2. ECG does not contain any empty part:
        if T_9_pad_zero_front || T_10_pad_zero_end
            % To be safe, I will check if I need to put zero in the front and
            % end:
            disp('Not empty but has zero front or end, check!');
            keyboard; 
        end
        
        % 3. check if spans two ECG segments
        % overspan two segments;
        if T_4_ECG_end_idx < T_3_ECG_start_idx
            % spans two ECG segments:
            % this segment override two ECG 1-hr segments;
            ECG_seg_idx = align_output.T_2_ECG_one_hr_idx;
           if my_holter_flag
                ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
           else
               if strcmp(T_1_ECG_patch_name(1:1),'3')
                   % this is AF trial ECG patch:
                   ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               else
                   ECG_file_name = strcat(ECG_path,'/','Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               end
           end
            load(ECG_file_name); % loaded variable: Data.
            size_of_ECG_1 = size(Data,1);
            ECG_start_idx = T_3_ECG_start_idx;
            ECG_end_idx = T_4_ECG_end_idx;
            ECG_clip_1 = Data(ECG_start_idx:size_of_ECG_1,2);
            ECG_clip_1_time = Data(ECG_start_idx:size_of_ECG_1,1);

            ECG_seg_idx = ECG_seg_idx + 1;
           if my_holter_flag
                ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
           else
               if strcmp(T_1_ECG_patch_name(1:1),'3')
                   % this is AF trial ECG patch:
                   ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               else
                   ECG_file_name = strcat(ECG_path,'/','Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               end
           end
           load(ECG_file_name); % loaded variable: Data.
            size_of_ECG_2 = size(Data,1);
            ECG_clip_2 = Data(1:ECG_end_idx,2);
            ECG_clip_2_time = Data(1:ECG_end_idx,1);

            ECG_raw_data = [ECG_clip_1;ECG_clip_2];
            ECG_time = [ECG_clip_1_time;ECG_clip_2_time];

            fprintf('ECG override two segments, seg idx %d and %d. \n',ECG_seg_idx - 1,ECG_seg_idx);
            % even sampling interpolation:
            [ECG_time,ECG_raw_data] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG);
            return;
        else
            % within the same ECG segments:
            ECG_seg_idx = align_output.T_2_ECG_one_hr_idx(1);
           if my_holter_flag
                ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
           else
               if strcmp(T_1_ECG_patch_name(1:1),'3')
                   % this is AF trial ECG patch:
                   ECG_file_name = strcat(ECG_path,'/',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               else
                   ECG_file_name = strcat(ECG_path,'/','Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
               end
           end
            load(ECG_file_name); % loaded variable: Data.
            ECG_start_idx = T_3_ECG_start_idx;
            ECG_end_idx = T_4_ECG_end_idx;
            ECG_raw_data = Data(ECG_start_idx:ECG_end_idx,2);
            ECG_time = Data(ECG_start_idx:ECG_end_idx,1);
            % even sampling interpolation:
            [ECG_time,ECG_raw_data] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG);
            return;
        end
        % ECG length is not perfectly 30 * fs.
    end

end
