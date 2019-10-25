import 
  unittest,
  nimagehide

test "load Image":
  # make sure the image is loaded without an error message
  let img=loadImage("tests/testImage.png")
  check(img.data.len == 40626)