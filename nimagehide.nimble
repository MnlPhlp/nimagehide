# Package

version       = "0.1.5"
author        = "MnlPhlp"
description   = "A library to hide data in images. Usable as library or cli tool."
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nimagehide"]

backend       = "c"

# Dependencies

requires "nim >= 1.0.0"
requires "stb_image >= 2.3"
requires "cligen >= 0.9.40"

# Tasks
import os
task docs,"generate docs":
  selfExec "doc2 --project --git.url:https://github.com/MnlPhlp/nimagehide --git.commit:master src/nimagehide.nim"
  rmDir("docs")
  mvDir("src/htmldocs","docs")
  mvFile("docs/nimagehide.html","docs/index.html")
