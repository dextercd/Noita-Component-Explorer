import argparse
import pathlib
import json
import sys
import itertools
import os

from jinja2 import Environment, Template


parser = argparse.ArgumentParser()
parser.add_argument("file", type=pathlib.Path)
parser.add_argument("--json", default=[], action="append", type=str)
parser.add_argument("--output", type=pathlib.Path)
args = parser.parse_args()

output = open(args.output, "w") if args.output else sys.stdout


def load_json_file(path: str):

    alias = None
    if "@" in path:
        path, _, alias = path.partition("@")

    path = pathlib.Path(path)
    if not alias:
        alias = path.stem


    with open(path) as f:
        contents = json.load(f)

    return alias, contents


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
context["env"] = os.environ

output.write(template.render(context))
