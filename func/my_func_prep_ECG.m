function my_func_prep_ECG(UID)
% This func is to know ECG path and start time if we know UID.
% created: 10/23/2020.
addpath('..\func');

% load ECG data:
% ECG_path = ['R:\ENGR_Chon\Dong\myGearS3Database\Test_API_1_0_14\Ref_ECG\OneHour'];
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
    ECG_UID = ['913_916_20201011']; % not sure if this is correct.
else
    [test_ECG_path_A,...
        Patch_A_start_time,...
        test_ECG_path_B,...
        Patch_B_start_time] = my_func_UID_ECG_final_path(UID);
    if strcmp(UID(1:1),'3')
        ECG_UID = UID; % AF trial only has one patch.
    else
        ECG_UID = [UID,'A']; % WARNING: need to automatically change to patch A to B. 10/19/2020.
    end
end

ECG_path = test_ECG_path_A;
list = dir(ECG_path);
list = list(3:end); % first two cells are . and ..
output_ECG_file_name = cell(size(list,1),1);
for ii = 1:size(list,1)
    output_ECG_file_name{ii,1} = list(ii).name;
end

count_ECG_file = 1;
%% Know ECG record starting time.
% ECG_Date_sting = '05/27/2020 00:11:41.701';
% ECG_Date_sting = '06/06/2020 00:22:05.191';%'06/06/2020 00:25:02.191';
ECG_Date_sting = Patch_A_start_time;
ECG_init_datetime = datetime(ECG_Date_sting,'InputFormat','MM/dd/yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % The Month and Minute is reverse compared to datestr. Also, ss is second.

end