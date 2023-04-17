#!/usr/bin/env python3

from dataclasses import dataclass
import re
import subprocess
import sys
from typing import Union


class Pattern:
    def __init__(self, p: Union[str, re.Pattern]) -> None:
        if not (isinstance(p, str) or isinstance(p, re.Pattern)):
            raise ValueError(f"Pattern is neither a str nor a regexp: {p}")

        self._pattern = p

    def matches(self, url: str) -> bool:
        if isinstance(self._pattern, str):
            # Catch-all pattern
            if self._pattern == "*":
                return True

            return url.startswith(self._pattern)
        elif isinstance(self._pattern, re.Pattern):
            return self._pattern.search(url) is not None

        return False


@dataclass
class Tool:
    name: str
    command: str
    args: list[str]

    patterns: list[Pattern]

    def accepts(self, url: str) -> bool:
        return any(pattern.matches(url) for pattern in self.patterns)


tools = [
    Tool(
        "Google Chrome",
        "/usr/bin/google-chrome-stable",
        [
            "--profile-directory=Profile 1",
            "{{url}}",
        ],
        [Pattern("https://meet.google.com")],
    ),
    Tool("Firefox", "/usr/bin/firefox", ["{{url}}"], [Pattern("*")]),
]


def find_tools(url: str) -> list[Tool]:
    return [tool for tool in tools if tool.accepts(url)]


def main():
    if not len(sys.argv) == 2:
        raise ValueError(f"Need exactly 1 positional argument, got: {sys.argv}")

    url = sys.argv[1]
    tools = find_tools(url)

    if len(tools) > 1:
        print(
            f"Warning: more than one pattern matches, using first match: {[tool.name for tool in tools]}"
        )

    tool = tools[0]

    cmd = tool.command
    args = [arg.replace("{{url}}", url) for arg in tool.args]

    print(f"Running: {cmd=}, {args=}")
    subprocess.Popen([cmd] + args)


if __name__ == "__main__":
    main()
