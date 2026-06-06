import os
import re

files = [
    'DuLieuTest.sql',
    'learning_management_app/lib/main.dart',
    'learning_management_app/lib/screens/admin/admin_home_screen.dart',
    'learning_management_app/lib/screens/lecturer/widgets/home/function_grid.dart',
    'learning_management_app/lib/screens/lecturer/widgets/profile/main_menu_card.dart',
    'learning_management_app/lib/screens/lecturer/widgets/profile/settings_card.dart'
]

def resolve_file(filepath):
    if not os.path.exists(filepath):
        print(f"File not found: {filepath}")
        return
        
    with open(filepath, 'r', encoding='utf-8') as f:
        lines = f.readlines()
        
    new_lines = []
    in_head = False
    in_remote = False
    
    for line in lines:
        if line.startswith('<<<<<<< HEAD'):
            in_head = True
            continue
        elif line.startswith('======='):
            in_head = False
            in_remote = True
            continue
        elif line.startswith('>>>>>>>'):
            in_remote = False
            continue
            
        if not in_remote:
            new_lines.append(line)
            
    with open(filepath, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)
    print(f"Resolved {filepath}")

for f in files:
    resolve_file(f)
