function ACC_for_All_PPG_file_name = my_func_load_acc_txt_after_ppg(All_PPG_file_name,...
    folder_path,...
    Fahimeh_alignment_output_path,...
    UID)
% This function should be run after:
% R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Watch_On_Time_Processing\Test_API_1_0_14\my_focus_ppg_data_loading.m
ACC_struct_file_name = [Fahimeh_alignment_output_path,filesep,UID,'_after_ppg_load_acc.mat'];
if isfile(ACC_struct_file_name)
    % If I have run my_txt_data_loading before and saved the
    % output_struct.
    load(ACC_struct_file_name);
else
    %% step 1: find all files that contain 'accel' in the file name.
    % folder_path = 'K:\Dong\myGalaxyWatchDatabase\ChonlabData\WatchTest10202019\F-1Data';
    temp_folder_path = [folder_path,filesep,'*accel*']; % visit all files have 'accel' in the file name.
    ACC_file_listing = dir(temp_folder_path);
    
    %% step 2: clean up long file names and have a final 
    long_file_idx = NaN(size(ACC_file_listing,1),1); 
    count_long_file = 0;
    % first, know which files are long file.
    all_ACC_file_name = cell(size(ACC_file_listing,1),1); % transfer list to a cell.
    for ii= 1:size(ACC_file_listing,1)
        if length(ACC_file_listing(ii).name) > 38 % e.g.: 002_2019_09_03_15_48_17_accel_0000.txt
            count_long_file = count_long_file + 1;
            long_file_idx(count_long_file) = ii;
        end
        all_ACC_file_name{ii,1} = ACC_file_listing(ii).name;
    end
    long_file_idx(isnan(long_file_idx)) = []; % remove empty array content.
    long_file_name = all_ACC_file_name(long_file_idx,1);
    
    %% step 3: delete long file index, and only delete short file index when there is a non-empty long file index.
    delete_idx_array = NaN(size(ACC_file_listing,1),1);
    for ii = 1:size(long_file_idx,1)
        temp_long_file_idx = long_file_idx(ii,1);
        temp_long_file_name = all_ACC_file_name{temp_long_file_idx,1};

        % check which type of long file name:
        % type 1: 002_2019_09_03_15_48_17_ppg_00011567540732795.txt
        % type 2: 002_2019_09_14_07_57_00_ppg_0007.txt_temp_10031
        if strcmp(temp_long_file_name(1,35:38),'.txt') % accel
            % type 2: 002_2019_09_14_07_57_00_ppg_0007.txt_temp_10031
            keep_file_name = temp_long_file_name(1,1:38); % discard the name after .txt
        elseif strcmp(temp_long_file_name(1,end-3:end),'.txt')
           % type 1: 002_2019_09_03_15_48_17_ppg_00011567540732795.txt
           keep_file_name = [temp_long_file_name(1,1:34),'.txt']; % keep the first four digits.
        else
            % I have never seen this type of long file, so check!
            disp('unseen long file name, check!');
            keyboard;
        end
        delete_idx = my_cmp_ACC_same_file_name_content(keep_file_name,all_ACC_file_name,temp_long_file_name,folder_path,temp_long_file_idx);
        delete_idx_array(ii,1) = delete_idx;
    end
    delete_idx_array(isnan(delete_idx_array)) = [];

    will_be_delete_file_name = all_ACC_file_name(delete_idx_array,1);

    remain_ACC_file_name = all_ACC_file_name;
    remain_ACC_file_name(delete_idx_array) = [];
    ACC_name_cell = remain_ACC_file_name;
    
    %% step 4: pair ACC with same time and seg PPG, if no matched file, keep the cell empty.
    ACC_for_All_PPG_file_name = cell(size(All_PPG_file_name,1),1);
    for ii = 1:size(All_PPG_file_name,1)
        temp_PPG_name = All_PPG_file_name{ii,1}; % get current PPG file name.
        % in case this is a long file name PPG file, I will reformat it
        % into a short name:
        % check which type of long file name:
        % type 1: 002_2019_09_03_15_48_17_ppg_00011567540732795.txt
        % type 2: 002_2019_09_14_07_57_00_ppg_0007.txt_temp_10031
        if strcmp(temp_PPG_name(1,33:36),'.txt')
            % type 2: 002_2019_09_14_07_57_00_ppg_0007.txt_temp_10031
            keep_file_name = temp_PPG_name(1,1:36); % discard the name after .txt
        elseif strcmp(temp_PPG_name(1,end-3:end),'.txt')
           % type 1: 002_2019_09_03_15_48_17_ppg_00011567540732795.txt
           keep_file_name = [temp_PPG_name(1,1:32),'.txt']; % keep the first four digits.
        else
            % I have never seen this type of long file, so check!
            disp('unseen long file name, check!');
            keyboard;
        end
        reformat_name = [keep_file_name(1:24),'accel_',keep_file_name(29:32)];
        match_idx = find(contains(ACC_name_cell,reformat_name));
        if ~isempty(match_idx)
            % if there is a ACC file exists, give it to this location.
            ACC_for_All_PPG_file_name{ii,1} = ACC_name_cell{match_idx,1};
        else
            % no match ACC file, leave the cell empty.
        end
    end
    save(ACC_struct_file_name,'ACC_name_cell',...
        'remain_ACC_file_name',...
        'will_be_delete_file_name',...
        'delete_idx_array',...
        'long_file_name',...
        'long_file_idx',...
        'all_ACC_file_name',...
        'ACC_for_All_PPG_file_name',...
        'All_PPG_file_name');
end
end

function delete_idx = my_cmp_ACC_same_file_name_content(keep_file_name,all_ACC_file_name,temp_long_file_name,folder_path,temp_long_file_idx)
    % find if there is same file in the PPG file name cell.
    match_idx = find(contains(all_ACC_file_name,keep_file_name)); % find string in cell array.
    delete_idx = NaN; % initla a delete index. it can be NaN when return.
    [rm_idx] = find(match_idx == temp_long_file_idx);
    if ~isempty(rm_idx)
        % remove match index that is same as long file name.
        match_idx(rm_idx) = [];
    end
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
            ori_txt = importdata([folder_path,filesep,all_ACC_file_name{match_idx,1}]); 
            
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
                    fprintf('Txt is empty: idx %d, %s will be deleted \n',match_idx,all_ACC_file_name{match_idx,1});
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
                        % case 1: the size of long file is smaller than the
                        % original ACC file, and part of it or all of it is
                        % within the original ACC file.
                        if size(long_txt,1) <= size(ori_txt,1)
                            C = intersect(long_txt,ori_txt,'rows'); % find same elements in two arrays.
                            C_ismember = ismember(ori_txt,long_txt); % know which elements is within the origin file.
                            if size(C,1) == size(long_txt,1) || (size(C,1) == size(long_txt,1)-1) % last row is destroyed 036_2020_07_05_10_51_15_accel_0003.txt_temp_8846
                               % long file content is within the original
                               % file.
                               fprintf('Txt content within orig: idx %d, %s will be deleted \n',temp_long_file_idx,temp_long_file_name);
                               delete_idx = temp_long_file_idx;
                            else
                                % long file has some part that original
                                % file does not have.
                                keyboard;
                            end
                        else
                            % I have never seen other types of unequal content:
                            disp('long file has longer content, check!');
                            keyboard;
                        end
                    end
                end
            end
        end
    end
end
