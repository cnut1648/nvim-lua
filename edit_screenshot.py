import sys, subprocess
from pathlib import Path

def get_picker_cmd(picker_args=None, fuzzy=True):
    """
    Create the shell command that will be run to start the picker.
    """

    args = ['rofi', '-sort', '-no-levenshtein-sort']
    if fuzzy:
        args += ['-matching', 'fuzzy']
    args += ['-dmenu', '-p', "Select Figure", '-format', 's', '-i',
             '-lines', '5']

    if picker_args is not None:
        args += picker_args

    return [str(arg) for arg in args]

def pick(options, picker_args=None, fuzzy=True):
    optionstr = '\n'.join(option.replace('\n', ' ') for option in options)
    cmd = get_picker_cmd(picker_args=picker_args, fuzzy=fuzzy)
    result = subprocess.run(cmd, input=optionstr, stdout=subprocess.PIPE,
                            universal_newlines=True)
    returncode = result.returncode
    stdout = result.stdout.strip()

    selected = stdout.strip()
    try:
        index = [opt.strip() for opt in options].index(selected)
    except ValueError:
        index = -1

    if returncode == 0:
        key = 0
    elif returncode == 1:
        key = -1
    elif returncode > 9:
        key = returncode - 9

    return key, index, selected

if __name__ == "__main__":
    # eg <path>/figures
    root: str = sys.argv[1]
    files = Path(root).glob("*.png")
    files = sorted(files, key=lambda f: f.stat().st_mtime, reverse=True)
    names = [file.stem for file in files]
    _, index, selected = pick(names)
    if selected:
        file = files[index]
        # resave
        subprocess.run(f"xclip -selection clipboard -t image/png -o > {repr(str(file))}",
                       shell=True)
