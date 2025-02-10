function [UID,fs_PPG,fs_ACC,fs_ECG,...
    test_PPG_path,...
    All_PPG_file_name,...
    ACC_for_All_PPG_file_name,...
    new_5_min_PPG_idx] = my_func_module_load_filename_info()

if ~exist('wrapper_script_flag','var')
    clear all;
    close all;
    clc;
    
    wrapper_script_flag = false;
    HPC_flag = false;
end

%% Know UID, paths:
UID = my_func_user_select_UID(wrapper_script_flag);
fs_PPG = 50;
fs_ACC = 50;
my_holter_flag = false;
my_clinical_trial_flag = false;
if strcmp(UID(1,1),'9')
    % uconn testing patient, using holter monitor.
    fs_ECG = 180;
    my_holter_flag = true;
else
    % Patch ECG sampling frequency.
    fs_ECG = 250;
end

test_PPG_path = my_func_UID_watch_data_final_path(UID,HPC_flag); % know watch txt file path.

fprintf('Loading all PPG txt for %s watch data...',UID);
[All_PPG_file_name,txt_file_list_path] = my_func_load_ppg_txt(test_PPG_path,UID,HPC_flag); % use this version of PPG loading. 09/01/2020
disp('Finished!');
fprintf('Loading all paired ACC txt for %s watch data...',UID);
ACC_for_All_PPG_file_name = my_func_load_acc_txt_after_ppg(All_PPG_file_name,...
    test_PPG_path,...
    txt_file_list_path,...
    UID); % make sure long file name ACC will be loaded.
disp('Finished!');

%% Load number of 5-min period:
fprintf('Checking how many 5-min sensor-on stage...');
addpath('.\func');
[new_5_min_PPG_idx] = my_func_check_new_5_min(All_PPG_file_name,...
    ACC_for_All_PPG_file_name);
fprintf(' %d 5-min sensor-on stage!\n',size(new_5_min_PPG_idx,1));

end