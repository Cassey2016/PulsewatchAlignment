% This main is to plot when the user flap chest if you find the flap chest
% mark in watch PPG.
% Dong, 11/30/2020.
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
% --- Know which ECG patch and ECG start time -----------------------------
% =========================================================================
if my_holter_flag
    % uconn testing patient, using holter monitor.
    fs_ECG = 180;
else
    % Patch ECG sampling frequency.
    fs_ECG = 250;
end
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
        Patch_B_start_time,...
        test_ECG_path_C,...
        Patch_C_start_time] = my_func_UID_ECG_final_path(UID);
end
% Know which patch you want to check:
patch_AB = input('Which patch do you want to check? (A/B/C) \n','s');
if strcmp(patch_AB,'A')
    ECG_path = test_ECG_path_A;
    ECG_start_time = Patch_A_start_time;
    ECG_init_datetime = datetime(ECG_start_time,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
    ECG_seg_prefix = ['Pulsewatch',UID,patch_AB];
elseif strcmp(patch_AB,'B')
    ECG_path = test_ECG_path_B;
    ECG_start_time = Patch_B_start_time;
    ECG_init_datetime = datetime(ECG_start_time,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
    ECG_seg_prefix = ['Pulsewatch',UID,patch_AB];
elseif strcmp(patch_AB,'C')
    ECG_path = test_ECG_path_C;
    ECG_start_time = Patch_C_start_time;
    ECG_init_datetime = datetime(ECG_start_time,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
    ECG_seg_prefix = ['Pulsewatch',UID,patch_AB];
else
    disp('Unseen patch name, check!');
    keyboard;
end
% =========================================================================
% --- Know which ECG segment to check -----------------------------
% =========================================================================
    list = dir(ECG_path);
    list = list(3:end); % first two files are '.' and '..'.
    total_ECG_seg = size(list,1);
    fprintf('Which ECG 1-hour segment do you want to plot (out of %d segments)?:\n',total_ECG_seg);
    select_seg = input(' ');
        % load patch A data:
        temp_file_name = [ECG_seg_prefix,'_',num2str(select_seg,'%03d'),'.mat'];
        load([ECG_path,'\',temp_file_name]); % loaded var: Data
        
        this_ECG_time = ECG_init_datetime + seconds(Data(1:end,1)); % ECG datetime.
        this_ECG_data = Data(1:end,2); % ECG data.

        % plotting to visually decide which ECG is empty:
        figure;
        plot(this_ECG_time,this_ECG_data);
        hold on;
        title(temp_file_name,'Interpreter','none');
%         ylim([mean(this_ECG_data)-200, mean(this_ECG_data)+200]); % 200 amplitude is what i observed for clean ECG in Cardea Solo patch.
        ylabel('ECG raw amplitude');
    
        xlabel('Time (datetime)');