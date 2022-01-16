cd 1_PropExport
ping 127.0.0.1 -n 4 > nul
python create_qc.py
python build_qc.py