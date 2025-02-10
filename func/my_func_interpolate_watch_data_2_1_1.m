% copied from R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Watch_On_Time_Processing\Test_API_1_0_14\main_step02_load_watch_data.m
% Dong, created 08/27/2020.
% current supporting watch API version is: 1.0.14 and 1.0.15. 09/28/2020.
% Dong: modified 02/23/2021.
% Current supporting watch API version is: 2.0.1. 02/23/2021.
function [ideal_PPG,ideal_t_msec,PPG_t_datetime,...
    ideal_t_msec_ver_2,PPG_t_datetime_ver_2,...
    PPG_timestamp_ver_2_raw] = my_func_interpolate_watch_data_2_1_1(PPG_file_buffer,fs_PPG,...
    flag_ACC)
    if ~flag_ACC
        PPG_timestamp = PPG_file_buffer(:,4);
        PPG_raw_buffer = PPG_file_buffer(:,2);
        PPG_timestamp_ver_2_raw = PPG_file_buffer(:,1); % Now it is also in Epoch time.
%         Samsung_HR = PPG_file_buffer(:,3);
    else
        ACC_file_buffer = PPG_file_buffer;
        ACC_timestamp = ACC_file_buffer(:,5); % ACC timestamp
        ACC_x_buffer = ACC_file_buffer(:,2); % In watch service 2.1.1 we have x,y,z.
        ACC_y_buffer = ACC_file_buffer(:,3);
        ACC_z_buffer = ACC_file_buffer(:,4);
        
        
        ACC_raw_buffer = sqrt(ACC_x_buffer.^2 + ACC_y_buffer.^2 + ACC_z_buffer.^2); % ACC raw signal.
        ACC_timestamp_ver_2_raw = ACC_file_buffer(:,1); % unit is millisecond.

        PPG_timestamp = ACC_timestamp;
        PPG_raw_buffer = ACC_raw_buffer;
        PPG_timestamp_ver_2_raw = ACC_timestamp_ver_2_raw;
    end
    %% Do the same thing for ver 2 timestamp (Must run it first due to 'PPG_raw_buffer' repeated named):
    [PPG_t_datetime_ver_2,...
        PPG_raw_buffer_ver_2,...
        PPG_timestamp_ver_2,...
        ideal_PPG_ver_2,...
        ideal_t_msec_ver_2] = my_func_check_interpolation(PPG_timestamp_ver_2_raw,fs_PPG,PPG_raw_buffer);
    %% Epoch timestamp cleanup:
    [PPG_t_datetime,...
        PPG_raw_buffer,...
        PPG_timestamp,...
        ideal_PPG,...
        ideal_t_msec] = my_func_check_interpolation(PPG_timestamp,fs_PPG,PPG_raw_buffer);


    
end

function [PPG_t_datetime,...
    PPG_raw_buffer,...
    PPG_timestamp,...
    ideal_PPG,...
    ideal_t_msec] = my_func_interpolate_timestamp_PPG(diff_PPG_t_msec,...
                                                        fs_PPG,...
                                                        PPG_t_datetime,...
                                                        PPG_timestamp,...
                                                        PPG_raw_buffer)
    cumsum_PPT_t_msec = cumsum(diff_PPG_t_msec); % cumulative sum between sampling time (msec)
    rm_idx = find(cumsum_PPT_t_msec < 0);         % 036_2020_06_27_04_44_53_accel_0003 last sample is wrong time.
    PPG_t_datetime(rm_idx + 1) = []; % remove negative time samples.
    PPG_timestamp(rm_idx + 1) = [];
    PPG_raw_buffer(rm_idx + 1) = [];
    cumsum_PPT_t_msec(rm_idx) = [];
    % linear PPG time msec steps:
    linear_t_msec = [0:1:cumsum_PPT_t_msec(end)];
    linear_t_msec = linear_t_msec(:);
    
    % prepare for PPG interpolation:
    [x,ix] = unique(cumsum_PPT_t_msec); % remove same time stamp.
    v = PPG_raw_buffer(2:end); % PPG is one sample longer than diff.
    v = v(ix); % keep unique value index.
    xq = linear_t_msec;
    vq1 = interp1(x,v,xq); % interpolated PPG.

    % ideal unisampled PPG msec index:
    %ideal_t_msec = [0:(1/fs_PPG*1000):(1/fs_PPG*1000*(fs_PPG*30-1))]; % 30sec into msec.
    ideal_t_msec = [0:(1/fs_PPG*1000):cumsum_PPT_t_msec(end)]; % 30sec into msec.

    ideal_t_msec = ideal_t_msec(:);
    ideal_PPG = vq1(ideal_t_msec+1); % downsample interpolated PPG.

    ideal_t_msec(isnan(ideal_PPG)) = []; % delete NaN entires using ideal_PPG info? 09/28/2020.
%     PPG_t_datetime(isnan(ideal_PPG)) = []; % delete NaN entires using ideal_PPG info? 09/28/2020.
    ideal_PPG(isnan(ideal_PPG)) = [];
    
    % sometimes ideal_PPG is less than 30*fs_PPG long, so need to prune it.
    if size(ideal_PPG,1) < fs_PPG * 30
        % have more sample points than expected.
        add_pt = fs_PPG * 30 - size(ideal_PPG,1);
        ideal_PPG = [ideal_PPG;ones(add_pt,1)*ideal_PPG(end);];
        ideal_t_msec = [ideal_t_msec;(ideal_t_msec(end)+1:ideal_t_msec(end) + abs(add_pt))']; % I am only adding 1 millisecond by a time.
    elseif size(ideal_PPG,1) > fs_PPG * 30
        % have fewer sample points than expected.
        remove_pt = size(ideal_PPG,1) - fs_PPG * 30;
        ideal_PPG = ideal_PPG(remove_pt+1:end);
        ideal_t_msec = ideal_t_msec(remove_pt+1:end);
    end
    

end

function [PPG_t_datetime,...
            PPG_raw_buffer,...
            PPG_timestamp,...
            ideal_PPG,...
            ideal_t_msec] = my_func_check_interpolation(PPG_timestamp,fs_PPG,PPG_raw_buffer)
    % convert Epoch time (msec) to MATLAB datetime (msec):
    PPG_t_datetime = datetime(PPG_timestamp./1000,'ConvertFrom','posixTime','Format','dd-MMM-yyyy HH:mm:ss.SSS','TimeZone','America/New_York'); % 
    diff_PPG_t_msec = milliseconds(diff(PPG_t_datetime)); % calculate the sampling time (msec) between two samples.

    [PPG_t_datetime,...
    PPG_raw_buffer,...
    PPG_timestamp,...
    ideal_PPG,...
    ideal_t_msec] = my_func_interpolate_timestamp_PPG(diff_PPG_t_msec,...
                                                        fs_PPG,...
                                                        PPG_t_datetime,...
                                                        PPG_timestamp,...
                                                        PPG_raw_buffer);

        % fixing PPG_t_datetime is shorter than ideal PPG length.
    if size(PPG_t_datetime,1) < size(ideal_PPG,1)
        add_pt = fs_PPG * 30 - size(PPG_t_datetime,1);
        PPG_t_datetime = [PPG_t_datetime;((PPG_t_datetime(end)+milliseconds(1)):milliseconds(1):(PPG_t_datetime(end)+milliseconds(abs(add_pt))))']; % so time plue 1 millisecond. Remember to add the stepping of 1 millisecond. 09/28/2020.
    elseif size(PPG_t_datetime,1) > size(ideal_PPG,1)
        remove_pt = size(PPG_t_datetime,1) - fs_PPG * 30;
        PPG_t_datetime = PPG_t_datetime(remove_pt+1:end);
    end
end