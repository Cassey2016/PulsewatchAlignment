function [ECG_time,ECG_raw_data] = my_func_ECG_interpolation(ECG_time,ECG_raw_data,fs_ECG)
% This function is interpolation of loaded ECG using its timestamp.
            % I copied from 'main_ECG_only_plotting.m'
            x = ECG_time;
            rm_x_idx = isnan(x);
            v = ECG_raw_data;
            rm_v_idx = isnan(v);
            
            rm_idx = (rm_x_idx | rm_v_idx);
            
%             if ~isequal(rm_x_idx,rm_v_idx) % For UID 021, seg 1673.
%                mystop = 1; 
%             end
            x(rm_idx) = []; %  remove NaN rows.
            v(rm_idx) = []; %  remove NaN rows.
            if isempty(x) || isempty(v) || size(x,1) < 2 || size(v,1) < 2 % no remaining data left
                fprintf('No data for ECG segment. Stop the for loop. \n');
%                 keyboard; % stop the loop.
                return;
            else

            end
            xq = x(1):1/fs_ECG:x(end); % sampling frequency could be 250 +- 2 Hz.
            xq = xq(:); % turn row vector into column vector.
            vq1 = interp1(x,v,xq);
            ECG_interp1_data = vq1; % new interpolated ECG
            ECG_time = xq;
            ECG_raw_data = ECG_interp1_data; % Dong: From now on, raw ECG is the interpolated ECG.
end