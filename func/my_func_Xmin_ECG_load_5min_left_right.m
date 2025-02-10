%% ============================ functions =================================
function [ECG_Xmin_sig,...
    ECG_Xmin_time,...
    ECG_Xmin_seg_idx,...
    ECG_Xmin_seg_pt,...
    exact_align_idx] = my_func_Xmin_ECG_load_5min_left_right(PPG_start_time,...
                            PPG_end_time,...
                            each_ECG_start_time,...
                            each_ECG_end_time,...
                            show_ECG_min_left,...
                            show_ECG_min_right,...
                            output_ECG_file_name,...
                            ECG_path,...
                            fs_ECG,...
                            ECG_init_datetime)
                        
    % This only place I changed from 'my_Xmin_ECG_load'
    % is the right_pt by adding the size of PPG 5min
    % duration.
                        
    % This function is to load X min of ECG from the PPG start time and UMass
    % provided ECG start time.
    % PPG_start_time: datetime.
    % each_ECG_start_time: datetime.
    % each_ECG_end_time: datetime.
    for jj = 1:size(each_ECG_start_time,1)
        curr_ECG_start_time = each_ECG_start_time(jj,1);
        curr_ECG_end_time = each_ECG_end_time(jj,1);

        % the start time within the begin and end of ECG hour.
        if curr_ECG_start_time <= PPG_start_time && curr_ECG_end_time >= PPG_start_time
            exact_ECG_seg = str2num(output_ECG_file_name{jj,1}(end-6:end-4)); % {'314_001.mat'}
            
            load([ECG_path,'\',output_ECG_file_name{jj,1}]); % Data col 1 is time.
            temp_t = Data(:,1);
            temp_t_datetime = seconds(temp_t) + ECG_init_datetime;
            [~,I] = min(abs(temp_t_datetime - PPG_start_time)); % first exact ECG start point.
            exact_ECG_pt = I;
            
            % find if X min is within same ECG segment.
            left_pt = exact_ECG_pt - (floor(show_ECG_min_left) * fs_ECG * 60); % I decided when look before, cut one sample.
%             right_pt = exact_ECG_pt + (floor(show_ECG_min/2) * fs_ECG *60); 
            PPG_dur = seconds(PPG_end_time - PPG_start_time);% the time duration of PPG 5min.
            right_pt = exact_ECG_pt + round(PPG_dur * fs_ECG) + (floor(show_ECG_min_right) * fs_ECG *60); % added PPG time.
            
            len_curr_ECG_seg = size(Data,1); % size of current ECG 1-hr seg.

            if left_pt > 0
                % left pt is inside same ECG seg.
                left_ECG_sig = Data(left_pt:exact_ECG_pt-1,2);
                left_ECG_time = Data(left_pt:exact_ECG_pt-1,1);
                left_ECG_pt = [left_pt:exact_ECG_pt - 1]'; % look left index.
                left_ECG_idx = ones(size(left_ECG_pt,1),1) * exact_ECG_seg; % still within same index.
                if right_pt <= len_curr_ECG_seg
                    % X min are inside same ECG segment.
                    right_ECG_sig = Data(exact_ECG_pt:right_pt,2); % ignore exact pt sample.
                    right_ECG_time = Data(exact_ECG_pt:right_pt,1);
                    right_ECG_pt = [exact_ECG_pt:right_pt]'; % look left index.
                    right_ECG_idx = ones(size(right_ECG_pt,1),1) * exact_ECG_seg; % still within same index.
                
                    ECG_Xmin_sig = [left_ECG_sig;right_ECG_sig];
                    ECG_Xmin_time = [left_ECG_time;right_ECG_time];
                    ECG_Xmin_seg_pt = [left_ECG_pt;right_ECG_pt];
                    ECG_Xmin_seg_idx = [left_ECG_idx;right_ECG_idx];
                    
                    exact_align_idx = size(left_ECG_sig,1) + 1; % the middle point of ECG array.
                    break; % no need to loop next ECG segment.
                else
                    % partial or entire right part is in the right size.
                    right_sig_1 = Data(exact_ECG_pt:len_curr_ECG_seg,2);
                    right_time_1 = Data(exact_ECG_pt:len_curr_ECG_seg,1);
                    right_pt_1 = [exact_ECG_pt:len_curr_ECG_seg]';
                    right_idx_1 = ones(size(right_pt_1,1),1) * exact_ECG_seg;
                    
                    remain_right = right_pt - len_curr_ECG_seg; % remaining samples I need to load from next ECG segment.
                    if jj ~= size(each_ECG_start_time,1)
                        next_ECG_seg = str2num(output_ECG_file_name{jj+1,1}(end-6:end-4)); % {'314_002.mat'}
                        
                        load([ECG_path,'\',output_ECG_file_name{jj+1,1}]); % Data col 1 is time.
                        right_sig_2 = Data(1:remain_right,2);
                        right_time_2 = Data(1:remain_right,1);
                        right_pt_2 = [1:remain_right]';
                        right_idx_2 = ones(size(right_pt_2,1),1) * next_ECG_seg;
                        
                        right_ECG_sig = [right_sig_1;right_sig_2];
                        right_ECG_time = [right_time_1;right_time_2];
                        right_ECG_pt = [right_pt_1;right_pt_2];
                        right_ECG_idx = [right_idx_1;right_idx_2];
                        
                        ECG_Xmin_sig = [left_ECG_sig;right_ECG_sig];
                        ECG_Xmin_time = [left_ECG_time;right_ECG_time];
                        ECG_Xmin_seg_pt = [left_ECG_pt;right_ECG_pt];
                        ECG_Xmin_seg_idx = [left_ECG_idx;right_ECG_idx];
                        
                        exact_align_idx = size(left_ECG_sig,1) + 1;
                        break; % no need to loop next ECG segment.
                    else
                       % there is no more next segment.
                       % so pad zero? or keep the short ECG?
                       % only worried about filtering.
                       
                        ECG_Xmin_sig = [left_ECG_sig;right_sig_1];
                        ECG_Xmin_time = [left_ECG_time;right_time_1];
                        ECG_Xmin_seg_pt = [left_ECG_pt;right_pt_1];
                        ECG_Xmin_seg_idx = [left_ECG_idx;right_idx_1];
                        
                        exact_align_idx = size(left_ECG_sig,1) + 1;
                        break; % no need to loop next ECG segment.
                    end
                end
            else
                % Involved previous ECG seg.
                % load the right side part first.
                right_ECG_sig = Data(exact_ECG_pt:right_pt,2); % ignore exact pt sample.
                right_ECG_time = Data(exact_ECG_pt:right_pt,1);
                right_ECG_pt = [exact_ECG_pt:right_pt]'; % look left index.
                right_ECG_idx = ones(size(right_ECG_pt,1),1) * exact_ECG_seg; % still within same index.

                % store the remaining left part.
                left_sig_2 = Data(1:exact_ECG_pt-1,2);
                left_time_2 = Data(1:exact_ECG_pt-1,1);
                left_pt_2 = [1:exact_ECG_pt-1]';
                left_idx_2 = ones(size(left_pt_2,1),1) * exact_ECG_seg;
                
                remain_left = abs(left_pt);
                if jj ~= 1
                    % not the first ECG segment.
                    prev_ECG_seg = str2num(output_ECG_file_name{jj-1,1}(end-6:end-4)); % {'314_001.mat'}
                    
                    load([ECG_path,'\',output_ECG_file_name{jj-1,1}]); % Data col 1 is time.
                    len_next_ECG_seg = size(Data,1); % size of current ECG 1-hr seg.
                    left_sig_1 = Data(len_next_ECG_seg-remain_left-1:len_next_ECG_seg,2);
                    left_time_1 = Data(len_next_ECG_seg-remain_left-1:len_next_ECG_seg,1);
                    left_pt_1 = [len_next_ECG_seg-remain_left-1:len_next_ECG_seg]';
                    left_idx_1 = ones(size(left_pt_1,1),1) * prev_ECG_seg;
                    
                    left_ECG_sig = [left_sig_1;left_sig_2];
                    left_ECG_time = [left_time_1;left_time_2];
                    left_ECG_pt = [left_pt_1;left_pt_2];
                    left_ECG_idx = [left_idx_1;left_idx_2];

                    ECG_Xmin_sig = [left_ECG_sig;right_ECG_sig];
                    ECG_Xmin_time = [left_ECG_time;right_ECG_time];
                    ECG_Xmin_seg_pt = [left_ECG_pt;right_ECG_pt];
                    ECG_Xmin_seg_idx = [left_ECG_idx;right_ECG_idx];
                    
                    exact_align_idx = size(left_ECG_sig,1) + 1;
                    break; % no need to loop next ECG segment.
                else
                    % This is the first ECG segment.
                    
                    ECG_Xmin_sig = [left_sig_2;right_ECG_sig];
                    ECG_Xmin_time = [left_time_2;right_ECG_time];
                    ECG_Xmin_seg_pt = [left_pt_2;right_ECG_pt];
                    ECG_Xmin_seg_idx = [left_idx_2;right_ECG_idx];
                    
                    exact_align_idx = size(left_idx_2,1) + 1;
                    break;
                end
            end
        else
            % PPG start time not within this segment.
            fprintf('This 30-sec PPG is bot inside ECG seg: %s... \n',output_ECG_file_name{jj,1});
        end
    end
    if ~exist('ECG_Xmin_sig','var')
        disp('All ECG does not contain PPG data.');
%         keyboard;
        ECG_Xmin_sig = [];
        ECG_Xmin_time = [];
        ECG_Xmin_seg_idx = [];
        ECG_Xmin_seg_pt = [];
        exact_align_idx = [];
    end
end

