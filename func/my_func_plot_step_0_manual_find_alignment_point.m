
% function my_find_align_pt_ECG_PPG_5min(PPG_raw_buffer,...
%     PPG_t_datetime,...
%     output_WEPD,...
%     Ref_ECG_buffer,...
%     refECG_pkloc,...
%     wbwrefHR,...
%     ECG_Xmin_time,...
%     ECG_Xmin_sig,...
%     exact_align_idx,...
%     ECG_init_datetime,...
%     fs_ECG, fs_PPG)
function fig_h = my_func_plot_step_0_manual_find_alignment_point(PPG_sig_5min,...
    PPG_filt_sig_5min,...
    PPG_time_5min,...
    PPG_pkloc_5min,...
    PPG_HR_5min,...
    Ref_ECG_buffer,...
    refECG_pkloc,...
    wbwrefHR,...
    ECG_Xmin_time,...
    ECG_Xmin_sig,...
    exact_align_idx,...
    ECG_init_datetime,...
    fs_ECG, fs_PPG,...
    title_name,...
    PPG_filt_sig_5min_1,...
    PPG_pkloc_5min_1,...
    PPG_HR_5min_1,...
    PPG_filt_sig_5min_2,...
    PPG_pkloc_5min_2,...
    PPG_HR_5min_2,...
    HR_panel_text,...
    HR_panel_text_color)

% PPG_peak_loc_WEPD = output_WEPD.PPG_peak_loc_WEPD;
% PPGHR = output_WEPD.HR_PPG_WEPD;
% PPG_plot_sig = output_WEPD.smooth_PPG_WEPD;
PPG_peak_loc_WEPD = PPG_pkloc_5min;
PPGHR = PPG_HR_5min;
PPG_plot_sig = PPG_filt_sig_5min;
PPG_t_datetime = PPG_time_5min;
PPG_raw_buffer = PPG_sig_5min;

fig_x = [1400,1000]; % pixels. figure's [width height]
fig_h = figure('units','normalized','outerposition',[0 0 1 1]); % [left bottom width height] % To Fahimeh: I know we have different size of monitor, so I want to see if by defining plot pixel size can unify the image size between our monitors.
left_color = [0 0 0];
right_color = [0 0 0];
%     set(mysavefigure,'defaultAxesColorOrder',[left_color; right_color]);
color_ECG = [0.839, 0, 0]; % darkest color
color_PPG_WEPD = [0.090, 0, 0.980]; % gem blue.
color_PPG_WEPD_mark = [0.619, 0.588, 0.952]; % light gem blue.
% color_PPG_spec = [0.5 0.5 0.5];
% color_PPG_fast = [0.7 0.7 0.7];
subplot_num = 8;

t_plot_ECG = seconds(ECG_Xmin_time) + ECG_init_datetime;
%% subplot 1: raw ECG with peaks.
ax(1) = subplot(subplot_num,1,1:2);
plot(t_plot_ECG(refECG_pkloc),ECG_Xmin_sig(refECG_pkloc),'r.','markersize',18);hold on;
plot(t_plot_ECG,ECG_Xmin_sig,'color',color_ECG,'linewidth',1.4);
if length(t_plot_ECG)>1
    xlim([t_plot_ECG(exact_align_idx) t_plot_ECG(exact_align_idx+30*fs_ECG)]); % plot 30 secs from aligned point.
    xline(t_plot_ECG(exact_align_idx),'--r',{'Align','UMass Time'});
end
ylabel('Raw ECG');
sgtitle(title_name, 'Interpreter', 'none'); % no more underscore = subscript.
%% subplot 2 : Raw PPG
ax(2) = subplot(subplot_num,1,3:4);
plot(PPG_t_datetime,PPG_raw_buffer,'color',color_PPG_WEPD,'linewidth',2);
xlim([PPG_t_datetime(1) PPG_t_datetime(end)]);
hYlabel_2 = ylabel({'Raw','PPG'},'FontSize',24);
grid minor;
set(gca,'xticklabel',{[]});


%% subplot 3: Filtered PPG with peak locations.
ax(3) = subplot(subplot_num,1,5:6);
norm_PPG_1 = (PPG_plot_sig - mean(PPG_plot_sig)) / std(PPG_plot_sig); % for putting several PPG signals in one subplot
plot(PPG_t_datetime(PPG_peak_loc_WEPD),norm_PPG_1(PPG_peak_loc_WEPD),'.','color',color_PPG_WEPD_mark,'markersize',18);hold on;
hold on;
plot(PPG_t_datetime,norm_PPG_1,'color',color_PPG_WEPD,'linewidth',2,'DisplayName','WEPD');

% % comparison peak detection:
% color_PPG_2 = [0, 0.760, 0.113]; % grass green.
% color_PPG_2_mark = [0.407, 0.674, 0.486]; % grey level green.
% color_PPG_3 = [0.5, 0.5, 0.5]; % dark grey.
% color_PPG_3_mark = [0.65, 0.65, 0.65]; % lighter grey.
% norm_PPG_2 = (PPG_filt_sig_5min_1 - mean(PPG_filt_sig_5min_1)) / std(PPG_filt_sig_5min_1);
% norm_PPG_3 = (PPG_filt_sig_5min_2 - mean(PPG_filt_sig_5min_2)) / std(PPG_filt_sig_5min_2);
% 
% plot(PPG_t_datetime(PPG_pkloc_5min_1),norm_PPG_2(PPG_pkloc_5min_1),'.','color',color_PPG_2_mark,'markersize',18);hold on;
% plot(PPG_t_datetime,norm_PPG_2,'color',color_PPG_2,'linewidth',2,'DisplayName','(5)Elgendi 2');
% 
% plot(PPG_t_datetime(PPG_pkloc_5min_2),norm_PPG_3(PPG_pkloc_5min_2),'.','color',color_PPG_3_mark,'markersize',18);hold on;
% plot(PPG_t_datetime,norm_PPG_3,'color',color_PPG_3,'linewidth',2,'DisplayName','(7)Elgendi 4');

% xlim, xtick, ylabel for this subplot.
xlim([PPG_t_datetime(1) PPG_t_datetime(end)]);
hYlabel_2 = ylabel({'WEPD','PPG'},'FontSize',24);
grid minor;
set(gca,'xticklabel',{[]});
legend('show');
%% subplot 4: ECG HR
ax(4) = subplot(subplot_num,1,7:8);
if length(refECG_pkloc) > 1 % in case there is an error, 10/10/2018
    plot(t_plot_ECG(refECG_pkloc),wbwrefHR,'o-','color','r','markersize',5,'linewidth',1,'DisplayName','ECG HR');
    hold on;
end
if length(t_plot_ECG)>1 
%     xlim([t_plot_ECG(exact_align_idx) t_plot_ECG(exact_align_idx+30*fs_ECG)]); % plot 30 secs from aligned point.
    xline(t_plot_ECG(exact_align_idx),'--r',{'Align','UMass Time'});
end
% if min(max(PPGHR), max(wbwrefHR))> min(PPGHR)
%     ylim([min(PPGHR)  min(max(PPGHR), max(wbwrefHR))])
% else
%     ylim([min(PPGHR) max(PPGHR)])
% end
% linkaxes([ax(1), ax(4)],'x')
% 

hYlabel_6 = ylabel('HR (BPM)' , 'FontSize',24);

%% subplot 6: PPG HR
% ax(6) = subplot(subplot_num,1,11:12);
% plot(PPG_t_datetime(PPG_peak_loc_WEPD(2:end)),PPGHR,'o-','linewidth',2,'markersize',10,'color',color_PPG,'MarkerEdgeColor',color_PPG,'DisplayName','WEPD HR');
plot(PPG_t_datetime(PPG_peak_loc_WEPD),PPGHR,'o-','linewidth',1,'markersize',5,'color',color_PPG_WEPD,'MarkerEdgeColor',color_PPG_WEPD,'DisplayName','WEPD HR');
% comparison PPG peak detection HR:
if length(PPG_HR_5min_1)>1 
% % % %     plot(PPG_t_datetime(PPG_pkloc_5min_1),PPG_HR_5min_1,'o-','color',color_PPG_2,'markersize',5,'linewidth',1,'DisplayName','(5)Elgendi 2 HR');
end

if length(PPG_HR_5min_2)>1 
% % % %     plot(PPG_t_datetime(PPG_pkloc_5min_2),PPG_HR_5min_2,'o-','color',color_PPG_3,'markersize',5,'linewidth',1,'DisplayName','(7)Elgendi 4 HR');
end

linkaxes([ax],'x')
legend('show');
% if min(max(PPGHR), max(wbwrefHR))> min(PPGHR)
%     ylim([min(PPGHR)  min(max(PPGHR), max(wbwrefHR))])
% else
%     ylim([min(PPGHR) max(PPGHR)])
% end
xlim([PPG_t_datetime(1) - minutes(0.5), PPG_t_datetime(end) + minutes(0.5)]);
ylim([median(wbwrefHR)-40 median(wbwrefHR)+40]);
% ylim([60 90]); % change this based on each PPG segment.
    query_xlim = xlim;
    query_ylim = ylim;
    range_xlim = query_xlim(1,2) - query_xlim(1,1); % it should be a row vector.
    range_ylim = query_ylim(1,2) - query_ylim(1,1); % it should be a row vector.
    text_x = query_xlim(1,1) + range_xlim/5;
    text_y = query_ylim(1,1) + range_ylim/3;
    text(text_x,text_y,HR_panel_text,'Color',HR_panel_text_color,'FontSize',14); % add indication text in HR panel.

% 10/07/2020: copied from R:\ENGR_Chon\Dong\MATLAB\Pulsewatch_alignment\plotting\func\my_func_plot_PPG_ACC.m
    % Customize Data Tip Text
    dcm = datacursormode; % set custom cursor text.
    dcm.Enable = 'on';
    dcm.UpdateFcn = @displayCoordinates;
end

function txt = displayCoordinates(~,info)
% My custom cursor text.
    x = info.Target.XData(info.Target.Children.DataIndex);
    y = info.Target.YData(info.Target.Children.DataIndex);
    txt = {['X: ',datestr(x,'mm/dd/yyyy HH:MM:SS.FFF')], ['Y: ', num2str(y),' BPM']};
end