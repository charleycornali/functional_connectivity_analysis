bold_tc_folder='/space/raid6/data/rissman/Nicco/HCP_ALL/Resting_State/BOLD_TCs';
endfolder='/space/raid6/data/rissman/Nicco/HCP_ALL/Resting_State/Mean_TCs';
ROIs_folder='/space/raid6/data/rissman/Nicco/MNI/Petersen_264';

%ROIsDir=dir(ROIsfolder);
%ROI_file_list={ROIsDir.name};
%%ROIs_list=ROI_file_list([ROIsDir.isdir]);


ROI_file_paths={};
ROI_files=dir(fullfile(ROIs_folder, '*.nii'));
for i=1:length(ROI_files)
    %creates an array of the paths to the ROIs in the Peterson folder
    ROI_file_paths{end+1}=fullfile(ROIs_folder, ROI_files(i).name);
end

bold_tc_file_paths={};
bold_tc_files=dir(fullfile(bold_tc_folder, '*.mat'));
%loops through each subject time-course
for j=1:length(bold_tc_files)
    bold_tc_file_paths{end+1}=fullfile(bold_tc_folder, bold_tc_files(j).name);
    %loop for getting the mean over all voxels in an ROI at each time point, for all 264 ROIs
    for i=1:length(ROI_file_paths)
        %gets file name of ROIs from paths in ROIsfolderpaths
        disp(sprintf('Will make the mean time-coourse for ROI file %s and apply it to %s: '), ROI_files(i).name, bold_tc_files(j).name);
        ROI_path_to_file=fullfile(ROI_file_paths{i});
        %reads in the ROI mask file from Peterson directory
        V=spm_vol(ROI_path_to_file);
        vols=spm_read_vols(V);
        %index of active voxels of ROI in curent mask
        cur_mask_idx=find(vols);
        disp(sprintf('Creating mean time-course for voxels for file %s with the ROI %s mask:'), bold_tc_files(j).name, ROI_files(i).name);
        mean_timecourse=[];
        %loop for loading each time-course for each time point
        current_bold_tc=bold_tc_file_paths{j};
        for t=1:length(current_bold_tc, 4)
            cur_timepoint=bold_tc(:,:,:,t);
            %creates mean time course for the voxels within the current ROI
            mean_timecourse=horzcat(mean_timecourse, mean(cur_timepoint(cur_mask_idx)));
        end
    end
end