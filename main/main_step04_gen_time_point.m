% Process to align ECG and PPG:
% 1. PPG timestamp as universal time;
% 2. ECG timestamp as universal time;
% 3. every new 30 sec PPG segment, check with ECG universal time. Move ECG
% time with PPG starting time.

% From R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Final_Alignment_Output\005\005_2019_09_17_02_00_00_ppg_0000_align_output.mat
% align_output:
% T_1_ECG_patch_name
% T_2_ECG_one_hr_idx
% T_3_ECG_start_idx
% T_4_ECG_end_idx
% T_5_last_modify_time
% T_6_last_modify_person
% T_7_last_base_point_PPG_file
%
%

% Will have two plotting methods,
% 1. plot all PPG within the same ECG hours; (priority)
% 2. plot every 30-sec PPG as before with ECG;

% Revised 09/02/2020, for compatible with API version 1.0.11 & 1.0.13.
clear all;
close all;
clc;

% =========================================================================
% --- know watch UID. If you do not have it before txt file name, use
% Powershell to rename your txt file into '9XX_*' three digit UID name. ---
% =========================================================================
addpath('..\func');
UID = my_func_user_select_UID(false);
% my_holter_flag = false; % I am using Holter monitor for testing.
fs_PPG = 50;
fs_ACC = 50;
% =========================================================================
% --- The purpose of knowing UID is to know the path to load PPG data: ---
% =========================================================================
my_plot_flag = false;

% if my_holter_flag
% % test_PPG_path =  'R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Watch_Data\916'; % folder where exported mat file located.
% % test_PPG_path = 'R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Watch_Data\916_2nd\916'; % 2nd time experiment.
%     test_PPG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_new_watch_UI_1_0_0\phone_data\',UID,'\Pulsewatch\Done'];
% else
    % use clinical trial path:
    test_PPG_path = my_func_UID_watch_data_final_path(UID,false,[]);
% end
% =========================================================================
% --- Load watch txt file names: -----------------------------------------
% =========================================================================
fprintf('Loading all PPG txt for %s watch data...',UID);
[All_PPG_file_name,txt_file_list_path] = my_func_load_ppg_txt(test_PPG_path,UID,false); % use this version of PPG loading. 09/01/2020
disp('Finished!');
fprintf('Loading all paired ACC txt for %s watch data...',UID);
ACC_for_All_PPG_file_name = my_func_load_acc_txt_after_ppg(All_PPG_file_name,...
    test_PPG_path,...
    txt_file_list_path,...
    UID); % make sure long file name ACC will be loaded.
disp('Finished!');
% =========================================================================
% --- Know which ECG patch and ECG start time -----------------------------
% =========================================================================
% if my_holter_flag % using Holter ECG, not patch.
%     % ECG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Ref_ECG\OneHour'];
%     % ECG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Ref_ECG\OneHour_2nd\final'];
%     test_ECG_path_A = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_new_watch_UI_1_0_0\Ref_ECG\OneHour'];
%     if strcmp(UID,'913')
%         Patch_A_start_time = ['10/11/2020 15:40:00.944'];
%     elseif strcmp(UID,'916')
%         Patch_A_start_time = ['10/11/2020 15:40:02.538'];
%     end
%     test_ECG_path_B = [];
%     Patch_B_start_time = [];
% else
    [test_ECG_path_A,...
        Patch_A_start_time,...
        test_ECG_path_B,...
        Patch_B_start_time,...
        test_ECG_path_C,...
        Patch_C_start_time] = my_func_UID_ECG_final_path(UID,false);
% end

if strcmp(UID(1,1),'9')
    % uconn testing patient, using holter monitor.
    fs_ECG = 180;
else
    % Patch ECG sampling frequency.
    fs_ECG = 250;
end

PPG_timestamp_start = NaT(1,1,'TimeZone','America/New_York'); % the starting timestamp in each 30-sec seg.
PPG_timestamp_end = NaT(1,1,'TimeZone','America/New_York'); % the starting timestamp in each 30-sec seg.
big_align_output = [];
%% output folder path:
align_output_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Final_Alignment_Output','\',num2str(UID)];
time_aim23_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Watch_API_1_0_15\Time_Aim23','\',UID];

% --- end of added 09/01/2020 ---
count_prev_log_PPG_seg = 0; % to match with log file PPG segment number.
count_all_ppg_seg = 0;
first_seg_seg = input('Starting Index?: \n');%1277; % 279 has an error in 2nd 916. 1212 is empty. 4127 has an error about ECG. % 239 is the start of flapping of PPG.
end_seg_idx = size(All_PPG_file_name,1);
beginning_of_ii = [];
prev_ECG_path = []; % previous ECG path.
each_ECG_start_time = []; % init var.
each_ECG_end_time = [];% init var.
output_ECG_file_name = [];% init var.
ECG_init_datetime = [];% init var.
for ii = first_seg_seg:end_seg_idx
    PPG_file_name = All_PPG_file_name{ii,1};
    ACC_file_name = ACC_for_All_PPG_file_name{ii,1};
    PPG_file_buffer = importdata([test_PPG_path,'\',PPG_file_name]); % col1: time, col2: PPG, col3: Samsung HR.
    if isempty(ACC_file_name)
        % no paired ACC file, so give zero.
        ACC_file_buffer = [];
    else
        ACC_file_buffer = importdata([test_PPG_path,'\',ACC_file_name]);
    end

% =========================================================================
% --- Display Segment Info ------------------------------------------------
% =========================================================================
    fprintf('--- ECG start & end point %d/%d: ---\n%s...\n',ii,end_seg_idx,PPG_file_name);
% =========================================================================
% --- Load PPG, ACC, Samsung HR data from PPG and ACC file name -----------
% =========================================================================
    m_log_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Interpretable_Time\API_1_0_15_value\m_log\',UID];
    t_start = tic;
    [PPG_raw_buffer,...
        PPG_t_msec,...
        PPG_t_datetime,...
        ACC_raw_buffer,...
        ACC_t_msec,...
        ACC_t_datetime,...
        SamsungHR_buffer,...
        SamsungHR_t_msec,...
        SamsungHR_t_datetime,...
        PPG_timestamp_start,...
        PPG_timestamp_end] = my_func_prep_watch_PPG_ACC(PPG_file_buffer,...
                                                            ACC_file_buffer,...
                                                            fs_PPG,...
                                                            fs_ACC,...
                                                            PPG_file_name,...
                                                            m_log_path,...
                                                            time_aim23_path,...
                                                            UID);
    t_end = toc(t_start);
    fprintf('prep time: %.1f sec\n',t_end);

    addpath('..\fine_tune_alignment\func');
    [align_output,...
        prev_ECG_path,...
        beginning_of_ii,...
        each_ECG_start_time,...
        each_ECG_end_time,...
        output_ECG_file_name,...
        ECG_init_datetime] = my_func_gen_ECG_time_point_from_PPG_timestamp(PPG_timestamp_start,...
                                                    PPG_timestamp_end,...
                                                    test_ECG_path_A,...
                                                    Patch_A_start_time,...
                                                    test_ECG_path_B,...
                                                    Patch_B_start_time,...
                                                    test_ECG_path_C,...
                                                    Patch_C_start_time,...
                                                    fs_ECG,...
                                                    fs_PPG,...
                                                    beginning_of_ii,...
                                                    prev_ECG_path,...
                                                    ii,...
                                                    each_ECG_start_time,...
                                                    each_ECG_end_time,...
                                                    output_ECG_file_name,...
                                                    ECG_init_datetime);

    big_align_output = [big_align_output;align_output];
    
    myFolderName = align_output_path;
    if exist(myFolderName, 'dir') % I like to automatically check if this folder exist, so I never need to waste time creating folders before running code.
    else
        mkdir(myFolderName);
    end
    final_output_file_name = [align_output_path,'\',PPG_file_name(1:32),'_align_output.mat'];
    save(final_output_file_name,'align_output');
                
    fprintf('finished %d / %d segments \n', ii, size(All_PPG_file_name,1));
end
big_table_folder = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Test_new_watch_UI_1_0_0'];
if ~exist(big_table_folder,'dir')
   mkdir(big_table_folder); 
end
big_table_file_name = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Test_new_watch_UI_1_0_0','\',num2str(UID),'_align_output_big_table.mat'];
save(big_table_file_name,'big_align_output'); % save the big aligned output table.