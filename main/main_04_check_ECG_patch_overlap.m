% This main function is to check if ECG patches have overlap with each
% other.
clear all;
close all;
clc;

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
% --- Check if difference ECG patches are overlapped with each other ------
% =========================================================================
% know each patch duration in days.
test_ECG_path = test_ECG_path_A;
[patch_dur,last_seg_hour] = my_func_patch_dur_day(test_ECG_path,...
    fs_ECG);
patch_A_dur = patch_dur;
A_last_seg_hour = last_seg_hour;

test_ECG_path = test_ECG_path_B;
[patch_dur,last_seg_hour] = my_func_patch_dur_day(test_ECG_path,...
    fs_ECG);
patch_B_dur = patch_dur;
B_last_seg_hour = last_seg_hour;

% know each patch start time.
ECG_Date_sting = Patch_A_start_time;
ECG_init_datetime = datetime(ECG_Date_sting,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
ECG_init_datetime_patch_A = ECG_init_datetime;

ECG_Date_sting = Patch_B_start_time;
ECG_init_datetime = datetime(ECG_Date_sting,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
ECG_init_datetime_patch_B = ECG_init_datetime;

% check if next patch falls inside the previous patch.
if (ECG_init_datetime_patch_A + days(patch_A_dur)) >= ECG_init_datetime_patch_B
   flag_B_in_A = true;
   disp('Patch B is inside A!');
else
    flag_B_in_A = false;
    disp('Patch B is safe, not inside A.');
end

% if patch overlapped, check starting in which segment, both patches
% overlapped:
if flag_B_in_A
   overlap_hour = hours((ECG_init_datetime_patch_A + days(patch_A_dur)) - ECG_init_datetime_patch_B);
   overlap_start_hour = patch_A_dur * 24 - overlap_hour;
   overlap_start_idx = floor(overlap_start_hour) + 1; % MATLAB index start with 1.
   overlap_start_point = round((overlap_start_hour - overlap_start_idx + 1) * fs_ECG * 3600); % hour to second.
   if overlap_start_point < 1
       % in case it is a whole hour, and starting index cannot be zero.
       overlap_start_point = 1;
   end
   
   % know how many ECG segments remaining to check:
   remain_ECG_seg = [overlap_start_idx:A_last_seg_hour]'; % the ECG segments we need to load from the previous ECG patch.
   new_ECG_seg = [1:size(remain_ECG_seg,1)]'; % the ECG segments we want to load from the next ECG patch.

% know the starting time for x axis:

    for ii = 1:size(remain_ECG_seg,1)
        if ii == 1
            % the first ECG must be a cropped one:
            temp_start_idx_A = overlap_start_point;
        else
            % remaining ECG will start from 1.
            temp_start_idx_A = 1;
        end
        % load patch A data:
        temp_file_name_A = ['Pulsewatch',UID,'A_',num2str(remain_ECG_seg(ii,1),'%03d'),'.mat'];
        load([test_ECG_path_A,'\',temp_file_name_A]); % loaded var: Data
        
        this_ECG_A_time = ECG_init_datetime_patch_A + seconds(Data(1:end,1)); % ECG datetime.
        this_ECG_A_data = Data(1:end,2); % ECG data.

        % load patch B data:
        temp_file_name_B = ['Pulsewatch',UID,'B_',num2str(new_ECG_seg(ii,1),'%03d'),'.mat'];
        load([test_ECG_path_B,'\',temp_file_name_B]); % loaded var: Data
        
        this_ECG_B_time = ECG_init_datetime_patch_B + seconds(Data(:,1)); % ECG datetime.
        this_ECG_B_data = Data(:,2); % ECG data.

        % plotting to visually decide which ECG is empty:
        figure;
        ax(1) = subplot(2,1,1);
        plot(this_ECG_A_time,this_ECG_A_data);
        hold on;
        xline(this_ECG_A_time(temp_start_idx_A,1),'--r',{'Overlap','Begin'}); % the start of overlapping place.
        title(temp_file_name_A,'Interpreter','none');
        ylim([mean(this_ECG_A_data)-200, mean(this_ECG_A_data)+200]); % 200 amplitude is what i observed for clean ECG in Cardea Solo patch.
        ylabel('ECG raw amplitude');
    
        % subplot for patch B:
        ax(2) = subplot(2,1,2);
        plot(this_ECG_B_time,this_ECG_B_data);
        linkaxes(ax,'x');
        title(temp_file_name_B,'Interpreter','none');
        ylim([mean(this_ECG_B_data)-200, mean(this_ECG_B_data)+200]);
        ylabel('ECG raw amplitude');

        xlim([this_ECG_B_time(1)-seconds(100), this_ECG_B_time(1)+seconds(100)]);
        xlabel('Time (datetime)');
    end
end

% note:
% [11/15/2020]: UID 036: Patch A is null startin from segment 163, and was null in the entire segment 163.