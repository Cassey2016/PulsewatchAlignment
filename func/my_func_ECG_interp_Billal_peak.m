function [Billal_peak_in_index,Billal_ECG_peak_1_hr_this] = my_func_ECG_interp_Billal_peak(Billal_ECG_peak_1_hr_this,...
    ECG_time_interp,...
    fs_ECG,...
    ECG_time_original)
% First, convert sample location into time in second.
rm_idx = find(Billal_ECG_peak_1_hr_this > size(ECG_time_interp,1));
if ~isempty(rm_idx)
    Billal_ECG_peak_1_hr_this(rm_idx) = [];
end
Billal_peak_in_time = ECG_time_original(Billal_ECG_peak_1_hr_this);

Billal_peak_in_index = NaN(size(Billal_peak_in_time,1),1);
% ECG_time_interp_reset = ECG_time_interp - ECG_time_interp(1); % I don't know if I should use ECG_time_interp(1) or ECG_time(1) for resetting the beginning. 05/12/2022.
for ii = 1:size(Billal_peak_in_time,1)
    % Second, find the closest the sample index of the closet time point in
    % the interpolated ECG time.
    [~,Billal_peak_in_index(ii,1)] = min(abs(ECG_time_interp-Billal_peak_in_time(ii,1)));
end

% Done for converting Billal's ECG peak to the new interpolated time.
end