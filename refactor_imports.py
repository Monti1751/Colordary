import os
import fnmatch

def replace_in_file(filepath, search, replace):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        new_content = content.replace(search, replace)
        if new_content != content:
            with open(filepath, 'w', encoding='utf-8', newline='') as f:
                f.write(new_content)
            print(f"Updated: {filepath}")
    except Exception as e:
        print(f"Error processing {filepath}: {e}")

def main():
    search_str = 'package:agenda/'
    replace_str = 'package:colordary/'
    for root, dirnames, filenames in os.walk('.'):
        for filename in fnmatch.filter(filenames, '*.dart'):
            replace_in_file(os.path.join(root, filename), search_str, replace_str)

if __name__ == "__main__":
    main()
