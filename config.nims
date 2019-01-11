task build, "Builds dehound":
  let args = "c -d:release --opt:size -o:spurdify main.nim"
  selfExec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best spurdify"
