import os, sys
import subprocess

def latex_template(name, title):
    # default use title as caption
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

if __name__ == "__main__":
    title: str = sys.argv[1].strip()
    # eg <path>/figures
    root: str = sys.argv[2]

    os.makedirs(root, exist_ok=True)
    filename = title.replace(" ", "_").replace("/", "").lower() # avoid empty space in filename

    if filename[-1] == ".":
        filename = filename[:-1]
    subprocess.run(f"xclip -selection clipboard -t image/png -o > '{os.path.join(root, f'{filename}.png')}'", shell=True)

    # due to keymap .! every stdout is redirected to insert typing
    print(indent(latex_template(filename, title), indentation=2))
