function [output_struct] = my_func_aim2_aim3_time_ctrl(UID)
% 
% function output_struct = my_aim23_time(UID)
% 
% Description: this function is to know the start time and end time of 
%               UMass clinical trial Aim2 and Aim3.
% 
% Author: Dong Han <dong.han@uconn.edu>
% Date: 05/17/2020.
% 

switch UID
    case '001'
        aim2_sta = '09/03/2019';
        aim2_end = '09/17/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '002'
        aim2_sta = '09/03/2019';
        aim2_end = '09/17/2019';
        aim3_sta = '09/19/2019';
        aim3_end = '10/20/2019';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '003'
        aim2_sta = '09/10/2019';
        aim2_end = '09/24/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '004'
        aim2_sta = '09/13/2019';
        aim2_end = '09/27/2019';
        aim3_sta = '09/27/2019';
        aim3_end = '10/28/2019';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '005'
        aim2_sta = '09/16/2019';
        aim2_end = '09/30/2019';
        aim3_sta = '09/30/2019';
        aim3_end = '10/30/2019';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '006'
        aim2_sta = '09/17/2019';
        aim2_end = '10/01/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '007'
        aim2_sta = '09/20/2019';
        aim2_end = '10/04/2019';
        aim3_sta = '10/08/2019';
        aim3_end = '11/07/2019';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '008'
        aim2_sta = '09/23/2019';
        aim2_end = '10/07/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '009'
        aim2_sta = '10/07/2019';
        aim2_end = '10/21/2019';
        aim3_sta = '10/21/2019';
        aim3_end = '11/20/2019';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '010'
        aim2_sta = '10/09/2019';
        aim2_end = '10/23/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '011'
        aim2_sta = '10/21/2019';
        aim2_end = '11/04/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '012'
        aim2_sta = '10/31/2019';
        aim2_end = '11/14/2019';
        aim3_sta = '11/14/2019';
        aim3_end = '12/16/2019';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '013'
        aim2_sta = '11/06/2019';
        aim2_end = '11/20/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '014'
        aim2_sta = '11/12/2019';
        aim2_end = '11/26/2019';
        aim3_sta = '11/26/2019';
        aim3_end = '12/26/2019';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '015'
        aim2_sta = '11/26/2019';
        aim2_end = '12/10/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '016'
        aim2_sta = '12/02/2019';
        aim2_end = '12/16/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '017'
        aim2_sta = '12/04/2019';
        aim2_end = '12/18/2019';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '018'
        aim2_sta = '12/27/2019';
        aim2_end = '01/10/2020';
        aim3_sta = '01/10/2020';
        aim3_end = '02/10/2020';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '019'
        aim2_sta = '01/03/2020';
        aim2_end = '01/16/2020';
        aim3_sta = '01/16/2020';
        aim3_end = '02/14/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '020'
        aim2_sta = '01/07/2020';
        aim2_end = '01/21/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '021'
        aim2_sta = '01/14/2020';
        aim2_end = '01/28/2020';
        aim3_sta = '01/28/2020';
        aim3_end = '02/27/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '022'
        aim2_sta = '01/22/2020';
        aim2_end = '02/05/2020';
        aim3_sta = '02/05/2020';
        aim3_end = '03/06/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '023'
        aim2_sta = '01/27/2020';
        aim2_end = '02/10/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '024'
        aim2_sta = '01/29/2020';
        aim2_end = '02/12/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '025'
        aim2_sta = '01/29/2020';
        aim2_end = '02/12/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '026'
        aim2_sta = '02/06/2020';
        aim2_end = '02/20/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '027'
        aim2_sta = '02/11/2020';
        aim2_end = '02/25/2020';
        aim3_sta = '02/25/2020';
        aim3_end = '03/26/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '028'
        aim2_sta = '02/13/2020';
        aim2_end = '02/27/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '029'
        aim2_sta = '02/14/2020';
        aim2_end = '02/28/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '030'
        aim2_sta = '02/19/2020';
        aim2_end = '03/04/2020';
        aim3_sta = '03/04/2020';
        aim3_end = '04/03/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '031'
        aim2_sta = '02/24/2020';
        aim2_end = '03/09/2020';
        aim3_sta = '03/09/2020';
        aim3_end = '04/07/2020';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '032'
        aim2_sta = '02/26/2020';
        aim2_end = '03/11/2020';
        aim3_sta = '03/11/2020';
        aim3_end = '04/15/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '033'
        aim2_sta = '03/02/2020';
        aim2_end = '03/16/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '034'
        aim2_sta = '03/02/2020';
        aim2_end = '03/16/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '035'
        aim2_sta = '07/24/2020'; % this subject withdrew the experiment. 11/01/2020. UMass wants to analyze it again. 01/09/2022.
        aim2_end = '07/28/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '036'
        aim2_sta = '06/26/2020';
        aim2_end = '07/10/2020';
        aim3_sta = '07/14/2020';
        aim3_end = '08/13/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '037'
        aim2_sta = '06/26/2020';
        aim2_end = '07/10/2020';
        aim3_sta = '';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '038'
        aim2_sta = '06/25/2020';
        aim2_end = '07/08/2020';
        aim3_sta = '07/08/2020';
        aim3_end = '08/07/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '039'
        aim2_sta = '06/29/2020';
        aim2_end = '07/13/2020';
        aim3_sta = '07/16/2020';
        aim3_end = '08/17/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '040'
        aim2_sta = '08/07/2020';
        aim2_end = '';
        aim3_sta = '08/24/2020';
        aim3_end = '09/25/2020';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '041'
        aim2_sta = '07/15/2020';
        aim2_end = '07/29/2020';
        aim3_sta = '07/30/2020';
        aim3_end = '08/31/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '042'
        aim2_sta = '07/28/2020';
        aim2_end = '08/11/2020';
        aim3_sta = '08/11/2020';
        aim3_end = '09/12/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '043'
        aim2_sta = '07/27/2020';
        aim2_end = '08/11/2020';
        aim3_sta = '08/11/2020';
        aim3_end = '09/12/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '044'
        aim2_sta = '08/12/2020';
        aim2_end = '08/25/2020';
        aim3_sta = '08/26/2020';
        aim3_end = '09/27/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '045'
        aim2_sta = '08/07/2020';
        aim2_end = '08/21/2020';
        aim3_sta = '08/21/2020';
        aim3_end = '09/22/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '046'
        aim2_sta = '08/13/2020';
        aim2_end = '08/27/2020';
        aim3_sta = '08/27/2020';
        aim3_end = '09/28/2020';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '047'
        aim2_sta = '09/01/2020';
        aim2_end = '09/15/2020';
        aim3_sta = '09/15/2020';
        aim3_end = '10/15/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '048'
        aim2_sta = '08/28/2020';
        aim2_end = '09/11/2020';
        aim3_sta = '09/15/2020';
        aim3_end = '10/16/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '049'
        aim2_sta = '09/04/2020';
        aim2_end = '09/18/2020';
        aim3_sta = '09/18/2020';
        aim3_end = '';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '050'
        aim2_sta = '09/25/2020';
        aim2_end = '10/09/2020';
        aim3_sta = '10/14/2020';
        aim3_end = '11/16/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '051'
        aim2_sta = '09/28/2020';
        aim2_end = '10/12/2020';
        aim3_sta = '10/20/2020';
        aim3_end = '11/30/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '052'
        aim2_sta = '09/25/2020';
        aim2_end = '10/09/2020';
        aim3_sta = '10/09/2020';
        aim3_end = '11/10/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '053'
        aim2_sta = '09/25/2020';
        aim2_end = '10/09/2020';
        aim3_sta = '10/14/2020';
        aim3_end = '11/17/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '054'
        aim2_sta = '10/02/2020';
        aim2_end = '10/16/2020';
        aim3_sta = '10/16/2020';
        aim3_end = '11/18/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '055'
        aim2_sta = '10/05/2020';
        aim2_end = '10/20/2020';
        aim3_sta = '10/20/2020';
        aim3_end = '11/20/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '056'
        aim2_sta = '10/20/2020';
        aim2_end = '11/03/2020';
        aim3_sta = '11/16/2020';
        aim3_end = '12/16/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '057'
        aim2_sta = '10/19/2020';
        aim2_end = '11/02/2020';
        aim3_sta = '11/02/2020';
        aim3_end = '12/04/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '058'
        aim2_sta = '10/30/2020';
        aim2_end = '11/13/2020';
        aim3_sta = '11/13/2020';
        aim3_end = '12/17/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '059'
        aim2_sta = '10/29/2020';
        aim2_end = '11/19/2020';
        aim3_sta = '11/19/2020';
        aim3_end = '12/21/2020';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '060'
        aim2_sta = '11/10/2020';
        aim2_end = '11/30/2020';
        aim3_sta = '11/30/2020';
        aim3_end = '01/04/2021';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = false; % false = intervention. true = control.
    case '061'
        aim2_sta = '11/23/2020';
        aim2_end = '12/07/2020';
        aim3_sta = '12/08/2020';
        aim3_end = '01/07/2021';
        aim2_ctrl_flag = true; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
    case '062'
        aim2_sta = '11/20/2020';
        aim2_end = '12/04/2020';
        aim3_sta = '12/04/2020';
        aim3_end = '12/28/2020';
        aim2_ctrl_flag = false; % false = intervention. true = control.
        aim3_ctrl_flag = true; % false = intervention. true = control.
     case '063'
         aim2_sta = '12/03/2020';
         aim2_end = '12/21/2020';
         aim3_sta = '12/21/2020';
         aim3_end = '01/21/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '064'
         aim2_sta = '12/08/2020';
         aim2_end = '12/22/2020';
         aim3_sta = '12/22/2020';
         aim3_end = '01/21/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
     case '065'
         aim2_sta = '12/10/2020';
         aim2_end = '12/30/2020';
         aim3_sta = '12/30/2020';
         aim3_end = '01/29/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
     case '066'
         aim2_sta = '12/11/2020';
         aim2_end = '12/29/2020';
         aim3_sta = '12/29/2020';
         aim3_end = '02/05/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '067'
         aim2_sta = '12/15/2020';
         aim2_end = '12/30/2020';
         aim3_sta = '12/30/2020';
         aim3_end = '01/29/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
     case '068'
         aim2_sta = '12/22/2020';
         aim2_end = '01/05/2021';
         aim3_sta = '01/05/2021';
         aim3_end = '02/04/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '069'
         aim2_sta = '12/30/2020';
         aim2_end = '01/13/2021';
         aim3_sta = '01/13/2021';
         aim3_end = '02/18/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '070'
         aim2_sta = '01/05/2021';
         aim2_end = '01/19/2021';
         aim3_sta = '01/19/2021';
         aim3_end = '02/18/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
     case '071'
         aim2_sta = '01/07/2021';
         aim2_end = '01/21/2021';
         aim3_sta = '01/21/2021';
         aim3_end = '02/23/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
     case '072'
         aim2_sta = '01/15/2021';
         aim2_end = '01/29/2021';
         aim3_sta = '01/29/2021';
         aim3_end = '03/01/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '073'
         aim2_sta = '01/20/2021';
         aim2_end = '02/04/2021';
         aim3_sta = '02/04/2021';
         aim3_end = '03/08/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '074'
         aim2_sta = '01/28/2021';
         aim2_end = '02/11/2021';
         aim3_sta = '02/11/2021';
         aim3_end = '03/15/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '075'
         aim2_sta = '02/05/2021';
         aim2_end = '02/19/2021';
         aim3_sta = '02/19/2021';
         aim3_end = '03/22/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '076'
         aim2_sta = '02/08/2021';
         aim2_end = '02/26/2021';
         aim3_sta = '02/26/2021';
         aim3_end = '03/31/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '077'
         aim2_sta = '02/10/2021';
         aim2_end = '02/25/2021';
         aim3_sta = '02/25/2021';
         aim3_end = '03/29/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '078'
         aim2_sta = '02/11/2021';
         aim2_end = '02/24/2021';
         aim3_sta = '02/24/2021';
         aim3_end = '03/26/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '079'
         aim2_sta = '03/05/2021';
         aim2_end = '';
         aim3_sta = '03/19/2021';
         aim3_end = '04/28/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '080'
         aim2_sta = '02/22/2021';
         aim2_end = '03/09/2021';
         aim3_sta = '03/09/2021';
         aim3_end = '04/13/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '081'
         aim2_sta = '03/03/2021';
         aim2_end = '03/17/2021';
         aim3_sta = '03/17/2021';
         aim3_end = '';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '082'
         aim2_sta = '03/05/2021';
         aim2_end = '03/19/2021';
         aim3_sta = '03/19/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '083'
         aim2_sta = '03/11/2021';
         aim2_end = '03/25/2021';
         aim3_sta = '03/26/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '084'
         aim2_sta = '03/17/2021';
         aim2_end = '04/01/2021';
         aim3_sta = '04/01/2021';
         aim3_end = '05/06/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '085'
         aim2_sta = '03/18/2021';
         aim2_end = '04/02/2021';
         aim3_sta = '04/02/2021';
         aim3_end = '';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '086'
         aim2_sta = '03/22/2021';
         aim2_end = '04/05/2021';
         aim3_sta = '04/05/2021';
         aim3_end = '05/11/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '087'
         aim2_sta = '03/23/2021';
         aim2_end = '04/07/2021';
         aim3_sta = '04/07/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '088'
         aim2_sta = '03/23/2021';
         aim2_end = '04/07/2021';
         aim3_sta = '04/07/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '089'
         aim2_sta = '03/30/2021';
         aim2_end = '04/13/2021';
         aim3_sta = '04/13/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '090'
         aim2_sta = '03/30/2021';
         aim2_end = '04/13/2021';
         aim3_sta = '04/13/2021';
         aim3_end = '05/14/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '091'
         aim2_sta = '04/05/2021';
         aim2_end = '04/21/2021';
         aim3_sta = '04/21/2021';
         aim3_end = '05/21/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '092'
         aim2_sta = '04/13/2021';
         aim2_end = '';
         aim3_sta = '04/27/2021';
         aim3_end = '';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '093'
         aim2_sta = '04/22/2021';
         aim2_end = '05/06/2021';
         aim3_sta = '05/06/2021';
         aim3_end = '06/07/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '094'
         aim2_sta = '04/23/2021';
         aim2_end = '05/06/2021';
         aim3_sta = '05/06/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '095'
         aim2_sta = '04/28/2021';
         aim2_end = '';
         aim3_sta = '05/19/2021';
         aim3_end = '06/23/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '096'
         aim2_sta = '05/05/2021';
         aim2_end = '05/24/2021';
         aim3_sta = '05/24/2021';
         aim3_end = '07/02/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '097'
         aim2_sta = '05/05/2021';
         aim2_end = '';
         aim3_sta = '05/21/2021';
         aim3_end = '06/28/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '098'
         aim2_sta = '05/12/2021';
         aim2_end = '05/26/2021';
         aim3_sta = '05/26/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '099'
         aim2_sta = '05/19/2021';
         aim2_end = '06/03/2021';
         aim3_sta = '06/03/2021';
         aim3_end = '07/12/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '100'
         aim2_sta = '05/27/2021';
         aim2_end = '06/10/2021';
         aim3_sta = '06/10/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '101'
         aim2_sta = '06/01/2021';
         aim2_end = '06/15/2021';
         aim3_sta = '06/15/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '102'
         aim2_sta = '06/02/2021';
         aim2_end = '06/22/2021';
         aim3_sta = '06/22/2021';
         aim3_end = '07/26/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '103'
         aim2_sta = '06/08/2021';
         aim2_end = '06/22/2021';
         aim3_sta = '06/22/2021';
         aim3_end = '07/30/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '104'
         aim2_sta = '06/09/2021';
         aim2_end = '06/24/2021';
         aim3_sta = '06/24/2021';
         aim3_end = '08/02/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '105'
         aim2_sta = '06/16/2021';
         aim2_end = '';
         aim3_sta = '07/06/2021';
         aim3_end = '08/11/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '106'
         aim2_sta = '06/21/2021';
         aim2_end = '07/07/2021';
         aim3_sta = '07/07/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '108'
         aim2_sta = '06/28/2021';
         aim2_end = '07/12/2021';
         aim3_sta = '07/12/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '109'
         aim2_sta = '06/29/2021';
         aim2_end = '07/16/2021';
         aim3_sta = '07/16/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '110'
         aim2_sta = '07/01/2021';
         aim2_end = '07/16/2021';
         aim3_sta = '07/16/2021';
         aim3_end = '08/16/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '111'
         aim2_sta = '07/02/2021';
         aim2_end = '07/16/2021';
         aim3_sta = '07/16/2021';
         aim3_end = '08/16/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '112'
         aim2_sta = '07/06/2021';
         aim2_end = '07/21/2021';
         aim3_sta = '07/21/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '113'
         aim2_sta = '07/15/2021';
         aim2_end = '07/29/2021';
         aim3_sta = '07/29/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '114'
         aim2_sta = '07/20/2021';
         aim2_end = '08/06/2021';
         aim3_sta = '08/06/2021';
         aim3_end = '';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '116'
         aim2_sta = '07/30/2021';
         aim2_end = '08/13/2021';
         aim3_sta = '08/13/2021';
         aim3_end = '09/14/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '117'
         aim2_sta = '08/02/2021';
         aim2_end = '08/16/2021';
         aim3_sta = '08/16/2021';
         aim3_end = '09/15/2021';
         aim2_ctrl_flag = true; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '118'
         aim2_sta = '08/02/2021';
         aim2_end = '08/17/2021';
         aim3_sta = '08/17/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '119'
         aim2_sta = '08/03/2021';
         aim2_end = '08/18/2021';
         aim3_sta = '08/18/2021';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '120'
         aim2_sta = '08/05/2021';
         aim2_end = '08/19/2021';
         aim3_sta = '08/19/2021';
         aim3_end = '09/20/2021';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = false; % false = intervention. true = control.
    case '400'
         aim2_sta = '05/24/2021';
         aim2_end = '05/31/2021'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '402'
         aim2_sta = '07/01/2021';
         aim2_end = '07/09/2021'; % I am afraid they wear the patch for 9 days, so I put 07/09 here.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '403'
         aim2_sta = '09/13/2021';
         aim2_end = '09/21/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '404'
         aim2_sta = '09/16/2021';
         aim2_end = '09/24/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '405'
         aim2_sta = '09/21/2021';
         aim2_end = '09/29/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '406'
         aim2_sta = '09/23/2021';
         aim2_end = '09/30/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '407'
         aim2_sta = '09/28/2021';
         aim2_end = '10/06/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '408'
         aim2_sta = '09/30/2021';
         aim2_end = '10/08/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '409'
         aim2_sta = '10/05/2021';
         aim2_end = '10/13/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '410'
         aim2_sta = '10/07/2021';
         aim2_end = '10/15/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '411'
         aim2_sta = '10/12/2021';
         aim2_end = '10/19/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '412'
         aim2_sta = '10/19/2021';
         aim2_end = '10/27/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '413'
         aim2_sta = '10/19/2021';
         aim2_end = '10/27/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '414'
         aim2_sta = '10/22/2021';
         aim2_end = '10/29/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '415'
         aim2_sta = '10/25/2021';
         aim2_end = '11/02/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '416'
         aim2_sta = '10/28/2021';
         aim2_end = '11/05/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
     case '417'
         aim2_sta = '11/02/2021';
         aim2_end = '11/10/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '418'
         aim2_sta = '11/05/2021';
         aim2_end = '11/13/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '419'
         aim2_sta = '11/08/2021';
         aim2_end = '11/16/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '420'
         aim2_sta = '11/30/2021';
         aim2_end = '12/08/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '421'
         aim2_sta = '12/06/2021';
         aim2_end = '12/14/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '422'
         aim2_sta = '12/13/2021';
         aim2_end = '12/21/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '423'
         aim2_sta = '12/16/2021';
         aim2_end = '12/23/2021';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
%     case ''
%          aim2_sta = '';
%          aim2_end = '';
%          aim3_sta = '';
%          aim3_end = '';
%          aim2_ctrl_flag = ; % false = intervention. true = control.
%          aim3_ctrl_flag = ; % false = intervention. true = control.
    case '300'
         aim2_sta = '01/03/2020';
         aim2_end = '01/04/2020';
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '301'
         aim2_sta = '01/06/2020';
         aim2_end = '01/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '302'
         aim2_sta = '01/06/2020';
         aim2_end = '01/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '303'
         aim2_sta = '01/06/2020';
         aim2_end = '01/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '305'
         aim2_sta = '01/07/2020';
         aim2_end = '01/08/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '306'
         aim2_sta = '01/13/2020';
         aim2_end = '01/14/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '307'
         aim2_sta = '01/13/2020';
         aim2_end = '01/14/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '308'
         aim2_sta = '02/19/2020';
         aim2_end = '02/20/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '309'
         aim2_sta = '02/21/2020';
         aim2_end = '02/22/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '310'
         aim2_sta = '03/04/2020';
         aim2_end = '03/05/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '311'
         aim2_sta = '03/06/2020';
         aim2_end = '03/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '312'
         aim2_sta = '03/12/2020';
         aim2_end = '03/13/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '313'
         aim2_sta = '07/30/2020';
         aim2_end = '07/31/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '314'
         aim2_sta = '07/31/2020';
         aim2_end = '08/01/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '315'
         aim2_sta = '08/03/2020';
         aim2_end = '08/04/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '316'
         aim2_sta = '08/03/2020';
         aim2_end = '08/04/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '317'
         aim2_sta = '08/04/2020';
         aim2_end = '08/05/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '318'
         aim2_sta = '08/04/2020';
         aim2_end = '08/05/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '319'
         aim2_sta = '08/05/2020';
         aim2_end = '08/06/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '320'
         aim2_sta = '08/05/2020';
         aim2_end = '08/06/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '321'
         aim2_sta = '08/06/2020';
         aim2_end = '08/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '322'
         aim2_sta = '08/06/2020';
         aim2_end = '08/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '323'
         aim2_sta = '08/06/2020';
         aim2_end = '08/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '324'
         aim2_sta = '08/06/2020';
         aim2_end = '08/07/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '326'
         aim2_sta = '08/11/2020';
         aim2_end = '08/12/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '328'
         aim2_sta = '08/11/2020';
         aim2_end = '08/12/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '329'
         aim2_sta = '08/12/2020';
         aim2_end = '08/13/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    case '330'
         aim2_sta = '08/12/2020';
         aim2_end = '08/13/2020'; % I pretent the ECG last for 7 days. But actually it only turned on for 2 days.
         aim3_sta = '';
         aim3_end = '';
         aim2_ctrl_flag = false; % false = intervention. true = control.
         aim3_ctrl_flag = true; % false = intervention. true = control.
    otherwise
        disp('ECG patch data not received! Please check back later.')
        keyboard;
end

output_struct = struct('aim2_sta',aim2_sta,...
    'aim2_end',aim2_end,...
    'aim3_sta',aim3_sta,...
    'aim3_end',aim3_end,...
    'aim2_ctrl_flag',aim2_ctrl_flag,...
    'aim3_ctrl_flag',aim3_ctrl_flag);
end
