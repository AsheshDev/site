import os

def create_dir(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)
        print(f"Created directory: {directory}")
    else:
        print(f"Directory already exists: {directory}")

def create_file(file_path, content):
    if not os.path.exists(file_path):
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(content)
            print(f"Created file: {file_path}")
    else:
        print(f"File already exists and was not overwritten: {file_path}")

# Define directories and files
directories = ['styles', 'scripts', 'music', 'videos']
files = {
    'index.html': """<!DOCTYPE html>...""",  # Extend with the actual HTML content
    'styles/main.css': """body, html { ... }""",  # Extend with actual CSS content
    'scripts/main.js': """document.addEventListener('DOMContentLoaded', function() { ... });""",
    'blog.html': """<!DOCTYPE html>...""",  # Extend with the actual blog HTML content
    'styles/blog.css': """body, html { ... }""",  # Extend with actual blog CSS content
    'scripts/blog.js': """function openModal(postElement) { ... };"""
}

# Create directories
for directory in directories:
    create_dir(directory)

# Create files
for file_path, content in files.items():
    full_path = os.path.join('.', file_path)
    create_file(full_path, content)
