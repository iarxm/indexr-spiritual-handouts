import re

with open('index.md', 'r') as file:
    content = file.read()

# Replace #sub marker with \incrementsubtable
#content = re.sub(r'\|#sub', '|\\incrementsubtable', content)
content = re.sub(r'\|#sub', '|\\\\incrementsubtable', content)
#content = re.sub(r'\|#sub', '|\\incrementsubtable ', content)
#content = re.sub(r'\|#sub', r'|\incrementsubtable', content)
#content = re.sub(r'\|#sub', '|\\\incrementsubtable', content)



# Write to a new markdown file
with open('processed_tables.md', 'w') as file:
    file.write(content)
