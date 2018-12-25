import strutils, unicode, parseopt
from spurdify import processText

const version = "0.0.1"



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

Flags:
    -h, --help:                       Prints this message
    -v, --version:                    Outputs the current version
    -f=<filename>, --file=<filename>:    A text file to process
  """
  quit()

proc writeVersion() =
  echo version
  quit()

proc spurdifyFile(filename: (string|File)) =
  for line in filename.lines:
    echo line.processText

proc spurdifyText(text: string) =
  echo text.processText

for kind, key, val in getopt():
  case kind
  of cmdArgument:
    if key == "":
      spurdifyFile(stdin)
    else:
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
