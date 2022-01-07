import strformat
# Package

version       = "0.2.1"
author        = "Yannic Kitten (Smintheus98)"
description   = "A Substring utility for Unix shell"
license       = "GPL v3.0"
backend       = "c"
srcDir        = "src"
binDir        = "bin"
bin           = @["strim"]


# Dependencies

requires "nim >= 1.6.0"
requires "cligen"

# tasks
task clean, "Clean Up Binary Directory":
  exec fmt"rm {binDir}/*"

task test, "Run Tests":
  exec "nim c -r --outDir:tests tests/test.nim"
  exec "tests/test.sh"
