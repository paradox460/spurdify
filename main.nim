import strutils, unicode, parseopt, terminal
from spurdify import processText

const version = "0.0.1"

const spurdo_face = """
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
"""

proc writeHelp() =
  echo """
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
  """
  quit()

proc writeVersion() =
  echo version
  quit()

proc spurdifyFile(filename: File) =
  if isatty(filename):
    echo "$1\nType a line and see it spurdified instantly (ctrl-c to quit)" % [spurdo_face]
  for line in filename.lines:
    echo line.processText

proc spurdifyFile(filename: string) =
  var f = open(filename, bufSize=8000)
  defer: close(f)
  spurdifyFile(f)


proc spurdifyText(text: string) =
  echo text.processText

# MAIN

var options = initOptParser(shortNoVal = {'h', 'v'}, longNoVal = @["help", "version"])

if options.cmdLineRest().len == 0:
  spurdifyFile(stdin)
for kind, key, val in options.getopt():
  case kind
  of cmdArgument:
    spurdifyText(key)
  of cmdLongOption, cmdShortOption:
    case key
    of "help", "h": writeHelp()
    of "file", "f":
      if val == "":
        writeHelp()
      else:
        spurdifyFile(val)
    of "version", "v": writeVersion()
  of cmdEnd: assert(false)
