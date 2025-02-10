function [ECG_path,...
    ECG_Date_string,...
    LinearInterp_path] = my_func_Cardea_SOLO_know_patch_A_B(test_ECG_path_A,...
        Patch_A_start_time,...
        test_ECG_path_B,...
        Patch_B_start_time,...
        test_ECG_path_C,...
        Patch_C_start_time,...
        PPG_start_time,...
        fs_ECG,...
        LinearInterp_root)
% knows to load patch A or patch B:
if ~isempty(Patch_A_start_time)
    patch_A_datetime = datetime(Patch_A_start_time,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
    patch_A_dur = my_func_patch_dur_day(test_ECG_path_A,...
    fs_ECG);
    temp_diff_time = days(PPG_start_time - patch_A_datetime);
    flag_in_patch_A = (temp_diff_time >= 0 & temp_diff_time <= patch_A_dur);
else
    disp('Patch A does not exist!');
%     keyboard; 
    patch_A_dur = 0; % zero days.
    flag_in_patch_A = false;
end

if ~isempty(Patch_B_start_time) % I used empty start time to indicate a invalid patch.
    patch_B_datetime = datetime(Patch_B_start_time,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
    patch_B_dur = my_func_patch_dur_day(test_ECG_path_B,...
    fs_ECG);
    temp_diff_time = days(PPG_start_time - patch_B_datetime);
    flag_in_patch_B = (temp_diff_time >= 0 & temp_diff_time <= patch_B_dur);
else
    % Patch B does not exist.
    patch_B_datetime = [];
    patch_B_dur = 0;
    flag_in_patch_B = false;
end

if ~isempty(Patch_C_start_time) % I used empty start time to indicate a invalid patch.
    patch_C_datetime = datetime(Patch_C_start_time,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.
    patch_C_dur = my_func_patch_dur_day(test_ECG_path_C,...
    fs_ECG);
    temp_diff_time = days(PPG_start_time - patch_C_datetime);
    flag_in_patch_C = (temp_diff_time >= 0 & temp_diff_time <= patch_C_dur);
else
    % Patch B does not exist.
    patch_C_datetime = [];
    patch_C_dur = 0;
    flag_in_patch_C = false;
end
% I think I did wrong. I should know the duration of each patch, and then
% check which patch to load.

% Also need to make sure if one PPG start time does not fall in two ECG
% patch. If that happened, check which ECG patch data is not empty.
% Manually.

if flag_in_patch_A && flag_in_patch_B
    % same PPG segment falls in two ECG patches:
    disp('Same PPG segment falls in two ECG patches!');
    ECG_path = test_ECG_path_B; % for UID 036, 038, 039, just use the second patch ECG.
    ECG_Date_string = Patch_B_start_time; % I will assume
    if strcmp(ECG_path(end),'B')
        LinearInterp_path = [LinearInterp_root,filesep,ECG_path(end-13:end)];
    else
        LinearInterp_path = [LinearInterp_root,filesep,'Pulsewatch',ECG_path(end-2:end)]; % For AF subjects, I saved as like "Pulsewatch423".
    end
else
    if flag_in_patch_B && flag_in_patch_C
       % same PPG segment falls in two ECG patches:
        disp('Same PPG segment falls in two ECG patches!');
        ECG_path = test_ECG_path_C; % for UID 028, just use the third patch ECG.
        ECG_Date_string = Patch_C_start_time; % I will assume
        if strcmp(ECG_path(end),'C')
            LinearInterp_path = [LinearInterp_root,filesep,ECG_path(end-13:end)];
        else
            LinearInterp_path = [LinearInterp_root,filesep,'Pulsewatch',ECG_path(end-2:end)];
        end
    elseif flag_in_patch_A
        % within the duration of patch A. 
        ECG_path = test_ECG_path_A;
        ECG_Date_string = Patch_A_start_time; % I will assume
        if strcmp(ECG_path(end),'A')
            LinearInterp_path = [LinearInterp_root,filesep,ECG_path(end-13:end)];
        else
            LinearInterp_path = [LinearInterp_root,filesep,'Pulsewatch',ECG_path(end-2:end)];
        end
    else
        % see if patch B exists:
        if ~isempty(patch_B_datetime)
            if flag_in_patch_B
                ECG_path = test_ECG_path_B;
                ECG_Date_string = Patch_B_start_time; % I will assume
                if strcmp(ECG_path(end),'B')
                    LinearInterp_path = [LinearInterp_root,filesep,ECG_path(end-13:end)];
                else
                    LinearInterp_path = [LinearInterp_root,filesep,'Pulsewatch',ECG_path(end-2:end)];
                end
            else
                % maybe there is patch C?
                disp('PPG falls outside ECG time!');
%                 keyboard; 
                ECG_path = [];
                ECG_Date_string = [];
                LinearInterp_path = [];
            end
        else
            disp('PPG falls inside patch B, but patch B does not exist!');
            ECG_path = []; % For AF trial, UID 301 has PPG started before ECG.
            ECG_Date_string = [];
            LinearInterp_path = [];
        end
    end
end
end