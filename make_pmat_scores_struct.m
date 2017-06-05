%make_pmat_scores_struct
rs_folder='/space/raid6/data/rissman/Nicco/HCP_ALL/Resting_State';
PMAT_Scores_folder='/space/raid6/data/rissman/Nicco/HCP_ALL/Resting_State/PMAT';
cd(PMAT_Scores_folder)

filename='PMAT_scores.xlsx';
SS_ids=xlsread(filename, 'A:A');
PMAT24_A_CR_scores=xlsread(filename, 'F:F');
PMAT24_A_SI_scores=xlsread(filename, 'G:G');
PMAT24_A_RTCR_scores=xlsread(filename, 'H:H');

subject_PMAT_struct=struct();
for i=1:length(SS_ids)
	subject_PMAT_struct(i).Subject_ID=SS_ids(i);
	subject_PMAT_struct(i).PMAT24_A_CR=PMAT24_A_CR_scores(i);
	subject_PMAT_struct(i).PMAT24_A_SI=PMAT24_A_SI_scores(i);
	subject_PMAT_struct(i).PMAT24_A_RTCR=PMAT24_A_RTCR_scores(i);
end

save PMAT_Struct.mat subject_PMAT_struct