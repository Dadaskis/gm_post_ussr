from os import listdir 
from os.path import isfile, join
import os
import pathlib
import pickle

path = "G:/Other Stuff/Archive/ModelStuff/gm_post_ussr/3_SkyboxTextures"
path_to_export_textures = "G:/Other Stuff/Games/SteamLibrary/steamapps/common/GarrysMod/garrysmod/materials/skybox"
cd_materials = "skybox/"

files_list = [f for f in listdir("./") if isfile(join("./", f))]

materials = {}

def valid_material(name):
    if materials.get(name) == None:
        materials.update({ name : {} })

def add_material_mark(name, mark):
    valid_material(name)
    #materials[name] = mark
    materials[name].update({ mark : True })

def update_material_time(name, time):
    valid_material(name)
    old_time = materials[name].get("__TIME")
    if old_time == None or old_time < time:
        materials[name].update({ "__TIME" : time })

def get_material_time(name):
    valid_material(name)
    return materials[name].get("__TIME")

def add_material_mark_raw(file_name, remove_part, mark):
    name = file_name.replace(remove_part, "")
    add_material_mark(name, mark)
    path_data = pathlib.Path(path + "/" + file_name)
    last_modified = path_data.stat().st_mtime
    update_material_time(name, last_modified)

def get_material_mark(name, mark):
    return materials[name].get(mark)

def is_material_mark_valid(name, mark):
    return get_material_mark(name, mark) != None

def get_materials_names():
    return list(materials.keys())

postfix_to_mark = {
    "d.tga" : "Diffuse"
    #"bk.tga" : "Back",
    #"dn.tga" : "Down",
    #"ft.tga" : "Front",
    #"lf.tga" : "Left",
    #"rt.tga" : "Right",
    #"up.tga" : "Up"
}

mark_to_postfix = {}

for postfix in postfix_to_mark.keys():
    mark = postfix_to_mark[postfix]
    #mark_to_postfix[mark] = postfix.split(".")[0]
    mark_to_postfix.update({ mark : postfix.split(".")[0] })

for file_name in files_list:
    splits = file_name.split("_")
    for postfix in postfix_to_mark.keys():
        if splits[-1] == postfix:  
            add_material_mark_raw(file_name, "_" + postfix, postfix_to_mark[postfix])

time_table = {}

def is_new_value(value, time):
    time_value = time_table.get(value)
    if time_value == None:
        return True
    if time_value < time:
        return True
    return False

try:
    with open("time.table", "rb") as handle:
        time_table = pickle.load(handle)
except Exception:
    print("Cant load time table")

def build_texture_files(material_name):
    for postfix in postfix_to_mark.keys():
        mark = postfix_to_mark[postfix]
        if is_material_mark_valid(material_name, mark):
            file_name = material_name + "_" + postfix
            path_data = pathlib.Path(path + "/" + file_name)
            last_modified = path_data.stat().st_mtime
            if is_new_value(file_name, last_modified):
                os.system("VTFCmd.bat \"" + file_name + "\" \"" + path_to_export_textures + "\"")
                time_table.update({ file_name : get_material_time(material_name) })

def create_material_file(material_name):
    def mark(name):
        return get_material_mark(material_name, name)

    material_file_content = ""

    material_file_content += """
        "UnlitGeneric" {
            "$nofog" "1"
            "$ignorez" "1"
    """ 

    #list_of_sides = ["Back", "Right", "Left", "Front", "Up", "Down"]

    #for side in list_of_sides:
    #    if mark(side):
    #        material_file_content += """
    #            "$basetexture" \"""" + cd_materials + material_name + "_" + mark_to_postfix[side] + """"
    #            "$hdrbasetexture" \"""" + cd_materials + material_name + "_" + mark_to_postfix[side] + """"
    #        """
    
    if mark("Diffuse"):
        material_file_content += """
            "$basetexture" \"""" + cd_materials + material_name + "_" + mark_to_postfix["Diffuse"] + """"
            "$hdrbasetexture" \"""" + cd_materials + material_name + "_" + mark_to_postfix["Diffuse"] + """"
        """

    material_file_content += """
        }
    """

    with open(path_to_export_textures + "/" + material_name + ".vmt", "w") as f:
        f.write(material_file_content)

for material_name in get_materials_names():
    if is_new_value(material_name, get_material_time(material_name)):
        build_texture_files(material_name)
        create_material_file(material_name)
        time_table.update({ material_name : get_material_time(material_name) })

with open('time.table', 'wb') as handle:
    pickle.dump(time_table, handle, protocol = pickle.HIGHEST_PROTOCOL)