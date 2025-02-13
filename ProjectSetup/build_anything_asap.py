import time
from watchdog.observers import Observer
from watchdog.events import PatternMatchingEventHandler
import os

def build_process(src_path):
    if "time.table" in src_path:
        return
    folder_name = src_path.split("\\")[1]
    if folder_name == "0_MapTextures" or folder_name == "0_PropTextures" or folder_name == "0_DecalTextures" or folder_name == "0_SpriteTextures":
        os.system("build_textures.bat")
    if folder_name == "1_PropExport":
        os.system("build_models.bat")   



def on_created(event):
    build_process(event.src_path) 
    #print(f"hey, {event.src_path} has been created!")

def on_deleted(event):
    build_process(event.src_path)
    #print(f"what the f**k! Someone deleted {event.src_path}!")

def on_modified(event):
    build_process(event.src_path)
    #print(f"hey buddy, {event.src_path} has been modified")

def on_moved(event):
    build_process(event.src_path)
    #print(f"ok ok ok, someone moved {event.src_path} to {event.dest_path}")

if __name__ == "__main__":
    patterns = ["*"]
    ignore_patterns = None
    ignore_directories = False
    case_sensitive = True
    my_event_handler = PatternMatchingEventHandler(patterns, ignore_patterns, ignore_directories, case_sensitive)
    my_event_handler.on_created = on_created
    my_event_handler.on_deleted = on_deleted
    my_event_handler.on_modified = on_modified
    my_event_handler.on_moved = on_moved
    path = "."
    go_recursively = True
    my_observer = Observer()
    my_observer.schedule(my_event_handler, path, recursive=go_recursively)
    my_observer.start()
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        my_observer.stop()
        my_observer.join()