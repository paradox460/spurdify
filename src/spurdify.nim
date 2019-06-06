import strutils, unicode, nre, random

type
  Replacement = tuple[pattern, replacement: string]
  ReplacementSequence = seq[Replacement]

const spurdification: ReplacementSequence = @[
  ("kek", "geg"),
  ("epic", "ebin"),
  ("right", "rite"),
  ("your", "ur"),
  ("god", "dog"),
  ("linux", "linugs"),
  ("fucking", "fuggin"),
  ("are", "r"),
  ("you", "u"),
  ("wh", "w"),
  ("th", "d"),
  ("af", "ab"),
  ("ap", "ab"),
  ("ca", "ga"),
  ("ck", "gg"),
  ("co", "go"),
  ("ev", "eb"),
  ("ex", "egz"),
  ("et", "ed"),
  ("iv", "ib"),
  ("it", "id"),
  ("ke", "ge"),
  ("nt", "nd"),
  ("op", "ob"),
  ("ot", "od"),
  ("po", "bo"),
  ("pe", "be"),
  ("pi", "bi"),
  ("up", "ub"),
  ("va", "ba"),
  ("ck", "gg"),
  ("cr", "gr"),
  ("kn", "gn"),
  ("lt", "ld"),
  ("mm", "m"),
  ("nt", "dn"),
  ("pr", "br"),
  ("ts", "dz"),
  ("tr", "dr"),
  ("bs", "bz"),
  ("ds", "dz"),
  ("es", "es"),
  ("fs", "fz"),
  ("gs", "gz"),
  ("is", "iz"),
  ("as", "az"),
  ("ls", "lz"),
  ("ms", "mz"),
  ("ns", "nz"),
  ("rs", "rz"),
  ("ss", "sz"),
  ("ts", "tz"),
  ("us", "uz"),
  ("ws", "wz"),
  ("ys", "yz"),
  ("alk", "olk"),
  ("ing", "ign"),
  ("ic", "ig"),
  ("ng", "nk"),
  ("p", "b")
]

randomize()

proc bigEmote(match: string) : string =
  var
    leader: string
    mouth = "D"
  case match
  of ".": leader = ":"
  of ",": leader = "x"
  of ";":
    leader = ":"
    mouth = "O"
  else:
    return match
  var number_of_chars: int = rand(4) + 1
  return " $1$2" % [leader, repeat(mouth, number_of_chars)]

proc spurdify*(text : string): string =
  result = text.toLower.multiReplace(spurdification)
  result = nre.replace(result, re"[.,;]", bigEmote)

when isMainModule:
  import parseopt, terminal

  const
    version = "0.0.3"

    spurdo_face = """
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
      echo line.spurdify

  proc spurdifyFile(filename: string) =
    var f = open(filename, bufSize=8000)
    defer: close(f)
    spurdifyFile(f)

  proc spurdifyText(text: string) =
    echo text.spurdify

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
