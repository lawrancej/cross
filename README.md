#Cross
Cross is a cross-platform package manager.

## Motivation
`apt-get`, `yum`, `brew`, and others streamline installation.
Why not abstract away their differences and implement package management for lacking platforms (*cough* Windows *cough*)?

## How to use
Regardless of whether you are in Windows, Mac, Ubuntu, or Red Hat, try the following:

    cross install latex

## Notes
The downside so far: no easy way to set $PATH in Windows 

System Key: [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\
Environment]
Data Type: REG_EXPAND_SZ (Expanded String Value)
