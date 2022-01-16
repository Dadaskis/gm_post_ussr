from os import listdir 
from os.path import isfile, join
import os
import pathlib
import pickle

time_table = {}

try:
    with open("time.table", "rb") as handle:
        time_table = pickle.load(handle)
except Exception:
    print("Cant load time table")

path = "G:/Other Stuff/Archive/ModelStuff/gm_post_ussr/1_PropExport"

files_list = [f for f in listdir("./") if isfile(join("./", f))]

for file_name in files_list:
    splits = file_name.split(".")
    if splits[-1] == "smd":
        del splits[-1]
        if len(splits) > 1:
            print(file_name)
            old_file_name = file_name
            file_name = file_name.replace(".smd", "")
            file_name = file_name.replace(".", "_")
            try:
                os.rename(old_file_name, file_name + ".smd")
            except FileExistsError:
                os.remove(file_name + ".smd")
                os.rename(old_file_name, file_name + ".smd")
            print(file_name)

files_list = [f for f in listdir("./") if isfile(join("./", f))]

for file_name in files_list:
    splits = file_name.split(".")
    if splits[-1] == "smd":
        file_name_only = file_name.replace(".smd", "")
        blacklist_in_words = ["_Phys", "_LOD"]
        blacklisted = False
        for blacklist_word in blacklist_in_words:
            if blacklist_word in file_name_only:
                blacklisted = True
        if blacklisted:
            continue
        path_data = pathlib.Path(path + "/" + file_name)
        last_modified = path_data.stat().st_mtime
        is_new = False
        time_value = time_table.get(file_name)
        if time_value == None:
            is_new = True
        elif time_value < last_modified:
            is_new = True
        if is_new:
            print("Creating new " + file_name_only + ".qc")
            with open(file_name_only + ".qc", "w") as file:

                phys_available = False
                lod_available = False

                physics_file = file_name_only
                lod_list = []

                model_files = []

                for models_file_name in files_list:
                    if file_name_only in models_file_name:
                        model_files.append(models_file_name)

                if file_name_only + "_Phys.smd" in model_files:
                    physics_file = file_name_only + "_Phys"
                    phys_available = True

                for model_file in model_files:
                    if "_LOD" in model_file:
                        lod_available = True
                        lod_threshold = model_file.replace(file_name_only + "_LOD", "").replace(".smd", "")
                        lod_list.append(lod_threshold)

                if lod_available:
                    lod_list_num = []
                    for lod_value in lod_list:
                        lod_list_num.append(int(lod_value))
                    lod_list_num.sort()
                    lod_list = []
                    for lod_value in lod_list_num:
                        lod_list.append(str(lod_value))

                content = """
                $cd \"""" + path + """\"

                $modelname "gm_post_ussr/""" + file_name_only + """.mdl"

                $scale 1

                $body 1 \"""" + file_name_only + """.smd"

                $cdmaterials "gm_post_ussr/props"

                $contents "solid"

                $sequence idle "idle.smd" {
                    fps 1
                }

                $staticprop"""
                    
                if phys_available:
                    content += """
                    $collisionmodel \"""" + physics_file + """.smd" 
                    {
                        $concave
                        $mass 100
                        $maxconvexpieces 1000
                    }"""

                if lod_available:
                    for lod_threshold in lod_list:
                        content += """
                        $lod """ + lod_threshold + """ 
                        {
                            replacemodel \"""" + file_name_only + ".smd" + """\" \"""" + file_name_only + "_LOD" + lod_threshold + ".smd" + """\"
                        }
                        """

                file.write(content)

with open('time.table', 'wb') as handle:
    pickle.dump(time_table, handle, protocol = pickle.HIGHEST_PROTOCOL)

print("DONE")
