% This function stored the path of watch data that are pruned by Dong,
% manually based on the experiment start and end time.
% Dong, created on 08/26/2020.
% Last edited: 08/26/2020.
function [test_ECG_path_A,...
    Patch_A_start_time,...
    test_ECG_path_B,...
    Patch_B_start_time,...
    test_ECG_path_C,...
    Patch_C_start_time,...
    UMass_type,...
    LinearInterp_root] = my_func_UID_ECG_final_path(UID,HPC_flag,root_data_path,root_output_path)
if HPC_flag
    clinical_ECG_root = [root_data_path,filesep,'Patch_ECG_Converted_Data'];
    AF_ECG_root = [root_data_path,filesep,'AF_trial',filesep,'Patch_ECG_Converted_Data'];
    LinearInterp_root = [root_data_path,filesep,'UMass_Patch_Adjuciation',filesep,'Linear_Interp_Timestamp'];
else
    clinical_ECG_root = [root_data_path,filesep,'Patch_ECG_Converted_Data'];
    AF_ECG_root = [root_data_path,filesep,'AF_trial',filesep,'Patch_ECG_Converted_Data'];
    LinearInterp_root = [root_output_path,filesep,'UMass_Patch_Adjuciation',filesep,'Linear_Interp_Timestamp'];
end
switch UID
    case '001'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = '09/03/2019 10:22:52.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '09/10/2019 17:57:00.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '002'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/03/2019 15:45:45.000'; % 24 hours time.  
        Patch_A_start_time = '09/03/2019 15:43:45.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '09/11/2019 09:37:55.200'; % 24 hours time.
        Patch_B_start_time = '09/11/2019 09:27:31.200'; % 24 hours time.
        UMass_type = ['NSR'];
    case '003'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/10/2019 14:52:06.000'; % 24 hours time.
        Patch_A_start_time = '09/10/2019 14:51:55.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '09/17/2019 10:57:16.000'; % 24 hours time.
        Patch_B_start_time = '09/17/2019 10:56:57.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '004'
        keyboard;
    case '005'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/16/2019 13:52:00.000'; % 24 hours time.
        Patch_A_start_time = '09/16/2019 13:53:06.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '09/23/2019 10:02:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '006'
        keyboard;
    case '007'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/20/2019 10:35:49.000'; % 24 hours time.
        Patch_A_start_time = '09/20/2019 10:59:29.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '09/27/2019 07:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '009'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/07/2019 11:00:45.000'; % 24 hours time.
         Patch_A_start_time = '10/07/2019 10:59:30.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '10/14/2019 10:30:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '011'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/21/2019 12:26:09.000'; % 24 hours time.
        Patch_A_start_time = '10/21/2019 12:25:33.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '10/28/2019 18:58:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '012'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/31/2019 11:52:30.500'; % 24 hours time.
        Patch_A_start_time = '10/31/2019 11:51:38.500'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '11/07/2019 09:14:44.000'; % 24 hours time.
        Patch_B_start_time = '11/07/2019 09:14:27.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '013'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '11/06/2019 11:41:35.000'; % 24 hours time.
        Patch_A_start_time = '11/06/2019 11:41:25.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '11/14/2019 13:45:31.000'; % 24 hours time.
        Patch_B_start_time = '11/14/2019 13:45:24.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '014'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '11/12/2019 10:46:00.000'; % 24 hours time.
        Patch_A_start_time = '11/12/2019 10:45:55.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '11/19/2019 15:57:58.000'; % 24 hours time.
        Patch_B_start_time = '11/19/2019 15:56:41.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '017'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '12/04/2019 16:32:00.000'; % 24 hours time.
        Patch_A_start_time = '12/04/2019 16:32:21.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '12/11/2019 09:15:00.000'; % 24 hours time.
        Patch_B_start_time = '12/11/2019 09:18:29.000'; % 24 hours time. % Testing on 05/10/2022
        UMass_type = ['NSR'];
    case '018'
        keyboard;
    case '019'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '01/03/2020 15:06:00.000'; % 24 hours time.
        Patch_A_start_time = '01/03/2020 15:07:00.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '01/10/2020 20:00:00.000'; % 24 hours time.
        Patch_B_start_time = '01/10/2020 19:59:57.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '020'
        test_ECG_path_A = [];%[clinical_ECG_root,'\Pulsewatch',UID,'A'];
        Patch_A_start_time = '';%'01/07/2020 14:47:00.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '01/14/2020 15:31:00.000'; % 24 hours time.
        Patch_B_start_time = '01/14/2020 15:30:32.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '021'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '01/14/2020 16:36:31.500'; % 24 hours time.
        Patch_A_start_time = '01/14/2020 16:35:39.500'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '01/21/2020 17:31:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '022'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '01/22/2020 15:26:32.000'; % 24 hours time.
        Patch_A_start_time = '01/22/2020 15:26:11.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '01/29/2020 15:25:39.594'; % 24 hours time.
        Patch_B_start_time = '01/29/2020 15:25:10.594'; % 24 hours time.
        UMass_type = ['NSR'];
    case '024'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '01/29/2020 13:06:31.500'; % 24 hours time.
        Patch_A_start_time = '01/29/2020 13:05:47.500'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '02/05/2020 18:08:51.600'; % 24 hours time.
        Patch_B_start_time = '02/05/2020 18:08:31.600'; % 24 hours time.
        UMass_type = ['NSR'];    
    case '026'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '02/06/2020 14:49:00.000'; % 24 hours time.
        Patch_A_start_time = '02/06/2020 14:49:31.900'; % 24 hours time.
        test_ECG_path_B = [];%[clinical_ECG_root,'\Pulsewatch',UID,'B'];
        Patch_B_start_time = '';%'02/13/2020 11:45:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '027'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '02/11/2020 14:00:11.200'; % 24 hours time.
        Patch_A_start_time = '02/11/2020 13:59:48.200'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '02/18/2020 10:14:38.660'; % 24 hours time.
        Patch_B_start_time = '02/18/2020 10:14:35.660'; % 24 hours time.
        UMass_type = ['NSR'];
    case '028'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '02/13/2020 13:31:05.000'; % 24 hours time.
        Patch_A_start_time = '02/13/2020 13:30:47.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '02/20/2020 23:13:25.000'; % 24 hours time.
        Patch_B_start_time = '02/20/2020 23:13:24.000'; % 24 hours time.
        test_ECG_path_C = [clinical_ECG_root,filesep,'Pulsewatch',UID,'C'];
%         Patch_C_start_time = '02/21/2020 11:47:30.000'; % 24 hours time.
        Patch_C_start_time = '02/21/2020 11:47:17.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '029'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '02/14/2020 11:35:46.000'; % 24 hours time.
        Patch_A_start_time = '02/14/2020 11:35:45.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '02/21/2020 11:19:31.000'; % 24 hours time.
        Patch_B_start_time = '02/21/2020 11:18:08.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '030'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '02/19/2020 17:10:24.000'; % 24 hours time.
        Patch_A_start_time = '02/19/2020 17:10:05.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '02/26/2020 18:13:21.000'; % 24 hours time.
        Patch_B_start_time = '02/26/2020 18:13:09.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '032'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '02/26/2020 13:58:00.000'; % 24 hours time.
        Patch_A_start_time = '02/26/2020 13:57:32.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '03/04/2020 20:44:48.000'; % 24 hours time.
        Patch_B_start_time = '03/04/2020 20:44:28.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '034'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '03/02/2020 14:00:01.000'; % 24 hours time.
        Patch_A_start_time = '03/02/2020 13:58:38.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '03/09/2020 08:01:03.000'; % 24 hours time.
        Patch_B_start_time = '03/09/2020 8:00:23.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '035'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = '07/24/2020 09:31:59.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '036'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '06/26/2020 13:11:11.273'; % 24 hours time.
        Patch_A_start_time = '06/26/2020 13:10:42.273'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '07/03/2020 08:06:17.141'; % 24 hours time.
        Patch_B_start_time = '07/03/2020 08:05:26.141'; % 24 hours time.
        UMass_type = ['NSR'];
    case '037'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = ''; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '07/10/2020 15:00:00.000'; % 24 hours time.
        Patch_B_start_time = '07/03/2020 16:25:12.578'; % 24 hours time.
        UMass_type = ['NSR'];
    case '038'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '06/24/2020 11:20:23.495'; % 24 hours time.
        Patch_A_start_time = '06/24/2020 11:13:19.495'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '07/01/2020 07:50:52.451'; % 24 hours time.
        Patch_B_start_time = '07/01/2020 7:49:25.451'; % 24 hours time.
        UMass_type = ['NSR'];
    case '039'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '06/29/2020 16:58:50.000'; % 24 hours time.
        Patch_A_start_time = '06/29/2020 16:58:32.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '07/06/2020 20:57:22.267'; % 24 hours time.
        Patch_B_start_time = '07/06/2020 20:57:17.267'; % 24 hours time.
        UMass_type = ['NSR'];
    case '040'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = '08/07/2020 13:05:00.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '041'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '07/15/2020 15:09:31.163'; % 24 hours time.
        Patch_A_start_time = '07/15/2020 15:09:19.163'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '07/22/2020 17:15:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '042'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '07/28/2020 10:36:57.039'; % 24 hours time.
        Patch_A_start_time = '07/28/2020 10:36:27.039'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '08/04/2020 10:15:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '043'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = '07/28/2020 14:39:00.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '08/04/2020 18:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '044'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '08/10/2020 20:22:42.000'; % 24 hours time.
        Patch_A_start_time = '08/10/2020 20:19:23.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '045'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '08/07/2020 13:43:44.793'; % 24 hours time.
        Patch_A_start_time = '08/07/2020 13:43:11.793'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '08/14/2020 13:58:24.000'; % 24 hours time.
        Patch_B_start_time = '08/14/2020 13:57:38.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '047'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/01/2020 13:07:00.000'; % 24 hours time.
        Patch_A_start_time = '09/01/2020 13:06:59.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '09/08/2020 13:51:16.400';%'08/18/2020 22:00:00.000'; % 24 hours time.
        Patch_B_start_time = '09/08/2020 13:36:24.400';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '049'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/04/2020 13:36:31.375'; % 24 hours time.
        Patch_A_start_time = '09/04/2020 13:36:35.375'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '09/11/2020 20:46:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '050'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = '09/25/2020 11:58:00.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '051'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = ''; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '10/05/2020 10:30:00.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR']; 
    case '052'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/24/2020 09:22:32.000'; % 24 hours time.
        Patch_A_start_time = '09/24/2020 09:17:30.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '10/03/2020 10:55:09.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        Patch_B_start_time = '10/03/2020 10:51:42.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '053'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '09/25/2020 10:07:56.600'; % 24 hours time.
        Patch_A_start_time = '09/25/2020 10:07:54.600'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '10/02/2020 11:47:48.890';%'08/18/2020 22:00:00.000'; % 24 hours time.
        Patch_B_start_time = '10/02/2020 11:47:06.890';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '054'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/02/2020 08:51:27.000'; % 24 hours time.
        Patch_A_start_time = '10/02/2020 08:50:56.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '10/09/2020 09:16:30.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        Patch_B_start_time = '10/09/2020 09:13:34.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '055'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/05/2020 10:50:29.000'; % 24 hours time.
        Patch_A_start_time = '10/05/2020 10:50:16.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '10/08/2020 11:47:00.000';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '056'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/20/2020 15:09:05.000'; % 24 hours time.
        Patch_A_start_time = '10/20/2020 15:08:45.000'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '';%'08/18/2020 22:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '057'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '10/19/2020 14:57:33.560'; % 24 hours time.
        Patch_A_start_time = '10/19/2020 14:55:27.560'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '10/26/2020 12:20:10.810'; % 24 hours time.
        Patch_B_start_time = '10/26/2020 12:18:53.810'; % 24 hours time.
        UMass_type = ['NSR'];
    case '058'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '10/29/2020 09:51:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '11/06/2020 17:43:22.140'; % 24 hours time.
%          Patch_B_start_time = '11/06/2020 17:43:22.140'; % 24 hours time.
% I commented because UMass swtiched patch A and B. I am not sure if I have
% to rename all patch A and patch B 1-hour files.
        UMass_type = ['NSR'];
    case '062'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '11/20/2020 11:02:51.100'; % 24 hours time.
        Patch_A_start_time = '11/20/2020 10:57:29.100'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '11/27/2020 14:50:30.330'; % 24 hours time.
        Patch_B_start_time = '11/27/2020 14:43:02.330'; % 24 hours time.
        UMass_type = ['NSR'];
    case '063'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '12/03/2020 10:39:38.400'; % 24 hours time.
        Patch_A_start_time = '12/03/2020 10:39:07.400'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '064'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '12/08/2020 11:39:13.082'; % 24 hours time.
        Patch_A_start_time = '12/08/2020 11:38:43.082'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '12/15/2020 07:51:56.705'; % 24 hours time.
        Patch_B_start_time = '12/15/2020 7:49:31.705'; % 24 hours time.
        UMass_type = ['NSR'];
    case '065'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = ''; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '12/17/2020 12:00:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '067'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '12/15/2020 15:51:01.780'; % 24 hours time.
        Patch_A_start_time = '12/15/2020 15:45:46.780'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '12/22/2020 19:34:36.025'; % 24 hours time.
        Patch_B_start_time = '12/22/2020 19:34:33.025'; % 24 hours time.
        UMass_type = ['NSR'];
    case '068'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '12/22/2020 12:36:01.000'; % 24 hours time.
        Patch_A_start_time = '12/22/2020 12:35:59.500'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '12/29/2020 11:06:04.881'; % 24 hours time.
        Patch_B_start_time = '12/29/2020 11:05:58.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '069'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
        Patch_A_start_time = ''; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
        Patch_B_start_time = '01/06/2021 19:30:00.000'; % 24 hours time.
        UMass_type = ['NSR'];
    case '070'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '01/05/2021 12:23:00.497'; % 24 hours time.
        Patch_A_start_time = '01/05/2021 12:22:54.497'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '01/15/2021 10:34:59.275'; % 24 hours time.
        Patch_B_start_time = '01/15/2021 10:33:17.275'; % 24 hours time.
        UMass_type = ['NSR'];
    case '071'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = '01/07/2021 16:10:05.393'; % 24 hours time.
        Patch_A_start_time = '01/07/2021 16:10:04.393'; % 24 hours time.
        test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = '01/15/2021 21:53:26.000'; % 24 hours time.
        Patch_B_start_time = '01/15/2021 21:53:07.000'; % 24 hours time.
        UMass_type = ['NSR'];
%     case '072'
%         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%         Patch_A_start_time = ''; % 24 hours time.
%         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%         Patch_B_start_time = ''; % 24 hours time.
%        UMass_type = ['NSR'];
    case '073'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '01/21/2021 11:54:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '074'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '01/28/2021 11:08:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '02/04/2021 11:00:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '075'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '02/05/2021 14:07:05.000'; % 24 hours time.
         Patch_A_start_time = '02/05/2021 14:07:03.500'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '077'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '02/10/2021 08:19:48.561'; % 24 hours time.
         Patch_A_start_time = '02/10/2021 8:09:25.561'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '02/17/2021 08:52:22.000'; % 24 hours time.
         Patch_B_start_time = '02/17/2021 8:52:12.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '078'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '02/11/2021 22:46:10.000'; % 24 hours time.
         Patch_A_start_time = '02/11/2021 10:41:13.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '02/17/2021 12:20:40.000'; % 24 hours time.
         Patch_B_start_time = '02/17/2021 12:18:58.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '080'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '02/22/2021 11:42:03.000'; % 24 hours time.
         Patch_A_start_time = '02/22/2021 11:39:34.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '03/01/2021 10:27:31.300'; % 24 hours time.
%          Patch_B_start_time = '03/01/2021 10:27:29.300'; % 24 hours time.
         Patch_B_start_time = '03/01/2021 10:09:05.300'; % 
         UMass_type = ['NSR'];
    case '082'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/05/2021 11:45:35.000'; % 24 hours time.
         Patch_A_start_time = '03/05/2021 11:44:44.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '03/12/2021 10:11:14.416'; % 24 hours time.
         Patch_B_start_time = '03/12/2021 10:11:04.416'; % 24 hours time.
         UMass_type = ['NSR'];
    case '083'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/11/2021 11:41:44.000'; % 24 hours time.
         Patch_A_start_time = '03/11/2021 11:41:52.500'; % 24 hours time.
         test_ECG_path_B = [''];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '084'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/17/2021 10:10:41.000'; % 24 hours time.
         Patch_A_start_time = '03/17/2021 10:08:49.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '03/27/2021 09:56:39.000'; % 24 hours time.
         Patch_B_start_time = '03/27/2021 9:53:05.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '086'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/22/2021 10:44:05.000'; % 24 hours time.
         Patch_A_start_time = '03/22/2021 10:41:09.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '03/29/2021 10:34:55.700'; % 24 hours time.
         Patch_B_start_time = '03/29/2021 10:26:52.700'; % 24 hours time.
         UMass_type = ['NSR'];
    case '087'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/23/2021 09:47:53.000'; % 24 hours time.
         Patch_A_start_time = '03/23/2021 9:46:16.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '03/30/2021 10:15:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '088'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/23/2021 16:38:28.000'; % 24 hours time.
         Patch_A_start_time = '03/23/2021 16:37:10.500'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '03/30/2021 23:32:42.900'; % 24 hours time.
         Patch_B_start_time = '03/30/2021 23:32:32.900'; % 24 hours time.
         UMass_type = ['NSR'];
    case '089'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = ''; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '04/06/2021 10:16:55.000'; % 24 hours time.
         Patch_B_start_time = '04/06/2021 09:58:52.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '090'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '03/30/2021 12:15:45.000'; % 24 hours time.
         Patch_A_start_time = '03/30/2021 12:12:27.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '04/06/2021 07:38:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '091'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '04/05/2021 08:53:41.000'; % 24 hours time.
         Patch_A_start_time = '04/05/2021 08:42:09.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '04/12/2021 16:29:06.500'; % 24 hours time.
         Patch_B_start_time = '04/12/2021 16:15:22.500'; % 24 hours time.
         UMass_type = ['NSR'];
    case '093'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '04/22/2021 11:04:05.000'; % 24 hours time.
         Patch_A_start_time = '04/22/2021 11:01:54.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '04/29/2021 09:19:00.000'; % 24 hours time.
         Patch_B_start_time = '04/29/2021 9:16:52.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '094'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '04/23/2021 12:20:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '096'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = ''; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '05/17/2021 09:55:00.000'; % 24 hours time.
         test_ECG_path_C = [clinical_ECG_root,filesep,'Pulsewatch',UID,'C'];
         Patch_C_start_time = '05/20/2021 08:38:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '098'
        test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '05/12/2021 16:12:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '05/19/2021 08:00:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '099'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '05/19/2021 12:38:33.000'; % 24 hours time.
         Patch_A_start_time = '05/19/2021 12:36:42.500'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '100'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '05/27/2021 09:54:34.700'; % 24 hours time.
         Patch_A_start_time = '05/27/2021 9:51:21.700'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '06/03/2021 07:21:43.000'; % 24 hours time.
         Patch_B_start_time = '06/03/2021 07:16:49.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '101'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '06/01/2021 10:16:55.000'; % 24 hours time.
         Patch_A_start_time = '06/01/2021 10:16:51.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '06/08/2021 11:00:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '102'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '06/02/2021 11:45:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '06/10/2021 05:50:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '104'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '06/09/2021 14:41:17.000'; % 24 hours time.
         Patch_A_start_time = '06/09/2021 14:40:13.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '06/16/2021 11:20:24.200'; % 24 hours time.
         Patch_B_start_time = '06/16/2021 11:19:12.200'; % 24 hours time.
         UMass_type = ['NSR'];
    case '105'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '06/09/2021 14:41:17.000'; % 24 hours time.
         Patch_A_start_time = '06/16/2021 14:24:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '06/16/2021 11:20:24.200'; % 24 hours time.
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '106'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '06/21/2021 12:28:19.000'; % 24 hours time.
         Patch_A_start_time = '06/21/2021 12:28:14.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '06/27/2021 18:30:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '108'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '06/28/2021 10:03:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '07/05/2021 13:06:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '109'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '06/29/2021 09:53:10.000'; % 24 hours time.
         Patch_A_start_time = '06/29/2021 09:52:54.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '110'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '07/01/2021 10:03:01.000'; % 24 hours time.
         Patch_A_start_time = '07/01/2021 10:02:27.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '07/08/2021 07:54:22.000'; % 24 hours time.
         Patch_B_start_time = '07/08/2021 7:54:04.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '111'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '07/02/2021 11:16:55.000'; % 24 hours time.
         Patch_A_start_time = '07/02/2021 11:16:40.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '07/09/2021 09:20:00.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '112'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '07/06/2021 10:32:54.000'; % 24 hours time.
         Patch_A_start_time = '07/06/2021 10:32:25.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '07/13/2021 10:45:10.000'; % 24 hours time.
         Patch_B_start_time = '07/13/2021 10:43:22.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '113'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '07/15/2021 11:48:33.000'; % 24 hours time.
         Patch_A_start_time = '07/15/2021 11:47:30.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '07/22/2021 05:59:39.000'; % 24 hours time.
         Patch_B_start_time = '07/22/2021 5:56:20.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '116'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = '07/30/2021 12:58:00.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = ''; % 24 hours time.
         UMass_type = ['NSR'];
    case '118'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '08/02/2021 16:08:26.000'; % 24 hours time.
         Patch_A_start_time = '08/02/2021 16:07:20.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '08/09/2021 20:28:09.000'; % 24 hours time.
         Patch_B_start_time = '08/09/2021 20:26:49.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '119'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
%          Patch_A_start_time = '08/04/2021 04:55:39.000'; % 24 hours time.
         Patch_A_start_time = '08/04/2021 04:43:25.000'; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
%          Patch_B_start_time = '08/10/2021 09:44:16.000'; % 24 hours time.
         Patch_B_start_time = '08/10/2021 09:35:21.000'; % 24 hours time.
         UMass_type = ['NSR'];
    case '120'
         test_ECG_path_A = [clinical_ECG_root,filesep,'Pulsewatch',UID,'A'];
         Patch_A_start_time = ''; % 24 hours time.
         test_ECG_path_B = [clinical_ECG_root,filesep,'Pulsewatch',UID,'B'];
         Patch_B_start_time = '08/12/2021 05:36:14.900'; % 24 hours time.
         UMass_type = ['NSR'];

 % AF trial 300-330
    case '300'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/03/2020 16:26:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '301'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/06/2020 09:42:29.800'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '302'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/06/2020 11:06:48.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '303'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/06/2020 16:53:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '304'
        keyboard;
    case '305'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/07/2020 14:31:09.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '306'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/13/2020 09:28:15.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '307'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '01/13/2020 12:14:33.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '308'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '02/19/2020 09:23:29.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '309'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '02/21/2020 15:20:16.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '310'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '03/04/2020 13:56:34.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '311'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '03/06/2020 14:31:55.500'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '312'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '03/12/2020 08:40:36.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '313'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '07/30/2020 14:43:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '314'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '07/31/2020 16:43:00.000'; % 24 hours time.
        Patch_A_start_time = '07/31/2020 16:22:02.500'; % 09/06/2020: try with moving the start time earlier.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '315'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/03/2020 15:38:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '316'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/03/2020 16:29:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '317'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/04/2020 12:42:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '318'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/04/2020 14:11:04.952'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '319'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '08/05/2020 11:28:00.000'; % 24 hours time.
        Patch_A_start_time = '08/05/2020 11:25:02.600'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '320'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/05/2020 13:12:35.736'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '321'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '08/06/2020 10:04:00.000'; % 24 hours time.
        Patch_A_start_time = '08/06/2020 10:04:31.163'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '322'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '08/06/2020 14:39:00.000'; % 24 hours time.
        Patch_A_start_time = '08/06/2020 14:35:17.021'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '323'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '08/06/2020 14:39:00.000'; % 24 hours time.
        Patch_A_start_time = '08/06/2020 15:09:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Unknown'];
    case '324'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/06/2020 16:13:20.400'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '325'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/06/2020 16:43:07.800'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '326'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/11/2020 12:13:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '327'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '08/11/2020 14:27:00.000'; % 24 hours time.
        Patch_A_start_time = '08/11/2020 14:27:01.757'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR'];
    case '328'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '08/11/2020 15:47:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR w AFlutter'];
    case '329'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '08/12/2020 10:41:00.000'; % 24 hours time.
        Patch_A_start_time = '08/12/2020 10:40:55.574'; % 09/08/2020, Dong found this from all signal trace plot
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '330'        
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '05/24/2021 12:41:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['NSR w AFlutter'];
    case '400'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '05/24/2021 12:11:00.000'; % 24 hours time.
        Patch_A_start_time = '05/24/2021 12:10:10.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '402'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '07/01/2021 14:16:23.000'; % 24 hours time.
        Patch_A_start_time = '07/01/2021 14:14:31.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '403'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '09/13/2021 14:52:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '404'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '09/16/2021 11:30:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '405'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '09/21/2021 15:05:44.000'; % 24 hours time.
        Patch_A_start_time = '09/21/2021 15:03:58.500'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '406'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '09/23/2021 11:14:21.000'; % 24 hours time.
        Patch_A_start_time = '09/23/2021 11:11:54.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '407'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '09/28/2021 10:22:53.000'; % 24 hours time.
        Patch_A_start_time = '09/28/2021 10:21:52.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '408'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '09/30/2021 10:16:09.000'; % 24 hours time.
        Patch_A_start_time = '09/30/2021 10:13:25.750'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '409'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%          Patch_A_start_time = '10/05/2021 13:45:36.000'; % 24 hours time.
        Patch_A_start_time = '10/05/2021 13:44:42.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '410'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '10/07/2021 16:04:35.000'; % 24 hours time.
        Patch_A_start_time = '10/07/2021 16:03:29.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '411'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '10/12/2021 14:09:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '412'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '10/19/2021 11:26:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '413'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '10/19/2021 14:31:07.600'; % 24 hours time.
        Patch_A_start_time = '10/19/2021 14:29:18.100'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '414'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '10/22/2021 16:30:11.000'; % 24 hours time.
        Patch_A_start_time = '10/22/2021 16:29:47.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '415'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '10/25/2021 10:56:31.000'; % 24 hours time.
        Patch_A_start_time = '10/25/2021 10:54:59.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '416'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '10/28/2021 11:45:48.000'; % 24 hours time.
        Patch_A_start_time = '10/28/2021 11:43:52.250'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '417'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '11/02/2021 11:23:30.000'; % 24 hours time.
        Patch_A_start_time = '11/02/2021 11:21:29.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '418'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
        Patch_A_start_time = '11/05/2021 11:56:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '419'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '11/08/2021 11:26:52.000'; % 24 hours time.
        Patch_A_start_time = '11/08/2021 11:26:03.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '420'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '11/30/2021 10:23:26.000'; % 24 hours time.
        Patch_A_start_time = '11/30/2021 10:21:56.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '421'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '12/06/2021 10:34:55.000'; % 24 hours time.
        Patch_A_start_time = '12/06/2021 10:34:40.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '422'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '12/13/2021 09:57:54.000'; % 24 hours time.
        Patch_A_start_time = '12/13/2021 09:57:47.545'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];
    case '423'
        test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = '12/16/2021 08:36:08.000'; % 24 hours time.
        Patch_A_start_time = '12/16/2021 08:36:03.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['AF'];

%     case ''
%         test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = ''; % 24 hours time.
%         test_ECG_path_B = [];
%         Patch_B_start_time = ''; % 24 hours time.
%         UMass_type = ['AF'];
%     case ''
%         test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = ''; % 24 hours time.
%         test_ECG_path_B = [];
%         Patch_B_start_time = ''; % 24 hours time.
%         UMass_type = ['AF'];
%     case ''
%         test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = ''; % 24 hours time.
%         test_ECG_path_B = [];
%         Patch_B_start_time = ''; % 24 hours time.
%         UMass_type = ['AF'];
%     case ''
%         test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = ''; % 24 hours time.
%         test_ECG_path_B = [];
%         Patch_B_start_time = ''; % 24 hours time.
%         UMass_type = ['AF'];
%     case ''
%         test_ECG_path_A = [AF_ECG_root,filesep,UID];
%         Patch_A_start_time = ''; % 24 hours time.
%         test_ECG_path_B = [];
%         Patch_B_start_time = ''; % 24 hours time.
%         UMass_type = ['AF'];
    case '913_02042021'        
        test_ver_2_path = 'R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_APP_ver_2_0\Dong_concatenated_ECG';
        test_ECG_path_A = [test_ver_2_path];
        Patch_A_start_time = '02/04/2021 12:59:02.500'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Ver2.0.1 Testing'];
    case '914_2021042601'        
        if HPC_flag
            test_ver_2_path = '/scratch/doh16101-lab/Test_Up_Time_2_1_0/Dong_concatenated_ECG_protected';
        else
            test_ver_2_path = 'R:\ENGR_Chon\Dong\myGalaxyWatch3Database\Test_Up_Time_2_1_0\Dong_concatenated_ECG_protected';
        end
        test_ECG_path_A = [test_ver_2_path];
        Patch_A_start_time = '04/26/2021 11:31:02.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Ver2.1.0 Testing'];
    case '999_2021042601'   
        if HPC_flag
            test_ver_2_path = '/scratch/doh16101-lab/Test_Up_Time_2_1_0/Andrew_concatenated_ECG_protected/Andrew_concatenated_ECG_0426';           
        else
            test_ver_2_path = 'R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_Up_Time_2_1_0\Andrew_concatenated_ECG_0426';
        end
        test_ECG_path_A = [test_ver_2_path];
        Patch_A_start_time = '04/26/2021 11:30:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Ver2.1.0 Testing'];
    case '999_2021042901'        
        if HPC_flag
            test_ver_2_path = '/scratch/doh16101-lab/Test_Up_Time_2_1_0/Andrew_concatenated_ECG_protected/999_2021042901';
        else
            test_ver_2_path = 'R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_Up_Time_2_1_0\Andrew_1_hour_ECG\999_2021042901';
        end
        test_ECG_path_A = [test_ver_2_path];
        Patch_A_start_time = '04/29/2021 10:35:15.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Ver2.1.0 Testing'];
    case '999_2021050101'        
        if HPC_flag
            test_ver_2_path = '/scratch/doh16101-lab/Test_Up_Time_2_1_0/Andrew_concatenated_ECG_protected/Andrew_concatenated_ECG_0501';
        else
            test_ver_2_path = 'R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_Up_Time_2_1_0\Andrew_concatenated_ECG_0501';
        end
        test_ECG_path_A = [test_ver_2_path];
        Patch_A_start_time = '05/01/2021 10:34:20.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Ver2.1.0 Testing'];
    case '999_2021050501'      
        if HPC_flag
            test_ver_2_path = '/scratch/doh16101-lab/Test_Up_Time_2_1_0/Andrew_concatenated_ECG_protected/Andrew_concatenated_ECG_0505';
        else
            test_ver_2_path = 'R:\ENGR_Chon\Dong\myGalaxyWatchDatabase\Test_Up_Time_2_1_0\Andrew_concatenated_ECG_0505';
        end
        test_ECG_path_A = [test_ver_2_path];
        Patch_A_start_time = '05/05/2021 14:37:00.000'; % 24 hours time.
        test_ECG_path_B = [];
        Patch_B_start_time = ''; % 24 hours time.
        UMass_type = ['Ver2.1.0 Testing'];
    otherwise
        disp('not finished pruning!');
        keyboard;
end
if ~exist('test_ECG_path_C','var') % only UID 028 has patch C.
    test_ECG_path_C = [];
    Patch_C_start_time = [];
end
end
