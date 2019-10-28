import 
  unittest,
  nimagehide,
  os

test "load Image":
  # make sure the image is loaded without an error message
  let img=loadImage(joinPath("tests","testImage.png"))
  check(img.data.len == 40626)