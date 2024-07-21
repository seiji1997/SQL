#!/bin/zsh

# Usage:
# nano create_practicef_iles.zsh
# chmod +x create_practice_files.zsh
# ./create_practice_files.zsh

# This script makes practice_1.md ~ practice_8.md in the current directory

base_name="practice"

for i in {1..8}; do
  file_name="${base_name}_${i}.md"
  touch "$file_name"
  echo "Created file: $file_name"
done
