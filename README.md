Spurdification! For when you want to make text sound like Spurdo Sparde wrote it.

[![Build Status](https://dev.azure.com/paradox460/spurdify/_apis/build/status/Linux%26Mac%20Build%20and%20Release?branchName=master)](https://dev.azure.com/paradox460/spurdify/_build/latest?definitionId=6&branchName=master)

# Usage
```
Fuggs up text :DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
            ▄▄▄▄▀▀▀▀▀▀▀▀▄▄▄▄▄▄▄
           █▒▒░▄▄▀▀▀▀▄░▒░▄▄▄▄▄░▀▀▄
          █▒░▄▀░▒▒▒▒▒░▀▄▀░▒▒▒▒▒▒▒█
         █▒▒▒▒▒▒▒▒▒██▀▒▒▒▒▒▒██▀▄▒█
        ▄▀▒▒▒▒▒▒▒▒▒▀▀▀▒▒▒▒▒▒▀▀▀▒▒▒█
        █▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒░░░░░░░▒█
        █░▒▒▀▄▄▒░░░░░░▒▄▀▄▄░░░░░░▒█
         █░▒▒▒▒▀▄▄▄▄▄███████▄▄▄▄▄▀
          █░▒▒▒▒▒▒▀▄▀▀████▀▀▄▀▒▒█
           ▀▀▀▄▄▄▄▄▄█▄▄▄▄▄▄█▄▄▄▀"

Running without any arguments or stdin puts it in "repl" mode, for real-time spurdification.

spurdify [flags] <text>

Flags:
    -h, --help:                       Prints this message
    -v, --version:                    Outputs the current version
    -f=<filename>, --file=<filename>:    A text file to process
```

# Installation
This project uses [Nim](https://nim-lang.org/), and so installation is pretty easy, depending on your system.

1. Install nim, using your package manager of choice (or [ASDF](https://github.com/asdf-vm/asdf))
2. Run `nimble install https://github.com/paradox460/spurdify`
4. You now have a `spurdify` executable in `~/.nimble/bin` directory and you can `import spurdify` to use as a library.

# Using as a library

Library exports a single function `spurdify`.

```nim
import spurdify

echo spurdify "Nim is epic."
```

## Cross-compiling
Since Nim rocks, you can cross-compile. [See the Compiler Manual for details](https://nim-lang.org/docs/nimc.html#cross-compilation).

# Other Versions
I previously wrote this thing in Crystal. That code exists on the Crystal branch.

# License
The MIT License (MIT)

Copyright (c) 2020 Jeff Sandberg

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
