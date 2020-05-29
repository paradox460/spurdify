# Package

version       = "0.0.6"
author        = "Jeff Sandberg"
description   = "Spurdification library and CLI"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["spurdify"]
binDir        = "bin/"


# Dependencies

requires "nim >= 0.20.2, cligen >= 1.0.0 & < 1.1.0"

task upx, "Build minified binary":
  let args = "nimble build -d:release -y"
  exec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best bin/spurdify"

  if findExe("sha256sum") != "":
    echo "Running `sha256sum`"
    exec "sha256sum bin/spurdify"
