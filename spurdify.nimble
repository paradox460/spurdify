# Package

version       = "0.0.5"
author        = "Jeff Sandberg"
description   = "Spurdification library and CLI"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["spurdify"]


# Dependencies

requires "nim >= 0.20.0"

task upx, "Build minified binary":
  let args = "nimble build -d:release"
  exec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best spurdify"
