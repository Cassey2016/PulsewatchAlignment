function [patch_dur,last_seg_hour] = my_func_patch_dur_day(test_ECG_path,...
    fs_ECG)
	fprintf("test_ECG_path is: %s\n",test_ECG_path);
    list = dir(test_ECG_path);
    list = list(3:end); % first two files are '.' and '..'.
    last_seg_idx = size(list,1);
    temp_ECG_file_name = list(last_seg_idx).name;
    load([test_ECG_path,filesep,temp_ECG_file_name]); % loaded var: Data
    last_seg_sec = size(Data,1)/fs_ECG;
    
    last_seg_hour = str2num(temp_ECG_file_name(end-6:end-4));
    patch_dur = (last_seg_hour + last_seg_sec/3600)/24; % unit: day
end
