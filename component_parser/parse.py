import sys
from dataclasses import dataclass
import json
import argparse
import pathlib


MEMBERS_INTRO_LINE = " - Members -----------------------------\n"
PRIVATES_INTRO_LINE = " - Privates -----------------------------\n"
OBJECTS_INTRO = " - Objects -----------------------------\n"
CUSTOM_DATA_TYPES_INTRO = " - Custom data types -------------------\n"

CATEGORY_INTROS = [
    MEMBERS_INTRO_LINE,
    PRIVATES_INTRO_LINE,
    OBJECTS_INTRO,
    CUSTOM_DATA_TYPES_INTRO,
]


def intro_cat_name(intro):
    if intro == MEMBERS_INTRO_LINE:
        return "members"
    if intro == PRIVATES_INTRO_LINE:
        return "privates"
    if intro == OBJECTS_INTRO:
        return "objects"
    if intro == CUSTOM_DATA_TYPES_INTRO:
        return "custom_data_types"


@dataclass
class Component:
    name: str
    members: list
    privates: list
    objects: list
    custom_data_types: list

    def to_json(self):
        obj = {"name": self.name}

        if self.members:
            obj["members"] = [m.to_json() for m in self.members]

        if self.privates:
            obj["privates"] = [m.to_json() for m in self.privates]

        if self.objects:
            obj["objects"] = [m.to_json() for m in self.objects]

        if self.custom_data_types:
            obj["custom_data_types"] = [
                m.to_json() for m in self.custom_data_types
            ]

        return obj


@dataclass
class Field:
    type: str
    name: str
    example: str
    description: str

    def to_json(self):
        obj = {"type": self.type, "name": self.name}

        if self.example != "-":
            obj["example"] = self.example

        if self.description:
            obj["description"] = self.description

        return obj


def read_entry(file):
    name_line = file.readline()
    if name_line == "":
        return None

    component_name = name_line[:-1]

    fields = {intro_cat_name(intro): [] for intro in CATEGORY_INTROS}

    current_intro = file.readline()
    while current_intro != "\n":
        current_category = intro_cat_name(current_intro)
        item = file.readline()

        if item == "\n":
            break

        if item in CATEGORY_INTROS:
            current_intro = item
            continue

        data_type, _, rest = item.lstrip().partition(" ")
        name, _, rest = rest.lstrip().partition(" ")
        example, _, rest = rest.lstrip().partition('"')
        example = example.rstrip()
        description = rest.removesuffix('"\n')

        field = Field(
            type=data_type,
            name=name,
            example=example,
            description=description,
        )

        fields[current_category].append(field)

    return Component(name=component_name, **fields)


def iter_components(file):
    def callable():
        return read_entry(file)

    return iter(callable, None)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create machine readable component file.")
    parser.add_argument("components_location", type=pathlib.Path)
    parser.add_argument("--output", type=pathlib.Path)
    args = parser.parse_args()

    components_location = args.components_location
    output = open(args.output, "w") if args.output else sys.stdout

    with open(components_location, "r") as component_file:
        components = list(iter_components(component_file))
        print(json.dumps([c.to_json() for c in components], indent=4), file=output)
