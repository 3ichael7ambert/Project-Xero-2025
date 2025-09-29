import argparse
import subprocess

from pathlib import Path
from typing import List, Optional

##python3 lines.py --dirname .

class InvalidDirectoryError(Exception):
    pass


def is_hidden_filepath(path: Path) -> bool:
    return any(p.startswith(".") for p in path.parts)

def contains_excluded_dir(path: Path, excluded_dirs: Optional[List[str]]) -> bool:
    if not excluded_dirs:
        return False

    for dir_to_exclude in excluded_dirs:
        if dir_to_exclude in path.parts:
            return True
        
    return False

def is_valid_filepath(path: Path, excluded_dirs: Optional[str]) -> bool:
    return not is_hidden_filepath(path) and not contains_excluded_dir(path, excluded_dirs)

def find_valid_files(dirname: str, excluded_dirs: Optional[str]) -> List[Path]:
    root = Path(dirname)
    if not root.exists():
        raise InvalidDirectoryError(f"Directory {dirname} does not exist.")
    
    files: List[Path] = [filename for filename in root.glob("**/*")]
    return [_file for _file in files if is_valid_filepath(_file, excluded_dirs) and _file.is_file()]

def get_line_count(_file: Path) -> int:
    cmd = [
        "wc",
        "-l",
        f"{str(_file)}"
    ]

    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True
        )

        out = result.stdout.strip().split(" ")[0]
        return int(out)
    except (subprocess.CalledProcessError, TypeError) as e:
        print(e)
        return 0

def count_lines(files: List[Path]) -> int:
    count: int = 0

    for _file in files:
        count += get_line_count(_file)

    return count

def main():
    """
    Description: Count the number of lines in a project. By default this does not include hidden files and
                 directories that start with ".".
    Usage:
      - "--dirname": The directory you want to get the number of lines for
      - "--exclude-dirs": A directory, multiple directories, an individual file, or some combination
                          thereof that you wish to exclude from the count. Think of node_modules, etc.

    Examples:
      - python3 -m lines -h ( shows the help menu )
      - python3 -m lines --dirname /path/to/my/directory
            - get the line count of all files in the directory

      - python3 -m lines --dirname /path/to/my/directory --exclude-dirs foo
            - same as above, but exclude the directory or file called "foo"

      - python3 -m lines --dirname /path/to/my/directory --exclude-dirs foo bar baz
            - same as above, but this time with multiple ignored files or directories
    """
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--dirname",
        required=True,
        help="The directory name to walk to find the number of lines"
    )
    parser.add_argument(
        "--exclude-dirs", 
        required=False,
        nargs="+",
        help="A directory(ies) to exclude from counting, such as `node_modules`, `venv`, etc."
    )

    args = parser.parse_args()

    files: List[Path] = find_valid_files(args.dirname, args.exclude_dirs)
    print(count_lines(files))

if __name__ == "__main__":
    main()