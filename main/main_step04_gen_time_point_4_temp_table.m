% This function is to convert Temp_table into final index.
% Dong, 04/13/2020.
% I copied this main to convert the UID Fahimeh aligned to the structure I
% can use. 
% Dong, 11/26/2020.

clear all;
close all;
clc;

% =========================================================================
% --- know watch UID. If you do not have it before txt file name, use
% Powershell to rename your txt file into '9XX_*' three digit UID name. ---
% =========================================================================
addpath('..\func');
UID = my_func_user_select_UID();
my_holter_flag = false; % I am using Holter monitor for testing.
fs_PPG = 50;
fs_ACC = 50;
% =========================================================================
% --- The purpose of knowing UID is to know the path to load PPG data: ---
% =========================================================================
my_plot_flag = false;

if my_holter_flag
% test_PPG_path =  'R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Watch_Data\916'; % folder where exported mat file located.
% test_PPG_path = 'R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Watch_Data\916_2nd\916'; % 2nd time experiment.
    test_PPG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_new_watch_UI_1_0_0\phone_data\',UID,'\Pulsewatch\Done'];
else
    % use clinical trial path:
    test_PPG_path = my_func_UID_watch_data_final_path(UID);
end
% =========================================================================
% --- Load watch txt file names: -----------------------------------------
% =========================================================================
fprintf('Loading all PPG txt for %s watch data...',UID);
[All_PPG_file_name,txt_file_list_path] = my_func_load_ppg_txt(test_PPG_path,UID); % use this version of PPG loading. 09/01/2020
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
if my_holter_flag % using Holter ECG, not patch.
    % ECG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Ref_ECG\OneHour'];
    % ECG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Ref_ECG\OneHour_2nd\final'];
    test_ECG_path_A = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_new_watch_UI_1_0_0\Ref_ECG\OneHour'];
    if strcmp(UID,'913')
        Patch_A_start_time = ['10/11/2020 15:40:00.944'];
    elseif strcmp(UID,'916')
        Patch_A_start_time = ['10/11/2020 15:40:02.538'];
    end
    test_ECG_path_B = [];
    Patch_B_start_time = [];
else
    [test_ECG_path_A,...
        Patch_A_start_time,...
        test_ECG_path_B,...
        Patch_B_start_time] = my_func_UID_ECG_final_path(UID);
end

if my_holter_flag
    % uconn testing patient, using holter monitor.
    fs_ECG = 180;
else
    % Patch ECG sampling frequency.
    fs_ECG = 250;
end
% =========================================================================
% --- Know the patches Fahimeh aligned ------------------------------------
% =========================================================================
fahimeh_aligned_patch_folder = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Fahimeh_alignment_output','\',UID];
% Temp_table_name = [Temp_table_path,'\','Temp_table_',ECG_seg_idx,'.mat'];
temp_fahimeh_aligned_patch_file = [fahimeh_aligned_patch_folder,'\*',UID,'*']; % visit all folders has the UID name in it.
temp_fahimeh_aligned_patch_list = dir(temp_fahimeh_aligned_patch_file);
% =========================================================================
% --- Check if my final output folder exists ------------------------------
% =========================================================================
final_output_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Final_Alignment_Output','\',UID]; % only keep '005' for example.
if exist(final_output_path, 'dir') % I like to automatically check if this folder exist, so I never need to waste time creating folders before running code.
    % folder exists, no need to do anything.
else
    mkdir(final_output_path);
end
for pp = 1:size(temp_fahimeh_aligned_patch_list,1)
    if strcmp(UID,'005')
        ECG_patch_ID = '005A';
    else
        ECG_patch_ID = temp_fahimeh_aligned_patch_list(pp).name;
    end
    test_ECG_path = ['R:\ENGR_Chon\NIH_Pulsewatch_Database\Patch_ECG_Converted_Data\Pulsewatch',ECG_patch_ID];
% test_Billal_ECG_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Billal_filtered_ECG','\',ECG_patch_ID(1:3),'\',ECG_patch_ID];

%     addpath('R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Reference_ECG_Processing'); % for my_algorithm2
% =========================================================================
% --- Load Fahimeh aligned Temp_table -------------------------------------
% =========================================================================
    % Temp_table_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Temp_Table_Fahimeh'];
    if strcmp(UID, '005')
        Temp_table_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Fahimeh_alignment_output\005\Tables_005'];
    else
        Temp_table_path = ['R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\Fahimeh_alignment_output','\',UID,'\',ECG_patch_ID,'\','Tables'];
    end
    % Temp_table_name = [Temp_table_path,'\','Temp_table_',ECG_seg_idx,'.mat'];
    temp_Temp_table_file = [Temp_table_path,'\*Temp_table_*']; % visit all files have 'ppg' in the file name.
    Temp_table_listing = dir(temp_Temp_table_file);

for tt = 1:size(Temp_table_listing,1)
    Temp_table_name = Temp_table_listing(tt).name;
    if size(Temp_table_name,2) == 16
        ECG_seg_idx = Temp_table_name(12:13);
    elseif size(Temp_table_name,2) == 17
        ECG_seg_idx = Temp_table_name(12:14);
    elseif size(Temp_table_name,2) == 18
        ECG_seg_idx = Temp_table_name(12:15);
    else
        disp('Unseen number of letter in Temp_table file name, check!');
        keyboard;
    end

    % load Fahimeh generated Temp_table
    load([Temp_table_path,'\',Temp_table_name]); % loaded variable name: Temp_table

    T_1_ECG_patch_name = cell(1,1); % table require cell string array.
    T_2_ECG_one_hr_idx = NaN;
    T_3_ECG_start_idx = NaN;
    T_4_ECG_end_idx = NaN;
    T_5_last_modify_time = cell(1,1); % table require cell string array.
    T_6_last_modify_person = cell(1,1); % table require cell string array.
    T_7_last_base_point_PPG_file = cell(1,1); % table require cell string array.

    T_1_ECG_patch_name = {ECG_patch_ID}; % '005A' for example.
    T_6_last_modify_person = {'Fahimeh'}; % All the temp table from 07/2020 to 11/30/2020 are generated by Fahimeh.

    for ii = 1:size(Temp_table,1) % number of rows.
        if ii == 1 && strcmp(Temp_table{ii,1},'ECG segment index')
            % first row is column name, so skip it.
            continue;
        else % not ii == 1 or first row is not column name.
            % first row is not column name, so keep it.
            PPG_file_name = char(Temp_table{ii,3}); % 1x1 cell to string.
            check_PPG_idx = find(strcmp(All_PPG_file_name,PPG_file_name));
            if isempty(check_PPG_idx)
                % this PPG file does not exist.
                keyboard;
            else % exists PPG file.
                % PPG file exists.
                ii_in_PPG_struct = Temp_table{ii,2};
                if ii_in_PPG_struct ~= check_PPG_idx
                   % PPG struct that Fahimeh has is difference with mine.
                   fprintf('Tell Fahimeh: PPG struct #%d is #%d in my PPG struct. \n',Temp_table{ii,2},check_PPG_idx);
                else
                    % PPG struct are same. Do nothing.
                end
                t_init = Temp_table{ii,4};
                t_end = Temp_table{ii,5};
                if (t_end - t_init) ~= fs_ECG * 30
                   % ECG length is not 7500, check.
                   if (t_end - t_init) < fs_ECG * 30
                       add_sample = fs_ECG * 30 - (t_end - t_init);
                        t_end = t_end + add_sample;
                   else
                       remove_sample = (t_end - t_init) - fs_ECG * 30;
                       t_end = t_end - remove_sample;
                   end

                end
                ECG_segment_idx = Temp_table{ii,1};
                if t_init < t_end
                    if t_init < 1
                        % t_init less than zero means it is in previous
                        % segment.
                        temp_ECG_segment_idx = ECG_segment_idx - 1; % in previous ECG segment index.
                        if temp_ECG_segment_idx < 1
                           % bug, ECG segment index less than one.
                           keyboard;
                        else
                            T_2_ECG_one_hr_idx = temp_ECG_segment_idx;
                            % convert negative index to positive.
                            ECG_seg_name = [test_ECG_path,'\','Pulsewatch',ECG_patch_ID,'_',num2str(T_2_ECG_one_hr_idx,'%03d'),'.mat'];
                            load(ECG_seg_name); % loaded variable name: Data.
                            size_ECG_one_hr = size(Data,1);
                            t_init_new = size_ECG_one_hr + t_init + 1;
                            T_3_ECG_start_idx = t_init_new;
                        end
                            ECG_seg_name = [test_ECG_path,'\','Pulsewatch',ECG_patch_ID,'_',num2str(ECG_segment_idx,'%03d'),'.mat'];
                            load(ECG_seg_name); % loaded variable name: Data.
                            size_ECG_one_hr = size(Data,1);
                            if t_end > size_ECG_one_hr
                                % bug, ECG segment index has to be less than next ECG segment length.
                                keyboard;
                            else
                                T_4_ECG_end_idx = t_end;
                            end
                    else % t_init >= 1, so it is still within the same ECG segment.
                        % check if t_end is greater than length of ECG.
                            T_2_ECG_one_hr_idx = ECG_segment_idx;
                            T_3_ECG_start_idx = t_init;
                            % convert negative index to positive.
                            ECG_seg_name = [test_ECG_path,'\','Pulsewatch',ECG_patch_ID,'_',num2str(T_2_ECG_one_hr_idx,'%03d'),'.mat'];
                            load(ECG_seg_name); % loaded variable name: Data.
                            size_ECG_one_hr = size(Data,1);
                            if t_end > size_ECG_one_hr
                                T_4_ECG_end_idx = t_end - size_ECG_one_hr; % goes to next segment.
                            else
                                T_4_ECG_end_idx = t_end; % smaller than this segment length, so keep it.
                            end
                    end
                elseif t_init > t_end
                    % t_init should be smaller than t_end.
                    % I though Fahimeh only have negative index.
                    keyboard;
                else % t_init == t_end
                    keyboard;
                end

                T_5_last_modify_time = {datestr(now,'yyyy_mm_dd_HH_MM_SS_FFF')};
                T_7_last_base_point_PPG_file = {PPG_file_name};
                final_output_file_name = [final_output_path,'\',PPG_file_name(1:32),'_align_output.mat']; % remove '.txt' from '005_2019_09_17_01_47_25_ppg_0014.txt'.
                align_output = table(T_1_ECG_patch_name,...
                    T_2_ECG_one_hr_idx,...
                    T_3_ECG_start_idx,...
                    T_4_ECG_end_idx,...
                    T_5_last_modify_time,...
                    T_6_last_modify_person,...
                    T_7_last_base_point_PPG_file);
                save(final_output_file_name,'align_output');

            end


        end

    end
end % end of looping each Temp_table Fahimeh aligned.
end % end of looping fahimeh aligned patches.