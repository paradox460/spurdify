task build, "Builds spurdify":
  let args = "c -d:release -d:ssl --opt:size -o:spurdify main.nim"
  selfExec args

  if findExe("upx") != "":
    echo "Running `upx --best`"
    exec "upx --best spurdify"
