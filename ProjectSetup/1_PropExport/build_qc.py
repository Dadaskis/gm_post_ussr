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

def build_model(name):
    os.system("cd \"G:/Other Stuff/Archive/ModelStuff/gm_post_ussr/1_PropExport\"")
    os.system("studiomdl.bat \"" + path + "/" + name)

for file_name in files_list:
    if ".qc" in file_name:
        ref_model_file_name = file_name.replace(".qc", ".smd")
        path_data = pathlib.Path(path + "/" + ref_model_file_name)
        last_modified = path_data.stat().st_mtime
        is_new = False
        time_value = time_table.get(ref_model_file_name)
        if time_value == None:
            is_new = True
        elif time_value < last_modified:
            is_new = True
        if is_new:
            build_model(file_name)
            time_table.update({ ref_model_file_name : last_modified })

with open('time.table', 'wb') as handle:
    pickle.dump(time_table, handle, protocol = pickle.HIGHEST_PROTOCOL)

print("DONE")
