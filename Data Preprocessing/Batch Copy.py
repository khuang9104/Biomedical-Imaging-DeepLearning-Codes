import os
import shutil
import pandas as pd
 
def find_files(file_path1, target, result):                                   # find file
    files = os.listdir(file_path1)                                            # find all files in this folder
    i=0
    for file in files:
        npath = file_path1 + '/' + file                                       # Path + file name
        if os.path.isfile(npath):
            for i in id:
                id_fix = str(i).split("-")[0] + '-' + str(i).split("-")[1] + '-0' + str(i).split("-")[-1]
                if file.endswith(target) & file.startswith(id_fix):           # Match target (endwith)
                    result.append(npath)
        if os.path.isdir(npath):                                              # Next folder
            if file[0] == '.':
                pass
            else:
                find_files(npath, target, result)
    return result

def copy_file(file_path2, result):                                            # Copy files
    for file in result:
        folderName = str(str(file).split("_")[0]).split("/")[-1]          
        folderPath = file_path2 + "/" + folderName                       
        folderisExist = os.path.exists(folderPath)                            # Check whether the folder exist.
        if not folderisExist:                                                 # If the folder is not exist, creat it.
            os.makedirs(folderPath)
        file2 = folderPath + "/" + str(file).split("/")[-1]                   # Path and file name
        shutil.copy(file, file2)                                              # Copy
    print('Copy completed!')
 
if __name__ == "__main__":
    targetfile = 'FLAIR.nii.gz'
    file_path1 = r"D:\Master-UCD\Y2S1\Biomedical Image\UCSF-PDGM-nifti"       # Copy from path
    file_path2 = r"D:\Master-UCD\Y2S1\Biomedical Image\DatesetCopy-Grade4-A-IDHm"  # Copy to path
    metadata_path = r"C:\Users\khuan\Desktop\UCSF-PDGM-metadata.xlsx"         # Metadata path
    sheetname = "Grade 4(A-im)"
    df = pd.read_excel(metadata_path, sheet_name = sheetname)
    id = df.iloc[:, 0]
    result = []
    find_files(file_path1, targetfile, result)
    copy_file(file_path2, result)