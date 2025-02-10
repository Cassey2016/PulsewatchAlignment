function [ECG_raw_data_interp,...
    ECG_time_interp,...
    ECG_Billal_filt_interp,...
    ECG_Billal_peak_interp,...
    ECG_Billal_HR,...
    precise_time_linear_interp,...
    Data_interp,...
    Billal_ECG_peak_1_hr_this_interp,...
    Billal_ECG_filt_1_hr_this] = my_func_load_ECG_segment_Billal_saved_one_hour(varargin)
                                            
                                            
final_align_output = varargin{1};
ECG_path = varargin{2};
UID = varargin{3};
my_holter_flag = varargin{4};
Patch_ECG_Billal_Peak_1_hr_path = varargin{5};
LinearInterp_root = varargin{6};

if size(varargin,2) > 6 % varargin is a 1xN cell.
    % I have special use for this function for generating big table for UMass.
    flag_UMass_big_table = varargin{7}; % It should be true.
else
    flag_UMass_big_table = false;
end
% reference code: R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Offline_Processing\IEEE_Access_Results\main_wRespRate_API_98segpeakdet.m
    T_1_ECG_patch_name = final_align_output.T_1_ECG_patch_name;
%     T_1_ECG_patch_name = [UID]; % I typed the wrong patch name.
    T_2_ECG_one_hr_idx = final_align_output.T_2_ECG_one_hr_idx;
    T_3_ECG_start_idx = final_align_output.T_3_ECG_start_idx;
    T_4_ECG_end_idx = final_align_output.T_4_ECG_end_idx;
    T_5_last_modify_time = final_align_output.T_5_last_modify_time;
    T_6_last_modify_person = final_align_output.T_6_last_modify_person;
    T_7_last_base_point_PPG_file = final_align_output.T_7_last_base_point_PPG_file;
    T_8_ECG_contain_empty = final_align_output.T_8_ECG_contain_empty; % whether ECG is partly empty.
    T_9_pad_zero_front = final_align_output.T_9_pad_zero_front; % add zero at the beginning.
    T_10_pad_zero_end = final_align_output.T_10_pad_zero_end; % add zero at the ending. (if ECG duration is less than 30 sec for that segment, this could happen)
    fs_ECG = final_align_output.T_11_fs_ECG; % fs_ECG
    
    % 1. check if ECG is all empty or partly empty:
    if T_8_ECG_contain_empty
       % not enough ECG, zero at beginning or end;
       % 2. Check if zero occurs at beginning or end, or both.
       if T_9_pad_zero_front && T_10_pad_zero_end
           % Both beginning and end has zero value.
           
           % 3. Check if entire ECG is empty.
           if isnan(T_3_ECG_start_idx) && isnan(T_4_ECG_end_idx)
               ECG_raw_data_interp = []; % I will give empty to warn
               ECG_time_interp = [];
               ECG_Billal_filt_interp = [];
               ECG_Billal_peak_interp = [];
               ECG_Billal_HR = [];
               return;
           else
               disp('Both beginning and end are zero but there is non nan index, check!');
%                keyboard; % UID 021, PPG idx 1697. 
               ECG_raw_data_interp = []; % I will give empty to warn
               ECG_time_interp = [];
               ECG_Billal_filt_interp = [];
               ECG_Billal_peak_interp = [];
               ECG_Billal_HR = [];
               return;
           end
       else
           % Either beginning or end has zero padding:
           if ~isnan(T_3_ECG_start_idx) && ~isnan(T_4_ECG_end_idx)
               % decide how many zeros we need to add:
               remain_len = fs_ECG * 30 - (T_4_ECG_end_idx - T_3_ECG_start_idx + 1); % one length longer.
               add_zero = zeros(remain_len,1);
               % load ECG portions.
               ECG_seg_idx = final_align_output.T_2_ECG_one_hr_idx(1);
               if my_holter_flag
%                 ECG_file_name = strcat(ECG_path,'\',UID,'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                    ECG_file_name = strcat(ECG_path,filesep,'914_2021042601','_',num2str(ECG_seg_idx,'%03d'),'.mat');
                    ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',UID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
               else
                   if strcmp(T_1_ECG_patch_name{1}(1:1),'3') || strcmp(T_1_ECG_patch_name{1}(1:1),'4')
                       % this is AF trial ECG patch:
                       ECG_file_name = strcat(ECG_path,filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                       ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                       LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
                   else
                       ECG_file_name = strcat(ECG_path,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                       ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                       LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
                   end
               end
               load(ECG_file_name); % loaded variable: Data.
               load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
               load(LinearInterp_file_name); % loaded: precise_time_linear
               ECG_start_idx = T_3_ECG_start_idx;
               ECG_end_idx = T_4_ECG_end_idx;
               ECG_raw_data = Data(ECG_start_idx:ECG_end_idx,2);
               ECG_time = precise_time_linear(ECG_start_idx:ECG_end_idx,1);%Data(ECG_start_idx:ECG_end_idx,1);
               % even sampling interpolation:
%                               keyboard; 05/12/2022.
               [ECG_time_interp,ECG_raw_data_interp] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG);
               
               % I won't check the interpolation again on ECG Billal's
               % data, because I have interpolated them while generating
               % them. 01/01/2021.
               % I have to map the ECG peaks to interpolated ECG.
               % 05/12/2022
               [precise_time_linear_interp,Data_interp] = my_func_ECG_interpolation(precise_time_linear,Data(:,2),fs_ECG);
               [Billal_ECG_peak_1_hr_this_interp] = my_func_ECG_interp_Billal_peak(Billal_ECG_peak_1_hr_this,...
                                                        precise_time_linear_interp,...
                                                        fs_ECG,...
                                                        precise_time_linear);
               
               if ECG_start_idx > size(Billal_ECG_filt_1_hr_this,1) || ECG_end_idx > size(Billal_ECG_filt_1_hr_this,1)
                   % UID 012, seg 14412.
                   ECG_raw_data_interp = []; % I will give empty to warn
                   ECG_time_interp = [];
                   ECG_Billal_filt_interp = [];
                   ECG_Billal_peak_interp = [];
                   ECG_Billal_HR = [];
                   return;
               end
               
               temp = find((precise_time_linear_interp - ECG_time(1)) > 0);
               ECG_start_idx_new = temp(1); % Dong, 11/18/2022: subtract sample is different after interpolation.
               
               ECG_Billal_filt = Billal_ECG_filt_1_hr_this(ECG_start_idx:ECG_end_idx,1);
               ECG_Billal_peak_interp = Billal_ECG_peak_1_hr_this_interp(find(Billal_ECG_peak_1_hr_this >= ECG_start_idx & Billal_ECG_peak_1_hr_this <= ECG_end_idx),1);
               ECG_Billal_peak_interp = ECG_Billal_peak_interp - ECG_start_idx_new + 1; % absolute loc for this 30-sec seg.
               
               [~,ECG_Billal_filt_interp] = my_func_ECG_interpolation(ECG_time,ECG_Billal_filt,fs_ECG);
               if isempty(ECG_Billal_peak_interp)
                   ECG_Billal_HR = 0;
               else
                   ECG_Billal_HR = 60 ./ (diff(ECG_Billal_peak_interp) ./ fs_ECG);
               end
               if T_9_pad_zero_front
                   % add zero at the beggining
                   ECG_raw_data_interp = [add_zero;ECG_raw_data_interp];
                   add_t = (-remain_len:1:-1)./fs_ECG + ECG_time_interp(1); % trace back ECG time, it will most likely to be negative time.
                   add_t = add_t(:); % make sure it is column vector.
                   ECG_time_interp = [add_t;ECG_time_interp];
                   ECG_Billal_filt_interp = [add_zero;ECG_Billal_filt_interp];
                   ECG_Billal_peak_interp = ECG_Billal_peak_interp + size(add_zero,1);
                   % HR does not need to be updated.
                   % Dong, 10/10/2022: on UID 003, seg 3065:
                   remove_flag = (ECG_Billal_peak_interp > size(ECG_Billal_filt_interp,1));
                   if any(remove_flag)
                       % After interpolation, the length of ECG is same as 7500
                       % samples. But the peak det could have peaks longer than
                       % 7500 due to previously elongated ECG.
                       % 10/11/2022.
                       remove_idx = find(remove_flag);
                       ECG_Billal_peak_interp(remove_idx) = [];
                   end
                   return;
               elseif T_10_pad_zero_end
                   % add zero at the ending
                   ECG_raw_data_interp = [ECG_raw_data_interp;add_zero];
                   add_t = ECG_time_interp(end) + (1:remain_len)./fs_ECG; % trace back ECG time, it will most likely to be negative time.
                   add_t = add_t(:); % make sure it is column vector.
                   ECG_time_interp = [ECG_time_interp;add_t];
                   ECG_Billal_filt_interp = [ECG_Billal_filt_interp;add_zero];
                   % ECG_Billal_peak does not need to be updated.
                   
                   % Dong, 10/10/2022: on UID 003, seg 3065:
                   remove_flag = (ECG_Billal_peak_interp > size(ECG_Billal_filt_interp,1));
                   if any(remove_flag)
                       % After interpolation, the length of ECG is same as 7500
                       % samples. But the peak det could have peaks longer than
                       % 7500 due to previously elongated ECG.
                       % 10/11/2022.
                       remove_idx = find(remove_flag);
                       ECG_Billal_peak_interp(remove_idx) = [];
                   end
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
            ECG_seg_idx = final_align_output.T_2_ECG_one_hr_idx;
           if my_holter_flag
%                 ECG_file_name = strcat(ECG_path,'\',UID,'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                ECG_file_name = strcat(ECG_path,filesep,'914_2021042601','_',num2str(ECG_seg_idx,'%03d'),'.mat');
                ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',UID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
           else
               if strcmp(T_1_ECG_patch_name{1}(1:1),'3') || strcmp(T_1_ECG_patch_name{1}(1:1),'4')
                   % this is AF trial ECG patch:
                   ECG_file_name = strcat(ECG_path,filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                   LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
               else
                   ECG_file_name = strcat(ECG_path,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                   LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
               end
           end
            load(ECG_file_name); % loaded variable: Data.
            load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
            load(LinearInterp_file_name); % loaded: precise_time_linear
            size_of_ECG_1 = size(Data,1);
            ECG_start_idx = T_3_ECG_start_idx;
            ECG_end_idx = T_4_ECG_end_idx;

            ECG_clip_1 = Data(ECG_start_idx:size_of_ECG_1,2);
            ECG_clip_1_time = precise_time_linear(ECG_start_idx:size_of_ECG_1,1);%Data(ECG_start_idx:size_of_ECG_1,1);
            ECG_clip_1_Billal_filt = Billal_ECG_filt_1_hr_this(ECG_start_idx:size_of_ECG_1,1);
            ECG_clip_1_Billal_peak = Billal_ECG_peak_1_hr_this(find(Billal_ECG_peak_1_hr_this >= ECG_start_idx & Billal_ECG_peak_1_hr_this <= size_of_ECG_1),1);
            ECG_clip_1_Billal_peak = ECG_clip_1_Billal_peak - ECG_start_idx + 1;
            ECG_seg_idx = ECG_seg_idx + 1;
            
            precise_time_linear_1 = precise_time_linear;
            Data_1 = Data;
            
           if my_holter_flag
%                 ECG_file_name = strcat(ECG_path,'\',UID,'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                ECG_file_name = strcat(ECG_path,filesep,'914_2021042601','_',num2str(ECG_seg_idx,'%03d'),'.mat');
                ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',UID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
           else
               if strcmp(T_1_ECG_patch_name{1}(1:1),'3') || strcmp(T_1_ECG_patch_name{1}(1:1),'4')
                   % this is AF trial ECG patch:
                   ECG_file_name = strcat(ECG_path,filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                   LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
               else
                   ECG_file_name = strcat(ECG_path,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                   LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
               end
           end
           load(ECG_file_name); % loaded variable: Data.
           load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
           load(LinearInterp_file_name); % loaded: precise_time_linear
           % Dong, 08/23/2022: check the second ECG if same size.
           if size(precise_time_linear,1) < size(Data,1)
               % Raw ECG is longer than linear interpolated time.
               Data = Data(1:size(precise_time_linear,1),:);
               Billal_ECG_filt_1_hr_this = Billal_ECG_filt_1_hr_this(1:size(precise_time_linear,1),1);
               ECG_time_1_hr_this = ECG_time_1_hr_this(1:size(precise_time_linear,1),1);
               rm_idx = find(Billal_ECG_peak_1_hr_this > size(precise_time_linear,1));
               Billal_ECG_peak_1_hr_this(rm_idx) = [];
               Billal_ECG_HR_1_hr_this(rm_idx-1) = [];
           elseif size(precise_time_linear,1) > size(Data,1)
               % Linear interpolated time is longer than raw ECG.
               % UID 022, seg 5428.
               precise_time_linear = precise_time_linear(1:size(Data,1),:);
           end
           
            size_of_ECG_2 = size(Data,1);
            if ECG_end_idx > size_of_ECG_2
               disp('The end idx is greater than second ECG 1-hour size, check!');
               keyboard;
            end

            ECG_clip_2 = Data(1:ECG_end_idx,2);
            ECG_clip_2_time = precise_time_linear(1:ECG_end_idx,1);%Data(1:ECG_end_idx,1);
            ECG_clip_2_Billal_filt = Billal_ECG_filt_1_hr_this(1:ECG_end_idx,1);
            ECG_clip_2_Billal_peak = Billal_ECG_peak_1_hr_this(find(Billal_ECG_peak_1_hr_this >= 1 & Billal_ECG_peak_1_hr_this <= ECG_end_idx),1);
            
            precise_time_linear_2 = precise_time_linear;
            precise_time_linear = [precise_time_linear_1;precise_time_linear_2];
            Data_2 = Data;
            Data = [Data_1;Data_2];
            
            ECG_raw_data = [ECG_clip_1;ECG_clip_2];
            ECG_time = [ECG_clip_1_time;ECG_clip_2_time];
               
            fprintf('ECG override two segments, seg idx %d and %d. \n',ECG_seg_idx - 1,ECG_seg_idx);
            % even sampling interpolation:
%                            keyboard;
            [ECG_time_interp,ECG_raw_data_interp] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG);
            
               % I won't check the interpolation again on ECG Billal's
               % data, because I have interpolated them while generating
               % them. 01/01/2021.
               % I have to map the ECG peaks to interpolated ECG.
               % 05/12/2022

            
            ECG_Billal_filt = [ECG_clip_1_Billal_filt;ECG_clip_2_Billal_filt];
            ECG_Billal_peak = [ECG_clip_1_Billal_peak;ECG_clip_2_Billal_peak + size(ECG_clip_1,1)]; % remember to check this peak location issue.
            
            [precise_time_linear_interp,Data_interp] = my_func_ECG_interpolation(precise_time_linear,Data(:,2),fs_ECG);
            [ECG_Billal_peak_interp] = my_func_ECG_interp_Billal_peak(ECG_Billal_peak,...
                                                        precise_time_linear_interp,...
                                                        fs_ECG,...
                                                        precise_time_linear);
            % Dong, 11/18/2022: it looks like I do not need to adjust the
            % ECG peak in this if case. Maybe I need to debug it in the
            % future.
                                                    % Check
                                                    % this line
            [~,ECG_Billal_filt_interp] = my_func_ECG_interpolation(ECG_time,ECG_Billal_filt,fs_ECG);
           % Dong, 10/10/2022: on UID 003, seg 3065:
           remove_flag = (ECG_Billal_peak_interp > size(ECG_Billal_filt_interp,1));
           if any(remove_flag)
               % After interpolation, the length of ECG is same as 7500
               % samples. But the peak det could have peaks longer than
               % 7500 due to previously elongated ECG.
               % 10/11/2022.
               remove_idx = find(remove_flag);
               ECG_Billal_peak_interp(remove_idx) = [];
           end
               
            if isempty(ECG_Billal_peak_interp)
                ECG_Billal_HR = 0;
            else
                ECG_Billal_HR = 60 ./ (diff(ECG_Billal_peak) ./ fs_ECG);
            end
            return;
        else
            % within the same ECG segments:
            ECG_seg_idx = final_align_output.T_2_ECG_one_hr_idx(1);
           if my_holter_flag
%                 ECG_file_name = strcat(ECG_path,'\',UID,'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                ECG_file_name = strcat(ECG_path,filesep,'914_2021042601','_',num2str(ECG_seg_idx,'%03d'),'.mat');
                ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',UID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
           else
               fprintf('T_1_ECG_patch_name{1}: %s\n',T_1_ECG_patch_name{1});		
               if strcmp(T_1_ECG_patch_name{1}(1:1),'3') || strcmp(T_1_ECG_patch_name{1}(1:1),'4')
                   % this is AF trial ECG patch:
                   ECG_file_name = strcat(ECG_path,filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                   LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),filesep,char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
               else
                   ECG_file_name = strcat(ECG_path,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat');
                   ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',char(T_1_ECG_patch_name),'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
                   LinearInterp_file_name = strcat(LinearInterp_root,filesep,'Pulsewatch',char(T_1_ECG_patch_name),'_',num2str(ECG_seg_idx,'%03d'),'.mat'); % Similar to raw ECG file name.
               end
           end
            load(ECG_file_name); % loaded variable: Data.
            load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
            load(LinearInterp_file_name); % loaded: precise_time_linear
            ECG_start_idx = T_3_ECG_start_idx;
            ECG_end_idx = T_4_ECG_end_idx;
            if ECG_end_idx > size(Billal_ECG_filt_1_hr_this,1)
                % For UID 012 seg idx 14393.
                ECG_end_idx = size(Billal_ECG_filt_1_hr_this,1);
            end
            
           if ECG_start_idx > size(Data,1) || ECG_end_idx > size(Data,1)
               ECG_raw_data_interp = []; % I will give empty to warn
               ECG_time_interp = [];
               ECG_Billal_filt_interp = [];
               ECG_Billal_peak_interp = [];
               ECG_Billal_HR = [];
               return;
           end
               
            ECG_raw_data = Data(ECG_start_idx:ECG_end_idx,2);
            ECG_time = precise_time_linear(ECG_start_idx:ECG_end_idx,1);%Data(ECG_start_idx:ECG_end_idx,1);
            % even sampling interpolation:
%                        keyboard; 05/12/2022
           if flag_UMass_big_table
               % To speed up the table creating speed.
               ECG_time_interp = ECG_time;
               ECG_raw_data_interp = [];
               ECG_Billal_filt_interp = [];
               ECG_Billal_peak_interp = [];
               ECG_Billal_HR = [];
               return;
           else
               [ECG_time_interp,ECG_raw_data_interp] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG);

               % I won't check the interpolation again on ECG Billal's
               % data, because I have interpolated them while generating
               % them. 01/01/2021.
               [precise_time_linear_interp,Data_interp] = my_func_ECG_interpolation(precise_time_linear,Data(:,2),fs_ECG);
               [Billal_ECG_peak_1_hr_this_interp] = my_func_ECG_interp_Billal_peak(Billal_ECG_peak_1_hr_this,...
                                                                        precise_time_linear_interp,...
                                                                        fs_ECG,...
                                                                        precise_time_linear);

               temp = find((precise_time_linear_interp - ECG_time(1)) > 0);
               ECG_start_idx_new = temp(1); % Dong, 11/18/2022: subtract sample is different after interpolation.

               ECG_Billal_filt = Billal_ECG_filt_1_hr_this(ECG_start_idx:ECG_end_idx,1);
               ECG_Billal_peak_interp = Billal_ECG_peak_1_hr_this_interp(find(Billal_ECG_peak_1_hr_this >= ECG_start_idx & Billal_ECG_peak_1_hr_this <= ECG_end_idx),1); % Dong, 11/18/2022: I don't know why I should not use ECG_start_idx_new.
               ECG_Billal_peak_interp = ECG_Billal_peak_interp - ECG_start_idx_new + 1; % absolute loc for this 30-sec seg.

               [~,ECG_Billal_filt_interp] = my_func_ECG_interpolation(ECG_time,ECG_Billal_filt,fs_ECG);
               
               % Dong, 10/10/2022: on UID 003, seg 3065:
               remove_flag = (ECG_Billal_peak_interp > size(ECG_Billal_filt_interp,1));
               if any(remove_flag)
                   % After interpolation, the length of ECG is same as 7500
                   % samples. But the peak det could have peaks longer than
                   % 7500 due to previously elongated ECG.
                   % 10/11/2022.
                   remove_idx = find(remove_flag);
                   ECG_Billal_peak_interp(remove_idx) = [];
               end
               if isempty(ECG_Billal_peak_interp)
                   ECG_Billal_HR = 0;
               else
                   ECG_Billal_HR = 60 ./ (diff(ECG_Billal_peak_interp) ./ fs_ECG);
               end
               return;
           end
        end
        % ECG length is not perfectly 30 * fs.
    end

end
