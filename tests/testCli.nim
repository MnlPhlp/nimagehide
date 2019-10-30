import 
  unittest,
  os,
  nimagehide,
  nimagehidepkg/cli

test "CLI hide string":
  hide("tests/testImage.png","imageSecret.png",secret = "Hello Nim World !!")
  check(discoverData("imageSecret.png") == "Hello Nim World !!")
  removeFile("imageSecret.png")

  test "CLI hide file":
    writeFile("secret.txt","Hello Nim World !!")
    hide("tests/testImage.png","imageSecret.png",file = "secret.txt")
    check(discoverData("imageSecret.png") == "Hello Nim World !!")
    removeFile("imageSecret.png")
    removeFile("secret.txt")
  