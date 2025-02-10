% This main function is to find the initial alignment point from clean PPG
% segment.
% Temporarily only for API after 1.0.14, with independent PPG time stamp.
% Dong, 09/04/2020.
% Copied from main_find_init_align_point.m
% Want to plot 5mins PPG together.
% 09/21/2020: I copied from 
% R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Reference_ECG_Processing\
% Fahimeh_07232020\ECG_Alignment\
% main_find_init_align_point_5min_cutECG.m
clear all;
close all;
clc;

if ~exist('wrapper_script_flag','var')
    clear all;
    close all;
    clc;
    
    wrapper_script_flag = false;
    HPC_flag = false;
end


addpath(['..',filesep,'..',filesep,'Pulsewatch_alignment',filesep,'path']); % For the path func.
[root_data_path,...
    root_code_path,...
    root_output_path,...
    output_path_PPG_peak_det] = my_pathdef(HPC_flag);

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>> FAHIMEH: CHANGE VARIABLES HERE 1-3/4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

num_load_next_PPG_seg = 10; % segments to load from the segment you want to load.
show_ECG_min_left = 200; % this the beginning of ECG, so keep some data if possible. I changed to 1 min 10/09/2020.
show_ECG_min_right = 200; % end of ECG, so keep more data if possible. I changed to 1 min 10/09/2020.
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>END OF FAHIMEH: CHANGE VARIABLES HERE 1-3/4 >>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
addpath('..\func'); % subfunction path.
%% 1. Patient UID:
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


% =========================================================================
% --- The purpose of knowing UID is to know the path to load PPG data: ---
% =========================================================================
test_PPG_path = my_func_UID_watch_data_final_path(UID,HPC_flag,root_data_path); % know watch txt file path.
% =========================================================================
% --- Load watch txt file names: -----------------------------------------
% =========================================================================
fprintf('Loading all PPG txt for %s watch data...',UID);
[All_PPG_file_name,txt_file_list_path] = my_func_load_ppg_txt(test_PPG_path,UID,HPC_flag,root_data_path); % use this version of PPG loading. 09/01/2020
disp('Finished!');
fprintf('Loading all paired ACC txt for %s watch data...',UID);
ACC_for_All_PPG_file_name = my_func_load_acc_txt_after_ppg(All_PPG_file_name,...
    test_PPG_path,...
    txt_file_list_path,...
    UID); % make sure long file name ACC will be loaded.
disp('Finished!');

select_your_idx = [1:size(All_PPG_file_name,1)]';
disp_table = table(select_your_idx,All_PPG_file_name);
disp(disp_table);
% this_PPG_seg = input([UID,': index of clean seg? \n']);
% first_seg_idx = 1; % default starting watch seg index.
if strcmp(UID(1,1),'0')
    my_clinical_trial_flag = true;
    first_seg_idx = input(['Select clean watch seg: (max ',num2str(size(All_PPG_file_name,1)),'): \n']);
    end_seg_idx = first_seg_idx + num_load_next_PPG_seg;%20; % select 20 segs from watch data.
elseif strcmp(UID(1),'3') || strcmp(UID(1),'4')
    first_seg_idx = input(['Select clean watch seg: (max ',num2str(size(All_PPG_file_name,1)),'): \n']);
    end_seg_idx = size(All_PPG_file_name,1);
else % unknown trial.
    first_seg_idx = input(['Select clean watch seg: (max ',num2str(size(All_PPG_file_name,1)),'): \n']);
    end_seg_idx = first_seg_idx + num_load_next_PPG_seg;%20; % select 20 segs from watch data.
end
% % load the PPG segment name. If the API version before 1.0.14, only info
% % will be in the file name or in the save timestamp from log file.
% % For now I will pretent all input PPG are from API 1.0.14 or later, so
% % there will be independent timestamp. 09/04/2020.
% this_PPG_file_name = All_PPG_file_name{this_PPG_seg,1};
% % check if PPG file is not empty, and contains independent timestamp.
% this_log_file_name = this_PPG_file_name(1:23); % 330_2020_08_12_12_53_16_ppg_0000.txt

% same_log_idx = find(contains(All_PPG_file_name,this_log_file_name));


%% Process PPG and ECG HR for alignment.
% Run my PPG peak detection algorithm:
% Run ECG peak detection algorithm:
        % create a function call my algorithm lite.
beginning_of_jjj = []; % this is for checking ECG patch.
prev_ECG_path = []; % previous ECG path.
each_ECG_start_time = []; % init var.
each_ECG_end_time = [];% init var.
output_ECG_file_name = [];% init var.
ECG_init_datetime = [];% init var.


ECG_time_5min = [];
ECG_sig_5min = [];
ECG_pkloc_5min = [];
ECG_HR_5min = [];
ECG_filt_sig_5min = [];
count_ECG_seg_size = 0;


%% ==== end onf added 10/05/2020 =====
PPG_timestamp_start = NaT(1,1,'TimeZone','America/New_York'); % the starting timestamp in each 30-sec seg.
PPG_timestamp_end = NaT(1,1,'TimeZone','America/New_York'); % the starting timestamp in each 30-sec seg.
m_log_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Interpretable_Time\API_1_0_15_value\m_log\',UID];
time_aim23_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Watch_API_1_0_15\Time_Aim23','\',UID];
% This is the new path for 5-min pre-saved period:
watch_5_min_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\watch_5min_output','\',UID];
% watch_5_min_op_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\watch_5min_output_op','\',UID];

% find the nearest 5-min log file before it:
%% Load number of 5-min period:
fprintf('Checking how many 5-min sensor-on stage...');
addpath('..\fine_tune_alignment\func');
[new_5_min_PPG_idx] = my_func_check_new_5_min(All_PPG_file_name,...
    ACC_for_All_PPG_file_name);
fprintf(' %d 5-min sensor-on stage!\n',size(new_5_min_PPG_idx,1));

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

first_seg_idx = near_5min;
PPG_file_name = All_PPG_file_name{first_seg_idx,1};
watch_5_min_file_name = [watch_5_min_path,'\',PPG_file_name(1:end-4),'_5_min.mat'];
%     watch_5_min_op_file_name = [watch_5_min_op_path,'\',PPG_file_name(1:end-4),'_5_min_op.mat'];
if exist(watch_5_min_file_name,'file')
    load(watch_5_min_file_name);
    % loaded var: 'PPG_time_5min',...
    % 'PPG_sig_5min',...
    % 'PPG_pkloc_5min',...
    % 'PPG_HR_5min',...
    % 'PPG_filt_sig_5min',...
    % 'count_PPG_seg_size',...
    % 'PPG_pkloc_5min_1',...
    % 'PPG_HR_5min_1',...
    % 'PPG_filt_sig_5min_1',...
    % 'PPG_pkloc_5min_2',...
    % 'PPG_HR_5min_2',...
    % 'PPG_filt_sig_5min_2',...
    % 'PPG_start_time',...
    % 'PPG_end_time',...
    % 'PPG_time_5min_L_array',...
    % 'PPG_time_5min_R_array',...
    % 'PPG_pkloc_5min_L_array',...
    % 'PPG_pkloc_5min_R_array',...
    % 'PPG_time_5min_1_L_array',...
    % 'PPG_time_5min_1_R_array',...
    % 'PPG_pkloc_5min_1_L_array',...
    % 'PPG_pkloc_5min_1_R_array',...
    % 'PPG_time_5min_2_L_array',...
    % 'PPG_time_5min_2_R_array',...
    % 'PPG_pkloc_5min_2_L_array',...
    % 'PPG_pkloc_5min_2_R_array',...
    % 'count_num_PPG_30sec'
    
    % --- 11/28/2021: if need to pick several sequence clean 30-sec seg: --
    chop_flag = false;
    if chop_flag
        clean_seg_idx = [7;8;9;10];
        % Chop the 5-min into several 30-sec long.
        PPG_sig_5min = PPG_sig_5min(PPG_time_5min_L_array(clean_seg_idx(1)):PPG_time_5min_R_array(clean_seg_idx(end)));
        PPG_filt_sig_5min = PPG_filt_sig_5min(PPG_time_5min_L_array(clean_seg_idx(1)):PPG_time_5min_R_array(clean_seg_idx(end)));
        PPG_time_5min = PPG_time_5min(PPG_time_5min_L_array(clean_seg_idx(1)):PPG_time_5min_R_array(clean_seg_idx(end)));

        first_pk_loc = PPG_pkloc_5min(PPG_pkloc_5min_L_array(clean_seg_idx(1)));
        PPG_pkloc_5min = PPG_pkloc_5min(PPG_pkloc_5min_L_array(clean_seg_idx(1)):PPG_pkloc_5min_R_array(clean_seg_idx(end)));
        PPG_pkloc_5min = PPG_pkloc_5min - first_pk_loc + 1; % Make sure it starts from 1.
        PPG_HR_5min = PPG_HR_5min(PPG_pkloc_5min_L_array(clean_seg_idx(1)):PPG_pkloc_5min_R_array(clean_seg_idx(end)));
        
        first_pk_idx = PPG_pkloc_5min_L_array(clean_seg_idx(1));
        PPG_pkloc_5min_L_array = PPG_pkloc_5min_L_array(clean_seg_idx);
        PPG_pkloc_5min_L_array = PPG_pkloc_5min_L_array - first_pk_idx + 1; 
        
%         first_pk_idx = PPG_pkloc_5min_R_array(clean_seg_idx(1));
        PPG_pkloc_5min_R_array = PPG_pkloc_5min_R_array(clean_seg_idx);
        PPG_pkloc_5min_R_array = PPG_pkloc_5min_R_array - first_pk_idx + 1;% Subtract the same index location?
        PPG_time_5min_L_array = PPG_time_5min_L_array(clean_seg_idx);
        PPG_time_5min_R_array = PPG_time_5min_R_array(clean_seg_idx);
    end
    
    PPG_time_5min_manual = PPG_time_5min;
    PPG_time_5min_model = PPG_time_5min;
    PPG_time_5min_xcorr = PPG_time_5min;

    manual_add_sec_array = zeros(count_num_PPG_30sec,1); % Not use NaN because one NaN will destroy all datetime.
    model_add_sec_array = zeros(count_num_PPG_30sec,1);
    xcorr_model_add_sec_array = zeros(count_num_PPG_30sec,1);
else
    disp('Haven''t save this 5-min data, check!');
    keyboard;
end
    
   
%% ========= 10/09/2020: Pull ECG running outside PPG running =========
% 3. Decide which ECG patch to load:
% ---- 10/09/2020: I moved this ECG info loading part after PPG because I want to manually adjust the ECG recording start time that UMass provided. 
[test_ECG_path_A,...
    Patch_A_start_time,...
    test_ECG_path_B,...
    Patch_B_start_time,...
    test_ECG_path_C,...
    Patch_C_start_time,...
    UMass_type] = my_func_UID_ECG_final_path(UID,HPC_flag,root_data_path);

[ECG_path,...
    ECG_Date_sting] = my_func_Cardea_SOLO_know_patch_A_B(test_ECG_path_A,...
        Patch_A_start_time,...
        test_ECG_path_B,...
        Patch_B_start_time,...
        test_ECG_path_C,...
        Patch_C_start_time,...
        PPG_start_time,...
        fs_ECG);

% check if ECG path has been changed:

jjj = first_seg_idx;
if isempty(beginning_of_jjj)
    beginning_of_jjj = jjj;
end
if jjj == beginning_of_jjj
   prev_ECG_path = ECG_path;
end

if jjj == beginning_of_jjj || ~strcmp(ECG_path,prev_ECG_path) % first time we need to initial ECG path.

    patch_start_end_time_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Each_Patch_Start_End_Time'];
    if isempty(ECG_path)
%         not_save_patch_start_end_time_flag = true; % UID 089A. 11/27/2021.
        patch_start_end_time_file_name = [];
    else
        patch_start_end_time_file_name = [patch_start_end_time_path,'\',ECG_path(end-3:end),'_patch_start_end_time.mat'];
    end

    if exist(patch_start_end_time_file_name,'file')
        load(patch_start_end_time_file_name); % to save running time.
        % check if the ECG init_datetime match our time.
        ECG_init_datetime_temp = datetime(ECG_Date_sting,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
        if ECG_init_datetime_temp ~= ECG_init_datetime
            not_save_patch_start_end_time_flag = true;
        else
            not_save_patch_start_end_time_flag = false;
        end
    else
        not_save_patch_start_end_time_flag = true;
    end
    if not_save_patch_start_end_time_flag
        disp('Switch to a new patch! One time run. It takes some time to know each 1-hr ECG start and end time...');
        t_start = tic;
        [each_ECG_start_time,...
            each_ECG_end_time,...
            output_ECG_file_name,...
            ECG_init_datetime] = my_func_know_each_ECG_start_end_time(ECG_path,...
            ECG_Date_sting);

        t_end = toc(t_start);
        fprintf('Time used to know each 1-hr ECG start and end time: %.1f sec\n',t_end);

        if ~exist(patch_start_end_time_path,'dir')
            mkdir(patch_start_end_time_path);
        end

        save(patch_start_end_time_file_name,'each_ECG_start_time',...
            'each_ECG_end_time',...
            'output_ECG_file_name',...
            'ECG_init_datetime');
    end
    prev_ECG_path = ECG_path;
    % 1. Know the duration of PPG:

    dur_PPG = PPG_end_time - PPG_start_time;
    dur_PPG = dur_PPG + minutes(show_ECG_min_left) + minutes(show_ECG_min_right); % add extended ECG duration.
    num_30_sec_ECG = ceil(seconds(dur_PPG)/fs_ECG*30); % know how many ECG segments there will be.

    PPG_start_time_init = PPG_start_time - minutes(show_ECG_min_left);
    PPG_start_time_temp = PPG_start_time_init; % first start time will be the initial time.

    if strcmp(UID(1),'3') || strcmp(UID(1),'4')
        Patch_ECG_Billal_Peak_1_hr_path = ['R:\ENGR_Chon\NIH_Pulsewatch_Database\AF_trial\Patch_ECG_Billal_Peak_1_hr','\',ECG_path(end-2:end)];
    elseif strcmp(UID(1),'9')
        Patch_ECG_Billal_Peak_1_hr_path = ['R:\ENGR_Chon\Dong\myGalaxyWatch3Database\Test_Up_Time_2_1_0\Dong_concatenated_ECG_protected','\',UID];
    else
        Patch_ECG_Billal_Peak_1_hr_path = ['R:\ENGR_Chon\NIH_Pulsewatch_Database\Patch_ECG_Billal_Peak_1_hr','\',ECG_path(end-3:end)];
    end
    % know the all 1-hour Billal ECG content:
    list = dir(Patch_ECG_Billal_Peak_1_hr_path); % for now I will let the code run the first one, later I will change to load according to PPG time. 09/03/2020.
    list = list(3:end); % first two cells are . and ..
    Billal_one_hour_file_name = cell(size(list,1),1);

    for ii = 1:size(list,1)
        Billal_one_hour_file_name{ii,1} = list(ii).name;
    end
end
[ECG_raw_all_data,...
    ECG_Billal_filt_all_data,...
    ECG_Billal_peak_all_data,...
    ECG_Billal_HR_all_data,...
    ECG_time_all_data,...
    start_ECG_hour_idx,...
    end_ECG_hour_idx,...
    start_ECG_point_idx,...
    end_ECG_point_idx] = my_func_load_saved_Billal_ECG_peak_one_hour(PPG_start_time,...
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
                            Billal_one_hour_file_name);
                        
    ECG_time_5min = ECG_time_all_data;
    ECG_sig_5min = ECG_raw_all_data;
    ECG_pkloc_5min = ECG_Billal_peak_all_data;
 
    ECG_HR_5min = 60 ./ (diff(ECG_pkloc_5min) ./ fs_ECG);
    ECG_pkloc_5min = ECG_pkloc_5min(2:end);

    ECG_filt_sig_5min = ECG_Billal_filt_all_data;
    count_ECG_seg_size = size(ECG_Billal_filt_all_data,1);
    exact_align_idx = 1;
%     for eee = 1:num_30_sec_ECG
%         fprintf('Running ECG seg %d/%d...\n',eee,num_30_sec_ECG);
%         PPG_end_time_temp = PPG_start_time_temp + seconds(30); % add another 30 second.
%         show_ECG_min_left_temp = 0; % The ECG left extend time inside loop is zero.
%         show_ECG_min_right_temp = 0; % The ECG right extend time inside loop is zero.
%         if PPG_end_time_temp > PPG_end_time
%             PPG_end_time_temp = PPG_end_time + minutes(show_ECG_min_right); % more than PPG actual ending time.
%         end
%         % 2. Load time of ECG segments:
%         % I will always leave 3 more mins before and after the recording.
% %         [ECG_Xmin_sig,...
% %             ECG_Xmin_time,...
% %             ECG_Xmin_seg_idx,...
% %             ECG_Xmin_seg_pt,...
% %             exact_align_idx] = my_func_Xmin_ECG_load_5min_left_right(PPG_start_time_temp,...
% %                                     PPG_end_time_temp,...
% %                                     each_ECG_start_time,...
% %                                     each_ECG_end_time,...
% %                                     show_ECG_min_left_temp,...
% %                                     show_ECG_min_right_temp,...
% %                                     output_ECG_file_name,...
% %                                     ECG_path,...
% %                                     fs_ECG,...
% %                                     ECG_init_datetime);
% 
%                                 
% % ------ 10/09/2020: Cut long ECG into several 30-sec long. To improve the
% % peak detection accuracy. -------
% %         addpath('R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Reference_ECG_Processing\Fahimeh_clinical_ECG_alginment'); % my_PanTopkin_ECGpeakdetection_lite
%         addpath('..\func_ECG_peak_det');
%         if ~isempty(ECG_Xmin_sig)
%             ECG_input = ECG_Xmin_sig;
%             % [Ref_ECG_buffer,refECG_pkloc,wbwrefHR] = my_PanTopkin_ECGpeakdetection_lite(ECG_input,fs_ECG);
%             [ECG_raw_data,Ref_ECG_buffer,refECG_pkloc,wbwrefHR,~] = my_func_Billal_ECG_peak_det_lite(ECG_input,ECG_Xmin_time,fs_ECG);
% 
%             ECG_time_5min = [ECG_time_5min;ECG_Xmin_time];
%             ECG_sig_5min = [ECG_sig_5min;ECG_Xmin_sig];
%             ECG_pkloc_5min = [ECG_pkloc_5min;refECG_pkloc(2:end) + count_ECG_seg_size];
%             ECG_HR_5min = [ECG_HR_5min;wbwrefHR];
%             ECG_filt_sig_5min = [ECG_filt_sig_5min;Ref_ECG_buffer];
%             count_ECG_seg_size = count_ECG_seg_size + size(ECG_input,1);
%         end
%         % end of this segment:
%         PPG_start_time_temp = PPG_end_time_temp + seconds(1/fs_ECG); % add 1 sample to data cursor. 
%     end

% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>> FAHIMEH: CHANGE VARIABLES HERE 4/4 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
manual_add_sec =0;%168%-29%%20*60;%-1*(15*60+21+0.34);
% % % % % % % % manual_add_sec = show_ECG_min_left * 60 - max_idx/temp_intp_num;
% % % % % % % % manual_add_sec = show_ECG_min_left * 60 - 77756/10;
% % % % % % % % manual_add_sec = show_ECG_min_left * 60 - 218011/10;
% manual_add_sec = -seconds(ECG_init_datetime + seconds(ECG_time_5min(1)) - PPG_time_5min(1)) - max_idx/temp_intp_num;
% manual_add_sec = -seconds(ECG_init_datetime + seconds(ECG_time_5min(1)) - PPG_time_5min(1)) - 34764/temp_intp_num;

temp_ECG_time_5min = ECG_time_5min + manual_add_sec;% + 1*60 + 52.451;% + 77.141; % plus sec.

%% Plotting 30-sec PPG segment and X min ECG:
HR_panel_text = ['Finished! manual add sec: ', num2str(manual_add_sec,'%2.4f'),' sec'];
HR_panel_text_color = 'r';
title_name = {['PPG idx ',num2str(first_seg_idx),' to ',num2str(end_seg_idx)],...
[All_PPG_file_name{first_seg_idx,1},' to ',All_PPG_file_name{end_seg_idx,1}],...
['Finished! manual add sec: ', num2str(manual_add_sec,'%2.4f'),' sec']}; % title for the figure.

fig_h = my_func_plot_step_0_manual_find_alignment_point(PPG_sig_5min,...
    PPG_filt_sig_5min,...
    PPG_time_5min,...
    PPG_pkloc_5min,...
    PPG_HR_5min,...
    ECG_filt_sig_5min,...
    ECG_pkloc_5min,...
    ECG_HR_5min,...
    temp_ECG_time_5min,...
    ECG_sig_5min,...
    exact_align_idx,...
    ECG_init_datetime,...
    fs_ECG, fs_PPG,...
    title_name,...
    PPG_filt_sig_5min_1,...
    PPG_pkloc_5min_1,...
    PPG_HR_5min_1,...
    PPG_filt_sig_5min_2,...
    PPG_pkloc_5min_2,...
    PPG_HR_5min_2,...
    HR_panel_text,...
    HR_panel_text_color);

% 11/25/2021: Test xcorr alignment.
PPG_time_5min_model = PPG_time_5min; % Timestamp from PPG data.
% PPG_pkloc_5min = []; % Same PPG peak location for 5-min.
% PPG_HR_5min = []; % Same.
% PPG_pkloc_5min_L_array = []; % Same
% PPG_pkloc_5min_R_array = []; % Same
ECG_time_5min = temp_ECG_time_5min;
% ECG_pkloc_5min = []; % Same
% ECG_init_datetime = []; % Same
% ECG_HR_5min = []; % Same
model_add_sec_array = zeros(size(PPG_pkloc_5min_L_array,1),1);
clean_segs = [1:size(PPG_pkloc_5min_L_array,1)]'; % I assume all segments are clean.
clean_segs = clean_segs(:);
% PPG_time_5min_L_array = []; % Same
% PPG_time_5min_R_array = []; % Same
ECG_pkloc_5min_L_array = [];
ECG_pkloc_5min_R_array = [];
% show_ECG_min_left = [];

addpath('..\fine_tune_alignment\func');
    [xcorr_model_add_sec,...
        xcorr_add_secs_candidates,...
        xcorr_scores_full,...
        temp_intp_num,...
        max_idx,...
        base_time_diff,...
        xcorr_shift_datetime,...
        rmse_array] = time_seg_xcorr_eval_interp_at_begin_initial_alignment(PPG_time_5min_model, PPG_pkloc_5min, PPG_HR_5min,...
        PPG_pkloc_5min_L_array, PPG_pkloc_5min_R_array,...
        ECG_time_5min, ECG_pkloc_5min, ECG_init_datetime,...
        ECG_HR_5min, model_add_sec_array, clean_segs, 2,...
        PPG_time_5min_L_array,PPG_time_5min_R_array,...
        ECG_pkloc_5min_L_array,ECG_pkloc_5min_R_array,...
        show_ECG_min_left); % time_seg_xcorr_eval_interp_at_begin

% xcorr_scores_full(isnan(xcorr_scores_full)) = [];
% figure;
% plot(xcorr_scores_full,'o-','Displayname','xcorr score');
% hold on;
% [xcorr_vals,xcorr_locs] = findpeaks(xcorr_scores_full);
% plot(xcorr_locs,xcorr_scores_full(xcorr_locs),'rv','Displayname','xcorr loc max');
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>> END OF FAHIMEH: CHANGE VARIABLES HERE 4/4 >>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
if my_clinical_trial_flag
    save_fig_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\clinical_trial'];
else
    save_fig_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\AF_trial'];
end
if ~exist(save_fig_path,'dir')
   mkdir(save_fig_path); 
end
save_fig_name = [UID,'_all','_5min_ECG_PPG.fig'];
saveas(fig_h,[save_fig_path,'\',save_fig_name]);

% % save all workspace: % I commented this because I have pre-run all
% Billal's algorithm, so there is no need to save the work space. It takes
% a lot of time to save all workspace.
% save_wkspc_name = [UID,'_worksapce','_5min_ECG_PPG.mat'];
% 
% save([save_fig_path,'\',save_wkspc_name]);
