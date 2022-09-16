import os, sys
import subprocess
# import pyperclip

filename: str = sys.argv[1].strip()
# eg <path>/figures
root: str = sys.argv[2]

os.makedirs(root, exist_ok=True)

def latex_template(name, title):
    return '\n'.join((
        r"\begin{figure}[ht]",
        r"    \centering",
        rf"    \includegraphics[width=\linewidth]{{figures/{name}.png}}",
        rf"    \caption{{{title}}}",
        rf"    \label{{fig:{name}}}",
        r"\end{figure}"))

def indent(text, indentation=0):
    lines = text.split('\n');
    return '\n'.join(" " * indentation + line for line in lines)

def beautify(name):
    return name.replace('_', ' ').replace('-', ' ').title()

subprocess.run(f"xclip -selection clipboard -t image/png -o > {os.path.join(root, f'{filename}.png')}", shell=True)

print(indent(latex_template(filename, beautify(filename)), indentation=2))
