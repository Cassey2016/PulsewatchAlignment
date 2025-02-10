function [T_2_ECG_one_hr_idx,...
        span_two_ECG_flag,...
        T_9_pad_zero_front,...
        T_10_pad_zero_end,...
        T_4_ECG_end_idx,...
        T_3_ECG_start_idx,...
        T_8_ECG_contain_empty] = my_func_find_ECG_idx(ECG_path,...
                                    output_ECG_file_name,...
                                    each_ECG_start_time,...
                                    each_ECG_end_time,...
                                    T_2_ECG_one_hr_idx,...
                                    span_two_ECG_flag,...
                                    T_9_pad_zero_front,...
                                    T_10_pad_zero_end,...
                                    T_4_ECG_end_idx,...
                                    T_3_ECG_start_idx,...
                                    T_8_ECG_contain_empty,...
                                    PPG_timestamp_start,...
                                    PPG_timestamp_end,...
                                    ECG_init_datetime,...
                                    fs_PPG,...
                                    LinearInterp_path)
    for jj = 1:size(output_ECG_file_name,1)
        current_ECG_start_time = each_ECG_start_time(jj,1);
        current_ECG_end_time = each_ECG_end_time(jj,1);
        
        if current_ECG_start_time <= PPG_timestamp_start && current_ECG_end_time >= PPG_timestamp_start
            % ECGstart <= PPGstart <= ECGend
            % ECG started in this segment:
            T_2_ECG_one_hr_idx = str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % remove .txt from the end.
            if current_ECG_start_time <= PPG_timestamp_end && current_ECG_end_time >= PPG_timestamp_end
                % ECGstart <= PPGstart <= PPGend <= ECGend
               % ECG ended in same segment:
               span_two_ECG_flag = false;
               % find end ECG index:
               load([ECG_path,filesep,output_ECG_file_name{jj,1}]);% load ecg first
               load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]);

                temp_t = precise_time_linear(:,1);%Data(:,1);
                temp_t_datetime = seconds(temp_t) + ECG_init_datetime;

                [~,I] = min(abs(temp_t_datetime - PPG_timestamp_end)); % remember to use absolute value to find minimum.
                T_4_ECG_end_idx = I;

                [~,I] = min(abs(temp_t_datetime - PPG_timestamp_start));
                T_3_ECG_start_idx = I;
                break;
            else
                % ECGstart <= PPGstart <= ECGend <= PPGend
                span_two_ECG_flag = true;
                % find start ECG index:
                if jj ~= size(output_ECG_file_name,1) % not the last file.
                    % if this is not the last ECG segment (PPG is shorter than ECG recording)
                    load([ECG_path,filesep,output_ECG_file_name{jj+1,1}]);% load ecg first
                    load([LinearInterp_path,filesep,output_ECG_file_name{jj+1,1}]);
                    % find next ECG first:
                   temp_t = precise_time_linear(:,1);%Data(:,1);
                   temp_t_datetime = seconds(temp_t) + ECG_init_datetime;

                   [~,I] = min(abs(temp_t_datetime - PPG_timestamp_end)); % remember to use absolute value to find minimum.
                   T_4_ECG_end_idx = I;

                   % find start ECG index:
                   load([ECG_path,filesep,output_ECG_file_name{jj,1}]);% load ecg first
                   load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]);
                   temp_t = precise_time_linear(:,1);%Data(:,1);
                   temp_t_datetime = seconds(temp_t) + ECG_init_datetime;

                   [~,I] = min(abs(temp_t_datetime - PPG_timestamp_start));
                   T_3_ECG_start_idx = I;

                   break; % finish finding start and end index, so break the for loop.
                else
                    % this is the last ECG segment (PPG is longer than ECG recording)
                    
                    load([ECG_path,filesep,output_ECG_file_name{jj,1}]);% load this ecg hour.
                    load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]);
                    T_4_ECG_end_idx = size(precise_time_linear,1);%size(Data,1); % end index equal to this ECG length.
                    
                   temp_t = precise_time_linear(:,1);%Data(:,1);
                   temp_t_datetime = seconds(temp_t) + ECG_init_datetime;

                   [~,I] = min(abs(temp_t_datetime - PPG_timestamp_start));
                   T_3_ECG_start_idx = I;
                   if (T_4_ECG_end_idx - T_3_ECG_start_idx) < fs_PPG * 30
                        T_10_pad_zero_end = true;
                        T_8_ECG_contain_empty = true;
                        if current_ECG_start_time <= PPG_timestamp_start
                           % start from the beginning:
                           T_9_pad_zero_front = false;
                        else
                            T_9_pad_zero_front = true;
                        end
                   else
                       % ECG fills entire PPG:
                       T_10_pad_zero_end = false;
                       T_8_ECG_contain_empty = false;
                       if current_ECG_start_time <= PPG_timestamp_start
                           % start from the beginning:
                           T_9_pad_zero_front = false;
                       else
                           T_9_pad_zero_front = true;
                       end
                   end
                   % this break is crutial, if you don't put it here, code
                   % will execute later lines.
                   break; % finish finding start and end index, so break the for loop.
                end
            end

        else
            
            % Either PPGstart < ECGstart or ECGstart < ECGend < PPGstart
            % The PPG starts before ECG, so the PPG end should within the
            % ECG hour.
            if jj == size(output_ECG_file_name,1)
                % last ECG segment, no more ECG segments.
               if current_ECG_end_time < PPG_timestamp_start
                   % ECGstart < ECGend < PPGstart
                        % the end of ECG is earlier than PPG start,
                       % means ECG recording is shorter than PPG.
                       T_10_pad_zero_end = true;
                       T_9_pad_zero_front = true;
                       T_8_ECG_contain_empty = true;

                       % No ECG within PPG.
                       T_4_ECG_end_idx = NaN;
                       T_3_ECG_start_idx = NaN;
               else
                   % PPGstart < ECGstart
                  if current_ECG_end_time >= PPG_timestamp_end
                      % PPGstart < ECGstart < PPGend <= ECGend
                       T_9_pad_zero_front = true; % need to pad zero at the beginning and ending.
                       T_10_pad_zero_end = false; % need to pad zero at the beginning and ending.
                       T_8_ECG_contain_empty = true;
                  else
                       % PPG start < ECGstart < ECGend < PPGend
                       T_9_pad_zero_front = true;
                       T_10_pad_zero_end = true;
                       T_8_ECG_contain_empty = true;
                  end
                   % find end ECG index:
                   load([ECG_path,filesep,output_ECG_file_name{jj,1}]);% load ecg first
                   load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]);

                   temp_t = precise_time_linear(:,1);%Data(:,1);
                   temp_t_datetime = seconds(temp_t) + ECG_init_datetime;

                   [~,I] = min(abs(temp_t_datetime - PPG_timestamp_end)); % remember to use absolute value to find minimum.
                   T_4_ECG_end_idx = I;

                   [~,I] = min(abs(temp_t_datetime - PPG_timestamp_start));
                   T_3_ECG_start_idx = I;
                   T_2_ECG_one_hr_idx = str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % remove .txt from the end.
                   break; % finish finding end index (though no start index), so break the for loop.
               end
            else
                
                if current_ECG_start_time < PPG_timestamp_end && current_ECG_end_time >= PPG_timestamp_start
                    % part of the ECG is within the PPG start and end time.
                    % copied from above.
                    T_2_ECG_one_hr_idx = str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % remove .txt from the end.
                    span_two_ECG_flag = false;
                    % find end ECG index:
                    load([ECG_path,filesep,output_ECG_file_name{jj,1}]);% load ecg first
                    load([LinearInterp_path,filesep,output_ECG_file_name{jj,1}]);

                    temp_t = precise_time_linear(:,1);%Data(:,1);
                    temp_t_datetime = seconds(temp_t) + ECG_init_datetime;

                    [~,I] = min(abs(temp_t_datetime - PPG_timestamp_end)); % remember to use absolute value to find minimum.
                    T_4_ECG_end_idx = I;

                    [~,I] = min(abs(temp_t_datetime - PPG_timestamp_start));
                    T_3_ECG_start_idx = I;
                    break;
                else
                    % not last ECG segment, keep searching:
                    continue
                end
            end
        end
    end
    
    if isnan(T_3_ECG_start_idx) 
        % ECG start index is still not assigned:
        % PPG recording is longer that ECG, and this 30-sec PPG does not
        % have reference ECG.
        T_8_ECG_contain_empty = true;
    end
end
