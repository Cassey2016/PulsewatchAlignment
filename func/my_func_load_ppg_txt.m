function [PPG_name_cell,Fahimeh_alignment_output_path] = my_func_load_ppg_txt(watch_data_folder_path,UID,HPC_flag,root_data_path)
% This function will focus on loading ppg files, and does not care if there
% is paired log files or acc files.
% Intention is to run for null value detection.
% Dong, 07/09/2020.

% Step 1: find all files that contain 'ppg' in the file name.
% Step 2: PPG file that has long file name, find the file index,
% Step 3: There are two types of long file name, 'long number index', 'txt with
% suffix': 
% for 'long number index', cut the long number, find if there are
% same name index file; if there is, compare file content, if contents are
% same or the long file is blank, delete this file name from list; if the
% long file name content is usable, delete the matched file name;
if HPC_flag
    Fahimeh_alignment_output_path = [root_data_path,filesep,'mat_for_load_Final_Clinical_Trial_Data']; % Keep this there in the /home/doh16101/ path.
else
    Fahimeh_alignment_output_path = [root_data_path,filesep,'mat_for_load_Final_Clinical_Trial_Data']; 
end
if ~exist(Fahimeh_alignment_output_path,'dir')
	fprintf('Fahimeh_alignment_output_path does not exist: %s\n',Fahimeh_alignment_output_path);
    mkdir(Fahimeh_alignment_output_path);
end
PPG_struct_file_name = [Fahimeh_alignment_output_path,filesep,UID,'_focus_PPG_only.mat'];
if isfile(PPG_struct_file_name)
    % If I have run my_txt_data_loading before and saved the
    % output_struct.
    load(PPG_struct_file_name);
else
    %% step 1: find all files that contain 'ppg' in the file name.
    % folder_path = 'K:\Dong\myGalaxyWatchDatabase\ChonlabData\WatchTest10202019\F-1Data';
    temp_folder_path = [watch_data_folder_path,filesep,'*ppg*']; % visit all files have 'ppg' in the file name.
    PPG_file_listing = dir(temp_folder_path);

    %% step 2: find the file index when PPG file has a long file name.
    long_file_idx = NaN(size(PPG_file_listing,1),1); 
    count_long_file = 0;
    % first, know which files are long file.
    all_PPG_file_name = cell(size(PPG_file_listing,1),1); % transfer list to a cell.
    for ii= 1:size(PPG_file_listing,1)
        if length(PPG_file_listing(ii).name) > 36 % e.g.: 002_2019_09_03_15_48_17_ppg_0000.txt
            count_long_file = count_long_file + 1;
            long_file_idx(count_long_file) = ii;
        end
        all_PPG_file_name{ii,1} = PPG_file_listing(ii).name;
    end
    long_file_idx(isnan(long_file_idx)) = []; % remove empty array content.
    long_file_name = all_PPG_file_name(long_file_idx,1);
    %% step 3: find match file name, compare content, delete index.
    delete_idx_array = NaN(size(PPG_file_listing,1),1);
    for ii = 1:size(long_file_idx,1)
        temp_long_file_idx = long_file_idx(ii,1);
        temp_long_file_name = all_PPG_file_name{temp_long_file_idx,1};

        % check which type of long file name:
        % type 1: 002_2019_09_03_15_48_17_ppg_00011567540732795.txt
        % type 2: 002_2019_09_14_07_57_00_ppg_0007.txt_temp_10031
        if strcmp(temp_long_file_name(1,33:36),'.txt')
            % type 2: 002_2019_09_14_07_57_00_ppg_0007.txt_temp_10031
            keep_file_name = temp_long_file_name(1,1:36); % discard the name after .txt
        elseif strcmp(temp_long_file_name(1,end-3:end),'.txt')
           % type 1: 002_2019_09_03_15_48_17_ppg_00011567540732795.txt
           keep_file_name = [temp_long_file_name(1,1:32),'.txt']; % keep the first four digits.
        else
            % I have never seen this type of long file, so check!
            disp('unseen long file name, check!');
            keyboard;
        end
        delete_idx = my_cmp_PPG_same_file_name_content(keep_file_name,all_PPG_file_name,temp_long_file_name,watch_data_folder_path,temp_long_file_idx);
        delete_idx_array(ii,1) = delete_idx;
    end
    delete_idx_array(isnan(delete_idx_array)) = [];

    will_be_delete_file_name = all_PPG_file_name(delete_idx_array,1);

    remain_PPG_file_name = all_PPG_file_name;
    remain_PPG_file_name(delete_idx_array) = [];
    PPG_name_cell = remain_PPG_file_name;
    save(PPG_struct_file_name,'PPG_name_cell',...
        'remain_PPG_file_name',...
        'will_be_delete_file_name',...
        'delete_idx_array',...
        'long_file_name',...
        'long_file_idx',...
        'all_PPG_file_name');
end
end

function delete_idx = my_cmp_PPG_same_file_name_content(keep_file_name,all_PPG_file_name,temp_long_file_name,folder_path,temp_long_file_idx)
    % find if there is same file in the PPG file name cell.
    match_idx = find(contains(all_PPG_file_name,keep_file_name)); % find string in cell array.
    [rm_idx] = find(match_idx == temp_long_file_idx);
    if ~isempty(rm_idx)
        % remove match index that is same as long file name.
        match_idx(rm_idx) = [];
    end
    delete_idx = NaN; % initla a delete index. it can be NaN when return.
    if isempty(match_idx)
        % no same PPG file with the long file name.
        % whether this PPG file is empty or not, you have to keep it. 
        return;
    else
        % there is one or more files has same name?
        if size(match_idx,1) > 1
            % more than one files have same name:
            disp('more than one file have same name, check!');
            keyboard;
        else
            % only one file has same name:
            
            % 1. load orginal file content:
            ori_txt = importdata([folder_path,filesep,all_PPG_file_name{match_idx,1}]); 
            
            % 2. load long file content:
            long_txt = importdata([folder_path,filesep,temp_long_file_name]); 
            
            % 3. check if any one of the array is empty:
            if isempty(ori_txt)
                % original txt is empty:
                % remove origin txt from the list:
                if isempty(long_txt)
                    % both ori and long file are empty:
                        disp('Both files are empty, please check!');
                        keyboard;
                else
                    % long file is not empty, so just delete this ori txt.
                    fprintf('Txt is empty: idx %d, %s will be deleted \n',match_idx,all_PPG_file_name{match_idx,1});
                    delete_idx = match_idx;
                end
            else
                if isempty(long_txt)
                    % origin txt has content, but long file name txt is
                    % empty:
                    fprintf('Txt is empty: idx %d, %s will be deleted \n',temp_long_file_idx,temp_long_file_name);
                    delete_idx = temp_long_file_idx;
                else
                    % both txt have content:
                    eq_flag = isequal(ori_txt,long_txt);
                    
                    if eq_flag
                        % if both file are eqaul content, delete the long
                        % file:
                        fprintf('Txt content same: idx %d, %s will be deleted \n',temp_long_file_idx,temp_long_file_name);
                        delete_idx = temp_long_file_idx;
                    else
                        % I have never seen other types of unequal content:
                        disp('unseen unequal content, check!');
                        keyboard;
                    end
                end
            end
        end
    end
end
