# Step 1: find inital alignment point

Dong, last edit 12/10/2021.

Template:
- Code to run:
- Which platform to run the code:
- Output:
- How to upload output to HPC:




### 2. Know the PPG segment index to start with.
- For AF trial, just find a PPG index after the start time of ECG. It does not have to be a PPG segment that is clean.
- For clinical trial, you have to visually find the clean PPG data using the watch data only plot, and use the excel file to find that PPG index.

  You can check the pre-saved watch data plot, and find the next PPG index using the plots in this folder: `R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\null_signal_detection\Figure_ACC\**UID**`.

  Where to find the PPG index? In Research Drive: `R:\ENGR_Chon\Dong\MATLAB_generate_results\NIH_PulseWatch\GROUND_TRUTH_NOISE_DET\Full_GT\***_full_GT_Dong.xlsx`.

  If the Excel sheet does not exist, use this code to generate it: [main_gen_Excel_before_labeling_GT.m](..\noise_ground_truth\main_gen_Excel_before_labeling_GT.m)

- If the ECG is too noisy, you may check the clean ECG hours using these plots:
  `R:\ENGR_Chon\NIH_Pulsewatch_Database\Patch_ECG_Billal_Peak_1_hr_plot`. 
  You may use the `.fig` file to zoom in the one-hour ECG.

### 3. Adjust 3 plotting parameters:
- For clinical trial only:
  - `num_load_next_PPG_seg`: number of consecutive PPG segments you would like to plot and align together. (You do not need to change `num_load_next_PPG_seg` for AF trial since I set to plot all segments from this UID and there are not a lot of segments for UIDs in the AF trial.)

- For AF trial and clinical trial:
  - `show_ECG_min_left`: total **minutes** of ECG you would like to plot to extend the ECG on the left.
  - `show_ECG_min_right`: total **minutes** of ECG you would like to plot to extend the ECG on the right.
  
  These two parameters are helpful when the time shift is too far away.

### 4. Make sure there is watch data in that patch:
Pay attention to the latest patch start time in UMass Google Sheet [Pulsewatch Enrolled Participants](https://docs.google.com/spreadsheets/d/1CIU1MW6bYnkC4KjhCqoi77Cv6eSYDQTNbHdj73Y14H8/edit?usp=sharing), Sheet "Cardiac Insight for Aim 2 Intervention". My Google Sheet [[UConn] Patch ECG Actual Start Time/alignment status](https://docs.google.com/spreadsheets/d/1SwyjQ993xFzRzO3EyzzWKgtvNhW5fGy6oTtSbcKf1I0/edit?usp=sharing) patch start time may be outdated. 

You can either use the Excel sheet to know the watch file start time, or manually check in this folder: `R:\ENGR_Chon\NIH_Pulsewatch_Database\Final_Clinical_Trial_Data`.

## Run the code:
### 4. Hit `F5` to run the code.

### 5. To adjust alignment:
change the value `manual_add_sec`. Positive value means move ECG to the right (if ECG HR is to the left of the PPG HR).
**This variable is moving the ECG HR, not the PPG HR. Please different it with the `manual_add_sec` in the function [fine-tune alignment with PPG](../fine_tune_alignment/main_finetune_alignment_5_min.m).**

### 6. Run [line 492 to 523](https://github.uconn.edu/doh16101/Pulsewatch_alignment/blob/Cassey/main/main.m#L492-L523) again after you change the 'manual_add_sec'.
Plot the shifted ECG HR and see if ECG and PPG are aligned.

### 7. After aligned ECG and PPG:
- Which means you fianlized `manual_add_sec`, add this time to `Patch_A_start_time` (AF trial will only use patch A, but clinical trial also has patch A to align) or `Patch_B_start_time` or even `Patch_C_start_time ` in this func: [`my_func_UID_ECG_final_path.m`](../func/my_func_UID_ECG_final_path.m)
- **_IMPORTANT_**: 

  Always log the new patch time `Patch_A_start_time` or `Patch_B_start_time` or `Patch_C_start_time` to column I in Google Sheet [[UConn] Patch ECG Actual Start Time/alignment status](https://docs.google.com/spreadsheets/d/1SwyjQ993xFzRzO3EyzzWKgtvNhW5fGy6oTtSbcKf1I0/edit?usp=sharing). Switch to sheet 'Clinical_Trial' or 'AF_Trial' based on which UID you are aligning. If your ECG patch time is precise to millisecond, always modify the `.` before millisecond to `-` in Google Sheet. 
  
  Also put the value of `manual_add_sec` in column J in above Google Sheet.

