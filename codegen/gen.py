import argparse
import pathlib
import json
import sys
import itertools

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


env = Environment(
    trim_blocks=True,
    lstrip_blocks=True,
)
with open(args.file) as f:
    template = env.from_string(f.read())

context = {name: value for name, value in load_json_files(args.json)}
context["itertools"] = itertools

output.write(template.render(context))