#Cross
Cross is a cross-platform package manager.

## Motivation
If you tell 25 people to install some software, they will find roughly 25 wrong ways to install it.
For those who use Linux or Mac, package managers such as `apt-get`, `yum`, `brew`, and others streamline installation.
However, these managers sometimes use different names for the same software.
Even worse, some platforms (namely, Windows) lack a package manager altogether.
This is why we can't have nice things.

Installing software should not be this hard.
Why not abstract away differences among package manager names?
Why not implement package management for platforms that lack it?

That's the point of this project.
It works well enough for my purposes, but there's plenty of room for improvement.

## How to use
Regardless of whether you are in Windows, Mac, Ubuntu, or Red Hat, try the following:

    cross install latex
