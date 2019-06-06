# Package

version       = "0.0.3"
author        = "Jeff Sandberg"
description   = "Spurdification library and CLI"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["spurdify"]


# Dependencies

requires "nim >= 0.19.0"

task upx, "Build minified binary":
  let args = "c -d:release --opt:size --passL:-s --passC:-flto -o:spurdify src/spurdify"
  selfExec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best spurdify"
