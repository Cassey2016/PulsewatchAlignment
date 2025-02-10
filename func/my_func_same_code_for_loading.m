function [UID,...
    fs_PPG,...
    fs_ACC,...
    fs_ECG,...
    All_PPG_file_name,...
    ACC_for_All_PPG_file_name,...
    new_5_min_PPG_idx,...
    first_seg_idx,...
    end_seg_idx,...
    first_5min_idx,...
    end_5min_idx] = my_func_same_code_for_loading(wrapper_script_flag,HPC_flag,data_source_path)

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

    test_PPG_path = my_func_UID_watch_data_final_path(UID,HPC_flag,data_source_path); % know watch txt file path.

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
    if HPC_flag
        addpath([filesep,'home',filesep,'doh16101',filesep,'MATLAB',filesep,'Pulsewatch_alignment',filesep,'fine_tune_alignment',filesep,'func']);
    else
        addpath('.\func');
    end
    [new_5_min_PPG_idx] = my_func_check_new_5_min(All_PPG_file_name,...
        ACC_for_All_PPG_file_name);
    fprintf(' %d 5-min sensor-on stage!\n',size(new_5_min_PPG_idx,1));

    % Select starting segment
    if wrapper_script_flag
        first_seg_idx = my_input('first_seg_idx');
    else
        first_seg_idx = input(['Select clean watch seg: (max ',num2str(size(All_PPG_file_name,1)),'): \n']);
    end

    end_seg_idx = size(All_PPG_file_name,1); % default to fine-tune all PPG segment.

    while first_seg_idx > end_seg_idx
       disp('Wrong starting index, check!');
       first_seg_idx = input(['Select clean watch seg: (max ',num2str(size(All_PPG_file_name,1)),'): \n']);
    end

    fprintf('You selected 30-sec seg:       %s\n',All_PPG_file_name{first_seg_idx,1});

    % find the nearest 5-min log file before it:
    I = find((new_5_min_PPG_idx - first_seg_idx) > 0);
    near_5min = new_5_min_PPG_idx(I(1));
    first_5min_idx = I(1);
    if near_5min > first_seg_idx
       % this is the next 5-min seg:
       near_5min = new_5_min_PPG_idx(first_5min_idx-1); % load the prev 5-min seg.
       first_5min_idx = first_5min_idx-1;
    end
    end_5min_idx = size(new_5_min_PPG_idx,1);
    fprintf('The nearest start of 5-min is: %s\n',All_PPG_file_name{near_5min,1});
end