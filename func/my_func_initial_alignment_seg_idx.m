function [patch_A_PPG_idx,...
    patch_A_PPG_seg_name,...
    patch_B_PPG_idx,...
    patch_B_PPG_seg_name,...
    patch_C_PPG_idx,...
    patch_C_PPG_seg_name] = my_func_initial_alignment_seg_idx(UID)
switch UID
    case '002'
        patch_A_PPG_idx = 313;
        patch_A_PPG_seg_name = ['002_2019_09_04_04_34_39_ppg_0008'];
        patch_B_PPG_idx = 3472;
        patch_B_PPG_seg_name = ['002_2019_09_11_21_59_40_ppg_0004'];
    case '075'
        patch_A_PPG_idx = 394;
        patch_A_PPG_seg_name = ['075_2021_02_05_20_43_48_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '078'
        patch_A_PPG_idx = 1593;
        patch_A_PPG_seg_name = ['078_2021_02_13_23_26_36_ppg_0000.txt'];
        patch_B_PPG_idx = 4980;
        patch_B_PPG_seg_name = ['078_2021_02_18_01_09_49_ppg_0000.txt'];
    case '080'
        patch_A_PPG_idx = 892;
        patch_A_PPG_seg_name = ['080_2021_02_23_02_05_09_ppg_0000.txt'];
        patch_B_PPG_idx = 11605;
        patch_B_PPG_seg_name = ['080_2021_03_07_16_01_48_ppg_0000.txt'];
    case '083'
        patch_A_PPG_idx = 291;
        patch_A_PPG_seg_name = ['083_2021_03_11_16_43_43_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '084'
        patch_A_PPG_idx = 630;
        patch_A_PPG_seg_name = ['084_2021_03_18_12_11_14_ppg_0000.txt'];
        patch_B_PPG_idx = 7470;
        patch_B_PPG_seg_name = ['084_2021_03_28_22_19_06_ppg_0000.txt'];
    case '086'
        patch_A_PPG_idx = 799;
        patch_A_PPG_seg_name = ['086_2021_03_23_00_29_07_ppg_0000.txt'];
        patch_B_PPG_idx = 5382;
        patch_B_PPG_seg_name = ['086_2021_03_30_23_01_08_ppg_0000.txt'];
    case '087'
        patch_A_PPG_idx = 756;
        patch_A_PPG_seg_name = ['087_2021_03_23_22_22_26_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '088'
        patch_A_PPG_idx = 357;
        patch_A_PPG_seg_name = ['088_2021_03_24_01_17_44_ppg_0000.txt'];
        patch_B_PPG_idx = 3666;
        patch_B_PPG_seg_name = ['088_2021_03_31_02_00_20_ppg_0000.txt'];
    case '089'
        patch_A_PPG_idx = [];
        patch_A_PPG_seg_name = [''];
        patch_B_PPG_idx = 5527;
        patch_B_PPG_seg_name = ['089_2021_04_09_23_24_28_ppg_0000.txt'];
    case '005'
        patch_A_PPG_idx = 64;
        patch_A_PPG_seg_name = ['005_2019_09_16_14_47_14_ppg_0013'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '090'
        patch_A_PPG_idx = 1138;
        patch_A_PPG_seg_name = ['090_2021_04_01_00_36_24_ppg_0000.txt'];
        patch_B_PPG_idx = 14871; % Not aligned. Just put a segment here. Dong. 01/07/2022.
        patch_B_PPG_seg_name = ['090_2021_04_11_16_49_51_ppg_0000.txt']; % Not aligned. Just put a segment here. Dong. 01/07/2022.
    case '017'
        patch_A_PPG_idx = 8;
        patch_A_PPG_seg_name = '017_2019_12_04_16_37_38_ppg_0005';
        patch_B_PPG_idx = 8344;
        patch_B_PPG_seg_name = '017_2019_12_12_01_17_21_ppg_0001';
    case '091'
        patch_A_PPG_idx = 808;
        patch_A_PPG_seg_name = ['091_2021_04_09_04_12_20_ppg_0000.txt'];
        patch_B_PPG_idx = [4885];
        patch_B_PPG_seg_name = ['091_2021_04_18_22_19_55_ppg_0000.txt'];
    case '019'
        patch_A_PPG_idx = 158;
        patch_A_PPG_seg_name = ['019_2020_01_03_17_09_04_ppg_0002'];
        patch_B_PPG_idx = 7890;
        patch_B_PPG_seg_name = ['019_2020_01_10_20_57_36_ppg_0004'];
    case '020'
        patch_A_PPG_idx = [];
        patch_A_PPG_seg_name = [''];
        patch_B_PPG_idx = 6998;
        patch_B_PPG_seg_name = ['020_2020_01_14_18_03_47_ppg_0001'];
    case '026'
        patch_A_PPG_idx = 22;
        patch_A_PPG_seg_name = ['026_2020_02_06_14_51_19_ppg_0001'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '093'
        patch_A_PPG_idx = 375;
        patch_A_PPG_seg_name = ['093_2021_04_23_05_19_00_ppg_0000.txt'];
        patch_B_PPG_idx = 5736;
        patch_B_PPG_seg_name = ['093_2021_04_29_10_26_43_ppg_0000.txt'];
    case '034'
        patch_A_PPG_idx = 441;
        patch_A_PPG_seg_name = ['034_2020_03_02_20_48_54_ppg_0000'];
        patch_B_PPG_idx = 9290;
        patch_B_PPG_seg_name = ['034_2020_03_09_13_32_29_ppg_0000'];
    case '035'
        patch_A_PPG_idx = 625;
        patch_A_PPG_seg_name = ['035_2020_07_27_17_57_59_ppg_0000'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '099'
        patch_A_PPG_idx = 451;
        patch_A_PPG_seg_name = ['099_2021_05_19_20_17_09_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '100'
        patch_A_PPG_idx = 939;
        patch_A_PPG_seg_name = ['100_2021_05_28_01_07_20_ppg_0000.txt'];
        patch_B_PPG_idx = 11253;
        patch_B_PPG_seg_name = ['100_2021_06_05_00_40_36_ppg_0000.txt'];
    case '101'
        patch_A_PPG_idx = 121;
        patch_A_PPG_seg_name = ['101_2021_06_01_11_18_09_ppg_0000.txt'];
        patch_B_PPG_idx = 4685; % Not aligned, just put a segment here. Dong. 01/07/2022.
        patch_B_PPG_seg_name = ['101_2021_06_10_10_00_24_ppg_0000.txt']; % Not aligned, just put a segment here. Dong. 01/07/2022.
    case '104'
        patch_A_PPG_idx = 330;
        patch_A_PPG_seg_name = ['104_2021_06_09_20_12_32_ppg_0000.txt'];
        patch_B_PPG_idx = 9154;
        patch_B_PPG_seg_name = ['104_2021_06_16_21_01_36_ppg_0000.txt'];
    case '036'
        patch_A_PPG_idx = 621;
        patch_A_PPG_seg_name = ['036_2020_06_26_23_37_42_ppg_0000'];
        patch_B_PPG_idx = 9044;
        patch_B_PPG_seg_name = ['036_2020_07_04_02_41_21_ppg_0004'];
    case '054'
        patch_A_PPG_idx = 198;
        patch_A_PPG_seg_name = ['054_2020_10_02_12_15_14_ppg_0004'];
        patch_B_PPG_idx = 5179;
        patch_B_PPG_seg_name = ['054_2020_10_10_02_50_36_ppg_0000'];
    case '027'
        patch_A_PPG_idx = 345;
        patch_A_PPG_seg_name = ['027_2020_02_11_19_11_44_ppg_0004'];
        patch_B_PPG_idx = 9976;
        patch_B_PPG_seg_name = ['027_2020_02_19_07_04_34_ppg_0000'];
    case '029'
        patch_A_PPG_idx = 81;
        patch_A_PPG_seg_name = ['029_2020_02_14_12_18_34_ppg_0000'];
        patch_B_PPG_idx = 10118;
        patch_B_PPG_seg_name = ['029_2020_02_21_23_46_10_ppg_0000'];
    case '038'
        patch_A_PPG_idx = 1669;
        patch_A_PPG_seg_name = ['038_2020_06_27_02_13_28_ppg_0008'];
        patch_B_PPG_idx = 8740;
        patch_B_PPG_seg_name = ['038_2020_07_03_00_03_37_ppg_0000'];
    case '039'
        patch_A_PPG_idx = 152;
        patch_A_PPG_seg_name = ['039_2020_06_29_19_36_19_ppg_0001'];
        patch_B_PPG_idx = 2174;
        patch_B_PPG_seg_name = ['039_2020_07_06_21_12_41_ppg_0007'];
    case '041'
        patch_A_PPG_idx = 367;
        patch_A_PPG_seg_name = ['041_2020_07_15_23_28_03_ppg_0000'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '042'
        patch_A_PPG_idx = 216;
        patch_A_PPG_seg_name = ['042_2020_07_28_14_05_00_ppg_0001'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '044'
        patch_A_PPG_idx = 92;
        patch_A_PPG_seg_name = ['044_2020_08_12_18_03_48_ppg_0001'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '045'
        patch_A_PPG_idx = 269;
        patch_A_PPG_seg_name = ['045_2020_08_07_17_37_02_ppg_0008'];
        patch_B_PPG_idx = 4080;
        patch_B_PPG_seg_name = ['045_2020_08_14_18_38_07_ppg_0007'];
    case '052'
        patch_A_PPG_idx = 251;
        patch_A_PPG_seg_name = ['052_2020_09_25_18_28_42_ppg_0000'];
        patch_B_PPG_idx = 3249;
        patch_B_PPG_seg_name = ['052_2020_10_06_01_19_28_ppg_0004'];
    case '055'
        patch_A_PPG_idx = 217;
        patch_A_PPG_seg_name = ['055_2020_10_05_13_59_16_ppg_0006'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '056'
        patch_A_PPG_idx = 183;
        patch_A_PPG_seg_name = ['056_2020_18_22_59_ppg_0002'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '030'
        patch_A_PPG_idx = 316;
        patch_A_PPG_seg_name = ['030_2020_02_19_22_03_54_ppg_0005'];
        patch_B_PPG_idx = 9652;
        patch_B_PPG_seg_name = ['030_2020_02_26_19_07_28_ppg_0000'];
    case '032'
        patch_A_PPG_idx = 572;
        patch_A_PPG_seg_name = ['032_2020_02_26_22_53_23_ppg_0000'];
        patch_B_PPG_idx = 3319;
        patch_B_PPG_seg_name = ['032_2020_03_04_23_03_29_ppg_0000'];
    case '053'
        patch_A_PPG_idx = 51;
        patch_A_PPG_seg_name = ['053_2020_09_25_11_01_05_ppg_0000'];
        patch_B_PPG_idx = 6054;
        patch_B_PPG_seg_name = ['053_2020_10_02_22_47_28_ppg_0000'];
    case '057'
        patch_A_PPG_idx = 611;
        patch_A_PPG_seg_name = ['057_2020_10_20_03_16_33_ppg_0000'];
        patch_B_PPG_idx = 5981;
        patch_B_PPG_seg_name = ['057_2020_10_27_01_08_26_ppg_0000'];
    case '058'
        patch_A_PPG_idx = 495; % Not aligned, just put a segment here. Dong. 01/07/2022.
        patch_A_PPG_seg_name = ['058_2020_11_02_10_57_29_ppg_0000.txt']; % Not aligned, just put a segment here. Dong. 01/07/2022.
        patch_B_PPG_idx = 1812;
        patch_B_PPG_seg_name = ['058_2020_11_06_19_46_10_ppg_0000'];
    case '063'
        patch_A_PPG_idx = 447;
        patch_A_PPG_seg_name = ['063_2020_12_05_00_25_00_ppg_0000'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '064'
        patch_A_PPG_idx = 513;
        patch_A_PPG_seg_name = ['064_2020_12_08_22_28_08_ppg_0000'];
        patch_B_PPG_idx = 6413;
        patch_B_PPG_seg_name = ['064_2020_12_15_23_04_09_ppg_0000'];
    case '106'
        patch_A_PPG_idx = 102;
        patch_A_PPG_seg_name = ['106_2021_06_21_14_03_16_ppg_0000.txt'];
        patch_B_PPG_idx = 1337; % Not aligned, just put a segment here. 01/07/2022.
        patch_B_PPG_seg_name = ['106_2021_06_27_22_40_29_ppg_0000.txt']; % Not aligned, just put a segment here. 01/07/2022.
    case '067'
        patch_A_PPG_idx = 570;
        patch_A_PPG_seg_name = ['067_2020_12_18_22_26_27_ppg_0000'];
        patch_B_PPG_idx = 1816;
        patch_B_PPG_seg_name = ['067_2020_12_22_22_22_45_ppg_0000'];
    case '068'
        patch_A_PPG_idx = 91;
        patch_A_PPG_seg_name = ['068_2020_12_22_12_40_21_ppg_0000'];
        patch_B_PPG_idx = 3523;
        patch_B_PPG_seg_name = ['068_2020_12_29_13_55_39_ppg_0000'];
    case '070'
        patch_A_PPG_idx = 46;
        patch_A_PPG_seg_name = ['070_2021_01_05_13_05_53_ppg_000'];
        patch_B_PPG_idx = 1694;
        patch_B_PPG_seg_name = ['070_2021_01_15_22_08_11_ppg_0000'];
    case '071'
        patch_A_PPG_idx = 21;
        patch_A_PPG_seg_name = ['071_2021_01_07_16_14_00_ppg_0000'];
        patch_B_PPG_idx = 3167;
        patch_B_PPG_seg_name = ['071_2021_01_15_23_03_01_ppg_0000'];
    case '077'
        patch_A_PPG_idx = 1069;
        patch_A_PPG_seg_name = ['077_2021_02_13_03_44_35_ppg_0000'];
        patch_B_PPG_idx = 1159;
        patch_B_PPG_seg_name = ['077_2021_02_17_22_26_02_ppg_0000'];
    case '109'
        patch_A_PPG_idx = 121;
        patch_A_PPG_seg_name = ['109_2021_06_29_11_56_02_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '110'
        patch_A_PPG_idx = 221;
        patch_A_PPG_seg_name = ['110_2021_07_01_13_46_13_ppg_0000.txt'];
        patch_B_PPG_idx = 6323;
        patch_B_PPG_seg_name = ['110_2021_07_08_09_48_39_ppg_0000.txt'];
    case '082'
        patch_A_PPG_idx = 421;
        patch_A_PPG_seg_name = ['082_2021_03_05_20_08_16_ppg_0000'];
        patch_B_PPG_idx = 3985;
        patch_B_PPG_seg_name = ['082_2021_03_12_12_00_25_ppg_0000'];
    case '111'
        patch_A_PPG_idx = 214;
        patch_A_PPG_seg_name = ['111_2021_07_02_13_01_53_ppg_0003.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '112'
        patch_A_PPG_idx = 474;
        patch_A_PPG_seg_name = ['112_2021_07_06_17_11_26_ppg_0000.txt'];
        patch_B_PPG_idx = 8490;
        patch_B_PPG_seg_name = ['112_2021_07_13_21_13_24_ppg_0000.txt'];
    case '113'
        patch_A_PPG_idx = 424;
        patch_A_PPG_seg_name = ['113_2021_07_15_18_33_42_ppg_0000.txt'];
        patch_B_PPG_idx = 9867;
        patch_B_PPG_seg_name = ['113_2021_07_23_04_22_18_ppg_0000.txt'];
    case '118'
        patch_A_PPG_idx = 377;
        patch_A_PPG_seg_name = ['118_2021_08_02_21_04_51_ppg_0000.txt'];
        patch_B_PPG_idx = 4732;
        patch_B_PPG_seg_name = ['118_2021_08_10_01_45_39_ppg_0000.txt'];
    case '003'
        patch_A_PPG_idx = 179;
        patch_A_PPG_seg_name = ['003_2019_09_10_18_04_12_ppg_0000'];
        patch_B_PPG_idx = 3457;
        patch_B_PPG_seg_name = ['003_2019_09_17_19_59_13_ppg_0001'];
    case '012'
        patch_A_PPG_idx = 1057;
        patch_A_PPG_seg_name = ['012_2019_11_01_21_59_30_ppg_0002'];
        patch_B_PPG_idx = 8096;
        patch_B_PPG_seg_name = ['012_2019_11_07_21_59_15_ppg_0000'];
    case '013'
        patch_A_PPG_idx = 132;
        patch_A_PPG_seg_name = ['013_2019_11_06_13_57_07_ppg_0001'];
        patch_B_PPG_idx = 8577;
        patch_B_PPG_seg_name = ['013_2019_11_14_15_12_10_ppg_0004'];
    case '024'
        patch_A_PPG_idx = 669;
        patch_A_PPG_seg_name = ['024_2020_01_29_23_59_59_ppg_0006'];
        patch_B_PPG_idx = 7329;
        patch_B_PPG_seg_name = ['024_2020_02_05_21_45_28_ppg_0000'];
    case '028'
        patch_A_PPG_idx = 371;
        patch_A_PPG_seg_name = ['028_2020_02_13_18_44_37_ppg_0000'];
        patch_B_PPG_idx = 9328;
        patch_B_PPG_seg_name = ['028_2020_02_20_23_19_28_ppg_0000'];
        patch_C_PPG_idx = 10134;
        patch_C_PPG_seg_name = ['028_2020_02_21_12_43_33_ppg_0006'];
    case '021'
        patch_A_PPG_idx = 323;
        patch_A_PPG_seg_name = ['021_2020_01_14_21_29_09_ppg_0002'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '022'
        patch_A_PPG_idx = 1069;
        patch_A_PPG_seg_name = ['022_2020_01_24_00_49_22_ppg_0004'];
        patch_B_PPG_idx = 9669;
        patch_B_PPG_seg_name = ['022_2020_01_30_10_06_11_ppg_0000'];
    case '009'
        patch_A_PPG_idx = 303;
        patch_A_PPG_seg_name = ['009_2019_10_07_18_43_38_ppg_0007'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '014'
        patch_A_PPG_idx = 76;
        patch_A_PPG_seg_name = ['014_2019_11_12_11_59_35_ppg_0000'];
        patch_B_PPG_idx = 10293;
        patch_B_PPG_seg_name = ['014_2019_11_20_01_51_43_ppg_0000'];
    case '047'
        patch_A_PPG_idx = 63;
        patch_A_PPG_seg_name = ['047_2020_09_01_14_10_29_ppg_0002'];
        patch_B_PPG_idx = 4678;
        patch_B_PPG_seg_name = ['047_2020_09_13_20_39_03_ppg_0000'];
    case '049'
        patch_A_PPG_idx = 906;
        patch_A_PPG_seg_name = ['049_2020_09_05_06_41_23_ppg_0000.txt'];
        patch_B_PPG_idx = 4599; % Not aligned, just input a segment. 01/07/2022. Dong.
        patch_B_PPG_seg_name = ['049_2020_09_11_23_51_11_ppg_0000.txt']; % Not aligned, just input a segment. 01/07/2022. Dong.
    case '050' % Not aligned, just input a segment. 01/07/2022. Dong.
        patch_A_PPG_idx = 201; % Not aligned, just input a segment. 01/07/2022. Dong.
        patch_A_PPG_seg_name = ['050_2020_09_25_14_21_45_ppg_0000.txt']; % Not aligned, just input a segment. 01/07/2022. Dong.
        patch_B_PPG_idx = []; 
        patch_B_PPG_seg_name = ['']; 
    case '011'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['011_2019_10_21_08_20_06_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '007'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['007_2019_09_20_10_35_02_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '062'
        patch_A_PPG_idx = 501; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['062_2020_11_21_18_24_04_ppg_0000.txt'];
        patch_B_PPG_idx = 3378;
        patch_B_PPG_seg_name = ['062_2020_11_28_04_25_04_ppg_0000.txt'];
    case '119'
        patch_A_PPG_idx = 3620; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['119_2021_08_06_15_58_43_ppg_0000.txt'];
        patch_B_PPG_idx = 10786; % This is for second watch, not for the remaining data from 1st watch. Dong. 01/07/2022.
        patch_B_PPG_seg_name = ['119_2021_08_12_09_36_09_ppg_0000.txt']; % This is for second watch, not for the remaining data from 1st watch. Dong. 01/07/2022.
    case '120'
        patch_A_PPG_idx = []; 
        patch_A_PPG_seg_name = [''];
        patch_B_PPG_idx = 6593; % Not aligned, just put a segment here. 01/07/2022.
        patch_B_PPG_seg_name = ['120_2021_08_14_08_47_33_ppg_0000.txt']; % Not aligned, just put a segment here. 01/07/2022.
    % Below are not aligned, just to generate the timestamp for UMass.
    % 01/09/2022.
    case '001'
        patch_A_PPG_idx = 1; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['001_2019_09_03_10_25_24_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = []; % No data for patch B. 01/09/2022.
        patch_B_PPG_seg_name = [''];
    case '006' % No ECG data.
        patch_A_PPG_idx = 1; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['006_2019_09_17_09_31_57_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
    case '037'
        patch_A_PPG_idx = []; % No patch A ECG. 01/09/2022.
        patch_A_PPG_seg_name = ['']; % No patch A ECG. 01/09/2022.
        patch_B_PPG_idx = 6658; % All null. 01/09/2022.
        patch_B_PPG_seg_name = ['037_2020_07_10_15_48_26_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
    case '051'
        patch_A_PPG_idx = []; % No patch A ECG. 01/09/2022.
        patch_A_PPG_seg_name = ['']; % No patch A ECG. 01/09/2022.
        patch_B_PPG_idx = []; % No data for patch B ECG. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % No data for patch B ECG. 01/09/2022.
    case '069'
        patch_A_PPG_idx = []; % No patch A ECG. 01/09/2022.
        patch_A_PPG_seg_name = ['']; % No patch A ECG. 01/09/2022.
        patch_B_PPG_idx = [2687]; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_seg_name = ['069_2021_01_07_02_30_49_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
    case '073'
        patch_A_PPG_idx = 311; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['073_2021_01_21_12_22_18_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = []; % No patch B ECG. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % No patch B ECG. 01/09/2022.
    case '074'
        patch_A_PPG_idx = 1; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['074_2021_02_02_13_21_25_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = 620; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_seg_name = ['074_2021_02_04_11_58_53_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
    case '094'
        patch_A_PPG_idx = 61; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['094_2021_04_23_12_26_47_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = []; % No patch B ECG. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % % No patch B ECG. 01/09/2022.
    case '096'
        patch_A_PPG_idx = []; % No patch A ECG. 01/09/2022.
        patch_A_PPG_seg_name = ['']; % No patch A ECG. 01/09/2022.
        patch_B_PPG_idx = []; % No patch B ECG. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % No patch B ECG. 01/09/2022.
        patch_C_PPG_idx = 481; % Not aligned, just put a segment here. 01/09/2022.
        patch_C_PPG_seg_name = ['096_2021_05_24_11_35_40_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
    case '098'
        patch_A_PPG_idx = 1; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['098_2021_05_13_15_16_19_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = 7879; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_seg_name = ['098_2021_05_19_08_10_30_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
    case '102'
        patch_A_PPG_idx = 4; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['102_2021_06_02_13_27_36_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = []; % No watch data for patch B. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % No watch data for patch B. 01/09/2022.
    case '108'
        patch_A_PPG_idx = 1; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['108_2021_06_29_12_13_43_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = 2609; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_seg_name = ['108_2021_07_05_13_39_58_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
    case '116'
        patch_A_PPG_idx = 21; % Not aligned, just put a segment here. 01/09/2022.
        patch_A_PPG_seg_name = ['116_2021_07_30_12_59_11_ppg_0000.txt']; % Not aligned, just put a segment here. 01/09/2022.
        patch_B_PPG_idx = []; % No patch B ECG. 01/09/2022.
        patch_B_PPG_seg_name = ['']; % No patch B ECG. 01/09/2022.
%     case ''
%         patch_A_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
%         patch_A_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
%         patch_B_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
%         patch_B_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
%     case ''
%         patch_A_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
%         patch_A_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
%         patch_B_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
%         patch_B_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
%     case ''
%         patch_A_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
%         patch_A_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
%         patch_B_PPG_idx = []; % Not aligned, just put a segment here. 01/09/2022.
%         patch_B_PPG_seg_name = ['']; % Not aligned, just put a segment here. 01/09/2022.
    case '400' % AF trial in 05/24/2021.
        patch_A_PPG_idx = 226; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['400_2021_05_24_15_56_59_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    %% --- old AF trial ---
    case '301'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['301_2020_01_06_09_39_17_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '302'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['302_2020_01_06_11_05_13_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '305'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['305_2020_01_07_14_27_47_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '306'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['306_2020_01_13_09_28_46_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '307'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['307_2020_01_13_12_14_55_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '310'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['310_2020_03_04_13_54_36_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '311'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['311_2020_03_06_14_33_18_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '312'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['312_2020_03_12_08_38_43_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '314'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['314_2020_07_31_16_22_28_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '318'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['318_2020_08_04_14_02_08_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '319'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['319_2020_08_05_11_22_26_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '320'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['320_2020_08_05_13_14_31_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '321'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['321_2020_08_06_10_00_03_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '322'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['322_2020_08_06_14_33_30_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '324'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['324_2020_08_06_16_06_59_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '325'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['325_2020_08_06_16_37_02_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '327'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['327_2020_08_11_14_24_53_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '329'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['329_2020_08_12_10_38_28_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '405'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['405_2021_09_22_00_06_29_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '406'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['406_2021_09_24_00_04_02_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '408'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['408_2021_10_01_00_18_51_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '409'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['409_2021_10_06_00_34_04_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '410'
        patch_A_PPG_idx = 1; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['410_2021_10_08_00_31_27_ppg.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '402'
        patch_A_PPG_idx = 635; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['402_2021_07_02_00_02_31_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '413'
        patch_A_PPG_idx = 1054; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['413_2021_10_20_05_53_25_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '414'
        patch_A_PPG_idx = 482; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['414_2021_10_22_23_40_02_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '415'
        patch_A_PPG_idx = 1311; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['415_2021_10_26_06_00_38_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '416'
        patch_A_PPG_idx = 685; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['416_2021_10_28_22_00_55_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '419'
        patch_A_PPG_idx = 350; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['419_2021_11_08_16_23_36_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '407'
        patch_A_PPG_idx = 338; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['407_2021_09_28_15_34_39_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '417'
        patch_A_PPG_idx = 670; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['417_2021_11_02_22_07_17_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '420'
        patch_A_PPG_idx = 392; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['420_2021_11_30_16_47_33_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '421'
        patch_A_PPG_idx = 202; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['421_2021_12_06_13_41_31_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '422'
        patch_A_PPG_idx = 74; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['422_2021_12_13_10_55_48_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
    case '423'
        patch_A_PPG_idx = 97; % throw a model so we use the first segment
        patch_A_PPG_seg_name = ['423_2021_12_16_10_03_35_ppg_0000.txt'];
        patch_B_PPG_idx = [];
        patch_B_PPG_seg_name = [''];
end
if ~exist('patch_C_PPG_idx','var') % only UID 028 has patch C.
    patch_C_PPG_idx = [];
    patch_C_PPG_seg_name = [];
end
end
