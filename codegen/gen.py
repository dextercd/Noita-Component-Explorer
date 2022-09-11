import argparse
import pathlib
import json
import sys

from jinja2 import Environment, Template


parser = argparse.ArgumentParser()
parser.add_argument("file", type=pathlib.Path)
parser.add_argument("--json", default=[], action="append", type=pathlib.Path)
parser.add_argument("--output", type=pathlib.Path)
args = parser.parse_args()

output = open(args.output, "w") if args.output else sys.stdout


def load_json_file(path):
    with open(path) as f:
        contents = json.load(f)
    return path.stem, contents


def load_json_files(paths):
    return (load_json_file(path) for path in paths)


env = Environment()
with open(args.file) as f:
    template = Template(f.read())

context = {name: value for name, value in load_json_files(args.json)}

output.write(template.render(context))
