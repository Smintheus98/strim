import strformat
# Package

version       = "0.1.0"
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
task test, "Run Tests":
  exec "nim c -r --gc:arc --outDir:tests tests/test.nim"
  exec "tests/test.sh"

task clean, "Clean Up Binary Directory":
  exec fmt"rm {binDir}/*"

task release, "Release Build":
  exec fmt"nim c --gc:arc -d:release -o:{binDir}/{bin[0]} {srcDir}/{bin[0]}.nim"
