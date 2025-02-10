% copied from R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_branch\Pulsewatch\Watch_On_Time_Processing\Test_API_1_0_14\main_step02_load_watch_data.m
% Dong, created 08/27/2020.
% current supporting watch API version is: 1.0.14 and 1.0.15. 09/28/2020.
% Dong: modified 02/23/2021.
% Current supporting watch API version is: 2.0.1. 02/23/2021.
function [ideal_PPG,ideal_t_msec,PPG_t_datetime,...
    ideal_t_msec_ver_2,PPG_t_datetime_ver_2,...
    PPG_timestamp_ver_2_raw] = my_func_interpolate_watch_data(PPG_file_buffer,fs_PPG,...
    flag_ACC,...
    PPG_timestamp_ver_2_start_datetime,...
    PPG_timestamp_ver_2_start_msec)
    debug_plot_flag = false;

    new_ver_flag = false;
    if size(PPG_file_buffer,2) > 3% more than one PPG time stamp.
        PPG_timestamp = PPG_file_buffer(:,4);
        PPG_raw_buffer = PPG_file_buffer(:,2);
        PPG_timestamp_ver_2_raw = PPG_file_buffer(:,1); % unit is millisecond.
        PPG_timestamp_ver_2 = PPG_timestamp_ver_2_raw - PPG_timestamp_ver_2_start_msec; % reset the start.
%         Samsung_HR = PPG_file_buffer(:,3);
        new_ver_flag = true; % ver 2.0.1 testing.
    else
        if exist('flag_ACC','var')
            if flag_ACC
                if size(PPG_file_buffer,2) > 2
                    PPG_timestamp = PPG_file_buffer(:,3); % ACC timestamp
                    PPG_raw_buffer = PPG_file_buffer(:,2); % ACC raw signal.
                    PPG_timestamp_ver_2_raw = PPG_file_buffer(:,1); % unit is millisecond.
                    PPG_timestamp_ver_2 = PPG_timestamp_ver_2_raw - PPG_timestamp_ver_2_start_msec; % reset the start.
                    
                    new_ver_flag = true; % ver 2.0.1 testing.
                else
                    PPG_timestamp = PPG_file_buffer(:,1);
                    PPG_raw_buffer = PPG_file_buffer(:,2);
                    PPG_timestamp_ver_2_raw = [];
                end
            else
                PPG_timestamp = PPG_file_buffer(:,1);
                PPG_raw_buffer = PPG_file_buffer(:,2);
                PPG_timestamp_ver_2_raw = [];
            end
        else % in case 'flag_ACC' was not input.
            PPG_timestamp = PPG_file_buffer(:,1);
            PPG_raw_buffer = PPG_file_buffer(:,2);
            PPG_timestamp_ver_2_raw = [];
        end
    end
    %% Epoch timestamp cleanup:
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
        PPG_t_datetime = PPG_t_datetime(1:end-remove_pt);% 01/22/2023: I think I made a mistake here. (remove_pt+1:end);
    end
    %% CLOCK_MONOTONIC timestamp cleanup:
    if new_ver_flag
        diff_PPG_t_msec_ver_2 = diff(PPG_timestamp_ver_2); % the unit is already millisecond.
        % Compare two timestamps
        PPG_timestamp_match = isequal(diff_PPG_t_msec,diff_PPG_t_msec_ver_2);
        if ~PPG_timestamp_match
            disp('New timestamp does not match old timestamp, check!');
%             keyboard;
%             figure;
%             plot(diff_PPG_t_msec);
%             hold on;
%             plot(diff_PPG_t_msec_ver_2);
        end
        % convert new timestamps into actual t_msec.
        % pass inside a ver 2 timestamp of the start segment.
        cumsum_PPT_t_msec_ver_2 = cumsum(diff_PPG_t_msec);
        PPG_t_datetime_ver_2 = PPG_timestamp_ver_2_start_datetime + milliseconds(PPG_timestamp_ver_2);
        [PPG_t_datetime_ver_2,...
        ~,...
        PPG_timestamp_ver_2,...
        ideal_PPG_ver_2,...
        ideal_t_msec_ver_2] = my_func_interpolate_timestamp_PPG(diff_PPG_t_msec_ver_2,...
                                                            fs_PPG,...
                                                            PPG_t_datetime_ver_2,...
                                                            PPG_timestamp_ver_2,...
                                                            PPG_raw_buffer);

        % fixing PPG_t_datetime is shorter than ideal PPG length.
        if size(PPG_t_datetime_ver_2,1) < size(ideal_PPG_ver_2,1)
            add_pt = fs_PPG * 30 - size(PPG_t_datetime_ver_2,1);
            PPG_t_datetime_ver_2 = [PPG_t_datetime_ver_2;((PPG_t_datetime_ver_2(end)+milliseconds(1)):milliseconds(1):(PPG_t_datetime_ver_2(end)+milliseconds(abs(add_pt))))']; % so time plue 1 millisecond. Remember to add the stepping of 1 millisecond. 09/28/2020.
        elseif size(PPG_t_datetime_ver_2,1) > size(ideal_PPG,1)
            remove_pt = size(PPG_t_datetime_ver_2,1) - fs_PPG * 30;
            PPG_t_datetime_ver_2 = PPG_t_datetime_ver_2(remove_pt+1:end); % This could be wrong. It should be (1:remove_pt). 01/28/2023.
        end
    end

    if debug_plot_flag
        figure('units','normalized','outerposition',[0 0 1 1]);
        ax(1) = subplot(2,1,1);
        plot(x,v,'o-','displayname','raw PPG');
        hold on;
        plot(ideal_t_msec,ideal_PPG,'o-','displayname','interpolated PPG');
        title('Downsampled PPG after interpolation on raw PPG');
        ylabel('Arbitrary Unit');
        legend('show');

        ax(2) = subplot(2,1,2);
        plot(cumsum_PPT_t_msec,diff_PPG_t_msec,'o-');
        title('sampling time interval of raw PPG');
        ylabel('millisecond');
        xlabel('Time (msec)');
        linkaxes(ax,'x');

        pause;
        close all;
    end
    
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