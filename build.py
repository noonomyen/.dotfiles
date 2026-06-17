#!/usr/bin/env python3
import os
import re
import sys

# Regex to match __NERDFONT(hex)__ (case-insensitive hex)
NERDFONT_REGEX = re.compile(r'__NERDFONT\(([0-9a-fA-F]+)\)__')

def replace_nerdfont(match):
    hex_code = match.group(1)
    try:
        # Convert hex to unicode character
        char = chr(int(hex_code, 16))
        return char
    except ValueError as e:
        print(f"Error: Invalid hex code '{hex_code}': {e}", file=sys.stderr)
        return match.group(0)

def build_template(template_path):
    # Output path is the template path with the last occurrence of '.template' removed
    # e.g., 'starship.toml.template' -> 'starship.toml'
    # or 'starship.template.toml' -> 'starship.toml'
    if '.template' not in template_path:
        return

    output_path = template_path.replace('.template', '')
    
    print(f"Building: {template_path} -> {output_path}")
    
    try:
        with open(template_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
        # Replace placeholders
        built_content = NERDFONT_REGEX.sub(replace_nerdfont, content)
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(built_content)
            
    except Exception as e:
        print(f"Error building {template_path}: {e}", file=sys.stderr)

def main():
    dotfiles_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Walk dotfiles directory to find templates
    for root, dirs, files in os.walk(dotfiles_dir):
        # Skip .git directory
        if '.git' in root.split(os.sep):
            continue
            
        for file in files:
            if '.template' in file:
                template_path = os.path.join(root, file)
                build_template(template_path)

if __name__ == '__main__':
    main()
