import os, glob
paths = glob.glob('LearningManagementBackend/src/main/java/org/learn/learningmanagementbackend/controller/SchoolAdminController/*.java')
for p in paths:
    with open(p, 'r', encoding='utf-8') as f:
        content = f.read()
    content = content.replace('@RequestMapping("/api/school-admin', '@RequestMapping("/api/auth/school-admin')
    with open(p, 'w', encoding='utf-8') as f:
        f.write(content)
print("Done")
