
file_number = 43;                                                % Total images
cd 'D:\Master-UCD\Y2S1\Biomedical Image\Dateset copy-Grade 3'     % Target images address
MyFolderInfo_0 = dir('**/*tumor_segmentation.nii.gz');            % target image type
MyFolderInfo_1 = dir('**/*T2.nii.gz');                            % image type (To be selected 1)
MyFolderInfo_2 = dir('**/*FLAIR.nii.gz');                         % image type (To be selected 2)
MyFolderInfo_3 = dir('**/*T1c.nii.gz');                           % image type (To be selected 3)

% Create output folder
mkdir TumorSegmentation
mkdir T2
mkdir FLAIR
mkdir T1c

for i = 1:file_number
    % Read NIfTI Data-0
    image_0 = niftiread([MyFolderInfo_0(i).folder,'\', MyFolderInfo_0(i).name]);
    nifti_array_0 = size(image_0);
    double_0 = im2double(image_0);

    % Read NIfTI Data-1
    image_1 = niftiread([MyFolderInfo_1(i).folder,'\', MyFolderInfo_1(i).name]);
    double_1 = im2double(image_1);

    % Read NIfTI Data-2
    image_2 = niftiread([MyFolderInfo_2(i).folder,'\', MyFolderInfo_2(i).name]);
    double_2 = im2double(image_2);

    % Read NIfTI Data-3
    image_3 = niftiread([MyFolderInfo_3(i).folder,'\', MyFolderInfo_3(i).name]);
    double_3 = im2double(image_3);

    % Get Vols and Slice
    total_slices = nifti_array_0(3);
    slice_counter = 0;
    % Iterate Through Slices
    current_slice = 1;
    while current_slice <= total_slices
        % Alternate Slices
        if mod(slice_counter, 1) == 0 && max(image_0(:,:,current_slice),[],'all') == 255  % Select
            data_0 = mat2gray(double_0(:,:,current_slice));
            data_1 = mat2gray(double_1(:,:,current_slice));
            data_2 = mat2gray(double_2(:,:,current_slice));
            data_3 = mat2gray(double_3(:,:,current_slice));

            % Set Filename as per slice and vol info
            filename_oringin_0 = string(extractBefore(MyFolderInfo_0(i).name,".nii.gz"));
            filename_0 = filename_oringin_0 + "-" + sprintf('%03d', current_slice) + ".png";
            filename_oringin_1 = string(extractBefore(MyFolderInfo_1(i).name,".nii.gz"));
            filename_1 = filename_oringin_1 + "-" + sprintf('%03d', current_slice) + ".png";
            filename_oringin_2 = string(extractBefore(MyFolderInfo_2(i).name,".nii.gz"));
            filename_2 = filename_oringin_2 + "-" + sprintf('%03d', current_slice) + ".png";
            filename_oringin_3 = string(extractBefore(MyFolderInfo_3(i).name,".nii.gz"));
            filename_3 = filename_oringin_3 + "-" + sprintf('%03d', current_slice) + ".png";

            % Write Image
            imwrite(data_0, char(filename_0));
            imwrite(data_1, char(filename_1));
            imwrite(data_2, char(filename_2));
            imwrite(data_3, char(filename_3));

            % Move Images To Folder
            movefile(char(filename_0),'TumorSegmentation');             % To folder TumorSegmentation
            movefile(char(filename_1),'T2');                            % To folder T2
            movefile(char(filename_2),'FLAIR');                         % To folder FLAIR
            movefile(char(filename_3),'T1c');                           % To folder FLAIR

            % Increment Counters
            slice_counter = slice_counter + 1;
        end
        current_slice  = current_slice  + 1;
    end
end