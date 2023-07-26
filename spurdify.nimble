# Package

version       = "0.0.7"
author        = "Jeff Sandberg"
description   = "Spurdification library and CLI"
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["spurdify"]
binDir        = "bin/"


# Dependencies

requires "nim >= 1.6, cligen >= 1.2.0"

task upx, "Build minified binary":
  let args = "nimble build -d:release -y"
  exec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best bin/spurdify"

  if findExe("sha256sum") != "":
    echo "Running `sha256sum`"
    exec "sha256sum bin/spurdify"
