import cligen, strformat, terminal

const
  NimblePkgVersion {.strdefine.} = ""

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

  cmdUsage = """
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

NAME
  spurdify - spurdish text mangler. Converts normal text to spurdo-sparde speak.

USAGE
  $command $args

${doc}Options(opt-arg sep :|=|spc):

$options
"""

proc spurdifyFile(filename: File) =
  if isatty(filename):
    echo "$1\nType a line and see it spurdified instantly (ctrl-c to quit)" % [spurdo_face]
    setControlCHook(proc() {.noconv.} =
      echo "\raw fugg, goodbye :(((("
      quit(0)
    )
  for line in filename.lines:
    echo line.spurdify

proc spurdifyFile(filename: string) =
  var f = open(filename, bufSize = 8000)
  defer: close(f)
  spurdifyFile(f)


proc cmdDispatch(
  filename: string = "",
  text: seq[string]
) =
  if filename != "":
    spurdifyFile(filename)
    quit(0)
  if text != []:
    echo text.join(" ").spurdify()
    quit(0)
  spurdifyFile(stdin)
  quit(0)


# include cligen/cfCfgInit
include cligen/mergeCfgEnv
clCfg.version = NimblePkgVersion
dispatch(
  cmdDispatch,
  cmdname = "spurdify",
  usage = cmdUsage,
  help = {"filename": "A file you want to spurdify. Read as text"},
  noHdr = true
)
