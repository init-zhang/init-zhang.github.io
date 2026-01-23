from sys import argv
from pathlib import Path
import re
import subprocess
import markdown

md_path = Path(argv[1])
template_path = Path(argv[2])
output_path = Path(argv[1].rstrip(".md") + ".html")

if template_path == output_path:
    raise Exception("Template and output paths are identical")

template_html = output_html = template_path.read_text()
pattern_re = re.compile(r"\{\{([\w\s\"\-\./]+)\}\}")

# REFACTOR:
# - template definition within templates

# Inline patterns
def match_pattern(pattern):
    replacement = None

    if pattern == "content":
        replacement = html

    elif pattern == "content.filename":
        replacement = argv[1].rstrip(".md").title()

    elif pattern.endswith(".html") and (inner_html := Path(pattern)).exists():
        replacement = inner_html.read_text()

    elif pattern.startswith("bash"):
        args = pattern.split()
        for i in range(len(args)):
            match = pattern_re.match(args[i])
            if match: args[i] = match_pattern(match.group(1))
        parent_dir = Path(args[1]).resolve().parent
        replacement = subprocess.run(args, cwd=parent_dir, capture_output=True, text=True).stdout

    return replacement

def match_inline(text):
    output = text
    for match in pattern_re.finditer(text):
        full_group: str = match.group(0)
        inner_group: str = match.group(1)
        print(f"Found pattern: {full_group}")
        replacement = match_pattern(inner_group)

        if replacement is None: raise Exception(f"{inner_group} match not found")

        output = output.replace(full_group, replacement)
    return output

md = md_path.read_text()
md = match_inline(md)
html = markdown.markdown(md, extensions=["fenced_code"])

output_path.write_text(match_inline(template_html))
