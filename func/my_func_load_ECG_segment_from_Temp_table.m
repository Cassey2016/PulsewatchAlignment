function [ECG_raw_data,...
    ECG_time,...
    ECG_Billal_filt,...
    ECG_Billal_peak,...
    ECG_Billal_HR] = my_func_load_ECG_segment_from_Temp_table(align_output,ECG_seg_path,ECG_patch_ID,fs_ECG,ECG_AF_trial_flag,...
    Patch_ECG_Billal_Peak_1_hr_path)
% This function is to load ECG data, and interpolate them before ECG peak
% detection. No filtering is needed.
% Dong, 04/14/2020.
    ECG_start_idx = align_output.T_3_ECG_start_idx(1);  % if don't know the start of ECG, put [];
    ECG_end_idx = align_output.T_4_ECG_end_idx(1); % if don't know the length of ECG, put [];
    if ECG_start_idx > ECG_end_idx
        
        % this segment override two ECG 1-hr segments;
        ECG_seg_idx = align_output.T_2_ECG_one_hr_idx(1);
        if ECG_AF_trial_flag
            ECG_seg_name = [ECG_seg_path,filesep,ECG_patch_ID,'_',num2str(ECG_seg_idx,'%03d')];
            ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',ECG_patch_ID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
        else
            ECG_seg_name = [ECG_seg_path,filesep,'Pulsewatch',ECG_patch_ID,'_',num2str(ECG_seg_idx,'%03d')];
            ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',ECG_patch_ID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
        end
        ECG_file_name = ECG_seg_name;
        load(ECG_file_name); % loaded variable: Data.
        load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
        size_of_ECG_1 = size(Data,1);
        ECG_clip_1 = Data(ECG_start_idx:size_of_ECG_1,2);
        ECG_clip_1_time = Data(ECG_start_idx:size_of_ECG_1,1);
        ECG_clip_1_Billal_filt = Billal_ECG_filt_1_hr_this(ECG_start_idx:size_of_ECG_1,2);
        ECG_clip_1_Billal_peak = Billal_ECG_peak_1_hr_this(ECG_start_idx:size_of_ECG_1,1);
        ECG_clip_1_Billal_peak = ECG_clip_1_Billal_peak - ECG_start_idx + 1;

        ECG_seg_idx = ECG_seg_idx + 1;
        if ECG_AF_trial_flag
            ECG_seg_name = [ECG_seg_path,filesep,ECG_patch_ID,'_',num2str(ECG_seg_idx,'%03d')];
            ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',ECG_patch_ID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
        else
            ECG_seg_name = [ECG_seg_path,filesep,'Pulsewatch',ECG_patch_ID,'_',num2str(ECG_seg_idx,'%03d')];
            ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',ECG_patch_ID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
        end
        ECG_file_name = ECG_seg_name;
        load(ECG_file_name); % loaded variable: Data.
        load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
        size_of_ECG_2 = size(Data,1);
        
        if ECG_end_idx > size_of_ECG_2
           disp('The end idx is greater than second ECG 1-hour size, check!');
           keyboard;
        end
        ECG_clip_2 = Data(1:ECG_end_idx,2);
        ECG_clip_2_time = Data(1:ECG_end_idx,1);
        ECG_clip_2_Billal_filt = Billal_ECG_filt_1_hr_this(1:ECG_end_idx,2);
        ECG_clip_2_Billal_peak = Billal_ECG_peak_1_hr_this(1:ECG_end_idx,1);

        ECG_raw_data = [ECG_clip_1;ECG_clip_2];
        ECG_time = [ECG_clip_1_time;ECG_clip_2_time];

        fprintf('ECG override two segments, seg idx %d and %d. \n',ECG_seg_idx - 1,ECG_seg_idx);
        % I copied from 'main_ECG_only_plotting.m'
        x = ECG_time;
        x(isnan(x)) = []; %  remove NaN rows.
        v = ECG_raw_data;
        v(isnan(v)) = []; %  remove NaN rows.
        if isempty(x) || isempty(v) % no remaining data left
            fprintf('No data for ECG segment %03d. Stop the for loop. \n', ii);
            keyboard; % stop the loop.
        else

        end
        xq = x(1):1/fs_ECG:x(end); % sampling frequency could be 250 +- 2 Hz.
        xq = xq(:); % turn row vector into column vector.
        vq1 = interp1(x,v,xq);
        ECG_interp1_data = vq1; % new interpolated ECG
        ECG_time = xq;
        clear x v xq vq1; % Dong: delete large variables, reduce the size of workspace.
        ECG_raw_data = ECG_interp1_data; % Dong: From now on, raw ECG is the interpolated ECG.
        clear ECG_interp1_data; % Dong: delete large variables, reduce the size of workspace.
        
       % I won't check the interpolation again on ECG Billal's
       % data, because I have interpolated them while generating
       % them. 01/01/2021.
       ECG_Billal_filt = [ECG_clip_1_Billal_filt;ECG_clip_2_Billal_filt];
       ECG_Billal_peak = [ECG_clip_1_Billal_peak;ECG_clip_2_Billal_peak + size(ECG_clip_1)]; % remember to check this peak location issue.
       if isempty(ECG_Billal_peak)
           ECG_Billal_HR = 0;
       else
           ECG_Billal_HR = 60 ./ (diff(ECG_Billal_peak) ./ fs_ECG);
       end
    else % only one ECG 1-hr segment is involved.
        ECG_seg_idx = align_output.T_2_ECG_one_hr_idx(1);
        if ECG_AF_trial_flag
            ECG_seg_name = [ECG_seg_path,filesep,ECG_patch_ID,'_',num2str(ECG_seg_idx,'%03d')];
            ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',ECG_patch_ID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
        else
            ECG_seg_name = [ECG_seg_path,filesep,'Pulsewatch',ECG_patch_ID,'_',num2str(ECG_seg_idx,'%03d')];
            ECG_Billal_file_name = strcat(Patch_ECG_Billal_Peak_1_hr_path,filesep,'ECG_Billal_peak_1_hr_',ECG_patch_ID,'_seg_',num2str(ECG_seg_idx,'%03d'),'.mat');% ECG_Billal_peak_1_hr_036A_seg_001.mat
        end
        ECG_file_name = ECG_seg_name;
        load(ECG_file_name); % loaded variable: Data.
        load(ECG_Billal_file_name); % loaded var: Billal_ECG_filt_1_hr_this, Billal_ECG_HR_1_hr_this, Billal_ECG_peak_1_hr_this, ECG_time_1_hr_this.
        ECG_raw_data = Data(ECG_start_idx:ECG_end_idx,2);
        ECG_time = Data(ECG_start_idx:ECG_end_idx,1);
                
        % I copied from 'main_ECG_only_plotting.m'
        x = ECG_time;
        x(isnan(x)) = []; %  remove NaN rows.
        v = ECG_raw_data;
        v(isnan(v)) = []; %  remove NaN rows.
        if isempty(x) || isempty(v) % no remaining data left
            fprintf('No data for ECG segment %03d. Stop the for loop. \n', ii);
            keyboard; % stop the loop.
        else

        end
        xq = x(1):1/fs_ECG:x(end); % sampling frequency could be 250 +- 2 Hz.
        xq = xq(:); % turn row vector into column vector.
        vq1 = interp1(x,v,xq);
        ECG_interp1_data = vq1; % new interpolated ECG
        ECG_time = xq;
        clear x v xq vq1; % Dong: delete large variables, reduce the size of workspace.
        ECG_raw_data = ECG_interp1_data; % Dong: From now on, raw ECG is the interpolated ECG.
        clear ECG_interp1_data; % Dong: delete large variables, reduce the size of workspace.
        
           % I won't check the interpolation again on ECG Billal's
           % data, because I have interpolated them while generating
           % them. 01/01/2021.
           ECG_Billal_filt = Billal_ECG_filt_1_hr_this(ECG_start_idx:ECG_end_idx,1);
           ECG_Billal_peak = Billal_ECG_peak_1_hr_this(ECG_start_idx:ECG_end_idx,1);
           ECG_Billal_peak = ECG_Billal_peak - ECG_start_idx + 1; % absolute loc for this 30-sec seg.
           if isempty(ECG_Billal_peak)
               ECG_Billal_HR = 0;
           else
               ECG_Billal_HR = 60 ./ (diff(ECG_Billal_peak) ./ fs_ECG);
           end
    end
    ECG_raw_data = ECG_raw_data(:); % make sure output is column vector.
    ECG_time = ECG_time(:); % make sure output is column vector.
    ECG_Billal_filt = ECG_Billal_filt(:);
    ECG_Billal_peak = ECG_Billal_peak(:);
    ECG_Billal_HR = ECG_Billal_HR(:);
end
