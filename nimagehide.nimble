# Package

version       = "0.1.0"
author        = "MnlPhlp"
description   = "A library to hide data in images. Usable as library or cli tool."
license       = "MIT"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["nimagehide"]

backend       = "cpp"

# Dependencies

requires "nim >= 1.0.0"
requires "stb_image >= 2.3"
requires "cligen >= 0.9.40"
