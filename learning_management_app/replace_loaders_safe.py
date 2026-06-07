import os
import glob
import re

directory = r'd:\file_ky6\LAPTRINH_Java\DoAn_LEARNINGSYSTEM\LearningManagementSystem\learning_management_app\lib'
dart_files = glob.glob(os.path.join(directory, '**', '*.dart'), recursive=True)

import_statement = "import 'package:learning_management_app/core/widgets/custom_loading_indicator.dart';\n"

replacements = {
    # 1-liners
    "return const Center(child: CircularProgressIndicator());": "return const Center(child: CustomLoadingIndicator());",
    "return const Center(child: CircularProgressIndicator(color: Colors.white));": "return const Center(child: CustomLoadingIndicator());",
    "return const Center(child: CircularProgressIndicator(color: _kPrimary));": "return const Center(child: CustomLoadingIndicator());",
    "? const Center(child: CircularProgressIndicator(color: Color(0xFFC62828)))": "? const Center(child: CustomLoadingIndicator())",
    "return const Center(child: CircularProgressIndicator(color: Color(0xFFC62828)));": "return const Center(child: CustomLoadingIndicator());",
    "child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFC62828))": "child: CustomLoadingIndicator()",
    "const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: _kPrimary))": "const SizedBox(width: 18, height: 18, child: CustomLoadingIndicator())",
    "child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF2E7D32))": "child: CustomLoadingIndicator()",
    "child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF5C6BC0))": "child: CustomLoadingIndicator()",
    "child: CircularProgressIndicator(color: Color(0xFF5C6BC0))": "child: CustomLoadingIndicator()",
    "child: CircularProgressIndicator(color: _kPrimary)": "child: CustomLoadingIndicator()",
    "return const Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()));": "return const Center(child: Padding(padding: EdgeInsets.all(20), child: CustomLoadingIndicator()));",
    
    # multiline blocks
    """child: CircularProgressIndicator(
                              color: const Color(0xFF10B981),
                            )""": "child: CustomLoadingIndicator()",
    
    """child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )""": "child: CustomLoadingIndicator()",
                          
    """child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          )""": "child: CustomLoadingIndicator()"
}

for file_path in dart_files:
    if 'custom_loading_indicator.dart' in file_path: continue
    
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
        
    original_content = content
    
    for old_str, new_str in replacements.items():
        content = content.replace(old_str, new_str)
        
    if content != original_content:
        # We need to remove 'const' from widgets that now wrap CustomLoadingIndicator, 
        # because CustomLoadingIndicator itself can't be const (Lottie.network is not const)
        content = content.replace("const Center(child: CustomLoadingIndicator", "Center(child: CustomLoadingIndicator")
        content = content.replace("? const Center(child: CustomLoadingIndicator", "? Center(child: CustomLoadingIndicator")
        content = content.replace("const SizedBox(width: 18, height: 18, child: CustomLoadingIndicator", "SizedBox(width: 18, height: 18, child: CustomLoadingIndicator")
        
        # Add import if not present
        if 'custom_loading_indicator.dart' not in content:
            match = re.search(r'(import [^;]+;\n)+', content)
            if match:
                end = match.end()
                content = content[:end] + import_statement + content[end:]
            else:
                content = import_statement + content
                
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f'Updated {os.path.basename(file_path)}')
