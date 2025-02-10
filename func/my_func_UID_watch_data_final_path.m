% This function stored the path of watch data that are pruned by Dong,
% manually based on the experiment start and end time.
% Dong, created on 08/26/2020.
% Last edited: 08/26/2020.
function test_PPG_path = my_func_UID_watch_data_final_path(UID,HPC_flag,root_data_path)
if strcmp(UID(1:1),'0') || strcmp(UID(1:1),'1')
    if HPC_flag
        test_PPG_path = [root_data_path,filesep,'Final_Clinical_Trial_Data',filesep,UID,'_final'];
    else
        test_PPG_path = [root_data_path,filesep,'Final_Clinical_Trial_Data',filesep,UID,'_final'];
    end
elseif strcmp(UID(1:1),'3') || strcmp(UID(1:1),'4')
    if HPC_flag
        % test_PPG_path = [root_data_path,filesep,'AF_trial',filesep,'Final_AF_Trial_Data',filesep,UID,'_final'];
        test_PPG_path = [root_data_path,filesep,'Final_AF_Trial_Data',filesep,UID,'_final'];
	fprintf('In 3 or 4 UID, HPC flag\n');
    else
        % test_PPG_path = [root_data_path,filesep,'Final_AF_Trial_Data',filesep,UID,'_final'];
        test_PPG_path = [root_data_path,filesep,'AF_trial',filesep,'Final_AF_Trial_Data',filesep,UID,'_final'];
    end
	fprintf('test_PPG_path is: %s\n',test_PPG_path);
elseif strcmp(UID,'913_02042021')
    if HPC_flag
        test_PPG_path = ['R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_APP_ver_2_0\Dong_watch_data\913_02042021'];
    else
        test_PPG_path = ['R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_APP_ver_2_0\Dong_watch_data\913_02042021'];
    end
elseif strcmp(UID,'914_2021042601')
    if HPC_flag
        test_PPG_path = ['/scratch/doh16101-lab/Test_Up_Time_2_1_0/watch_data/Done'];
    else
        test_PPG_path = ['R:\ENGR_Chon\Dong\myGalaxyWatch3Database\Test_Up_Time_2_1_0\watch_data\Pulsewatch\Done'];
    end
elseif strcmp(UID,'999_2021042601')
    if HPC_flag
        test_PPG_path = [''];
    else
        test_PPG_path = [''];
    end
elseif strcmp(UID,'999_2021042901')
    if HPC_flag
        test_PPG_path = [''];
    else
        test_PPG_path = [''];
    end
elseif strcmp(UID,'999_2021050101')
    if HPC_flag
        test_PPG_path = [''];
    else
        test_PPG_path = [''];
    end
elseif strcmp(UID,'999_2021050501')
    if HPC_flag
        test_PPG_path = [''];
    else
        test_PPG_path = [''];
    end
end
if ~exist(test_PPG_path,'dir')
    % PPG data directory does not exists.
    disp('my_func_UID_watch_data_final_path, not finished pruning!');
	fprintf('test_PPG_path: %s\n',test_PPG_path);
    keyboard;
end
end
