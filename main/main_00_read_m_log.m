% This main function is to read log txt file for 'm_'.
% Should be compatible 
% Dong, 08/15/2020.
% 10/19/2020: copied from: R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Watch_On_Time_Processing\interpretable_time\main_03_read_m_log.m
clear all;
close all;
clc;

if ~exist('wrapper_script_flag','var')
    clear all;
    close all;
    clc;
    
    wrapper_script_flag = false;
    HPC_flag = false;
    data_source_path = [];
end

addpath(['..',filesep,'path']); % For the path func.
[root_data_path,...
    root_code_path,...
    root_output_path,...
    output_path_PPG_peak_det] = my_pathdef(HPC_flag);
addpath('..\func');

%% Copied from R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Watch_On_Time_Processing\Test_API_1_0_14\main_step02_load_watch_data.m
my_plot_flag = false;
fs_PPG = 50;
fs_ACC = 50;
    
%% Output folder:
mat_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Interpretable_Time\API_1_0_15_value'];
% for uu = 15:20%1:size(UID_list,1) % looping subjects.
UID = my_func_user_select_UID(wrapper_script_flag);
test_PPG_path = my_func_UID_watch_data_final_path(UID,HPC_flag,root_data_path);

%     output_struct_path = 'R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\MATLAB_output_files';
%     Fahimeh_alignment_output_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\MATLAB_output_files'];
%% For this subject: Load all PPG file name that need to be run:
[All_PPG_file_name,Fahimeh_alignment_output_path] = my_func_load_ppg_txt(test_PPG_path,UID,HPC_flag,root_data_path);
ACC_for_All_PPG_file_name = my_func_load_acc_txt_after_ppg(All_PPG_file_name,...
    test_PPG_path,...
    Fahimeh_alignment_output_path,...
    UID);
%% Looping all PPG files:
% first_PPG_seg = input('start seg: '); % 239 is the start of flapping of PPG.
first_PPG_seg = 1; % Start from the first segment always.
fprintf('Number of all PPG files: %d',size(All_PPG_file_name,1));
%     first_PPG_seg = 1;
for ii = first_PPG_seg:size(All_PPG_file_name,1)

    PPG_file_name = All_PPG_file_name{ii,1};
    ACC_file_name = ACC_for_All_PPG_file_name{ii,1};%strcat(PPG_file_name(1:24),'accel',PPG_file_name(28:end));
    PPG_file_buffer = importdata([test_PPG_path,'\',PPG_file_name]); % col1: time, col2: PPG, col3: Samsung HR.
    if isempty(ACC_file_name)
        % no paired ACC file, so give zero.
        ACC_file_buffer = zeros(30 * fs_ACC,1);
    else
        ACC_file_buffer = importdata([test_PPG_path,'\',ACC_file_name]);
    end
    % interpolate PPG based on its timestamp:
%     [PPG_raw_buffer,PPG_t_msec,PPG_t_datetime] = my_interp_watch_data_1_0_14(PPG_file_buffer,fs_PPG,UID);
    if isempty(PPG_file_buffer)
        % there is no data in this txt file.
        PPG_raw_buffer = zeros(30 * fs_PPG,1);
        PPG_empty_flag(ii,1) =  true; % PPG is empty.
    else
        PPG_raw_buffer = PPG_file_buffer(:,1); % clinical trial so far only have one column.
        PPG_empty_flag(ii,1) =  false; % PPG is not empty.
    end

    if my_plot_flag
        t_plot_PPG = (1:length(PPG_raw_buffer))./fs_PPG; % t is only for plotting.
        t_plot_PPG = t_plot_PPG(:); % make sure it is a column vector.
    end
%     % interpolate ACC based on its timestamp:
%     [ACC_raw_buffer,ACC_t_msec,ACC_t_datetime] = my_interp_watch_data_1_0_14(ACC_file_buffer,fs_PPG,UID);
    if isempty(ACC_file_buffer)
        ACC_raw_buffer = zeros(30 * fs_ACC,1);
    else
        ACC_raw_buffer = ACC_file_buffer(:,1);
    end

    % === Added 06/28/2020: ====
    % Get segment index 0000:
    PPG_4_dig_str = PPG_file_name(29:32); % 916_2020_06_06_00_12_24_ppg_0000.txt
    if strcmp(PPG_4_dig_str,'0000')
        % it is segment 0000:
        % Worked: Plan 1: test cut first few seconds:
        cut_sec = 2;
        PPG_raw_buffer = PPG_raw_buffer(cut_sec*fs_PPG+1:end,1);
        if my_plot_flag
            t_plot_PPG = t_plot_PPG(cut_sec*fs_PPG+1:end,1);
        end
%         PPG_t_msec = PPG_t_msec(cut_sec*fs_PPG+1:end,1);
%         PPG_t_datetime = PPG_t_datetime(cut_sec*fs_ACC+1:end,1);
        % Plan 2: replace first two seconds with 
%         PPG_raw_buffer = [ones(cut_sec*fs_PPG,1) * PPG_raw_buffer(cut_sec*fs_PPG+1);PPG_raw_buffer(cut_sec*fs_PPG+1:end,1)];

    else
%         % I only want to replot all seg 0000 now.
%         continue
    end
    % === end of Added 06/28/2020 ===

    %% check log file exists:
    log_file_empty = false; % indicate if log file is empty.
    curr_log_name = PPG_file_name(1:23); % 916_2020_06_06_00_12_24_ppg_0000.txt
    fprintf('%s: log txt - start %d / %d segments, log: %s ... \n', UID, ii, size(All_PPG_file_name,1),curr_log_name);
    if ii == 9979
       my_stop = 1; 
    end
%     if ii == 1
%         % this is the first ppg segment in this subject.
%        prev_log_name = curr_log_name;
%        % inital 5-min AF decision.
%     else
%         if strcmp(prev_log_name,curr_log_name)
%            % still within same log file. 
%            % so continue.
%            continue;
%            % so we will not execute remaining part of code.
%         else
%             % new log file.
%             prev_log_name = curr_log_name; % update the log file name.
%         end
%     end
    curr_log_file_name = [curr_log_name,'_log.txt']; % 002_2019_08_08_16_12_22_log.txt
    temp_file_name = [test_PPG_path,'\',curr_log_file_name];

    if isfile(temp_file_name)
        % log file exists:
        log_file_empty = false;

        [m_output_struct,m_API_ver,m_service_var,m_time,m_time_idx] = my_func_log_txt_read(temp_file_name);

    else
        % log file does not exists:
        % 045_2020_08_24_12_11_20_log.txt_temp_88
        temp_folder_path = [test_PPG_path,'\*',curr_log_name,'_log*']; % visit all files have this time + 'log' file.
        log_file_listing = dir(temp_folder_path);
        log_file_temp = cell(size(log_file_listing,1),1);
        for ttttt = 1:size(log_file_listing,1)
            log_file_temp{ttttt,1} = log_file_listing(ttttt).name;
        end
        if isempty(log_file_temp)
            % there is really no such log file exists!
            log_file_empty = true;
        else
            if size(log_file_temp,1) == 1
                temp_file_name = [test_PPG_path,'\',log_file_temp{1,1}];
    %                 importdata();
                log_file_empty = false;
                [m_output_struct,m_API_ver,m_service_var,m_time,m_time_idx] = my_func_log_txt_read(temp_file_name);
            else
                disp('There are more than one log file for this time!');
               keyboard; 
            end
        end
    end
    %% Finished this PPG segment: 
    if ~log_file_empty % log file exists.
        my_table_file_name = strcat(curr_log_name,'_m_log.mat');
        myFolderName_new = strcat(mat_path,'\m_log\',UID);
        mysavefilename = strcat(myFolderName_new,'\',my_table_file_name);
        if exist(myFolderName_new, 'dir')

        else
            mkdir(myFolderName_new);
        end
        save(mysavefilename,...
            'm_output_struct',...
            'm_API_ver',...
            'm_service_var',...
            'm_time',...
            'm_time_idx');
    end % end of this PPG file.
end
% end
% === End of Added 06/24/2020 ======