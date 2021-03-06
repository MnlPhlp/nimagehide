import 
  unittest,
  nimagehide,
  sequtils,
  sugar,
  os

test "hide Data in Image":
  let img = loadImage(joinPath("tests","testImage.png"))
  const data = @[1,3,3,7].map(x => (byte x))
  var expected: seq[byte]
  # fill up the front with 0s
  for i in 0..60:
    expected.add(0)
  const part = @[1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,1,1,1].map(x => (byte) x)
  expected = concat(expected, part)
  # hide test data in image
  img.hideData(data)
  for bit in 0..71:
    check((img.data[bit] and 1) == expected[bit])

test "discover Data from Image":
  let img = loadImage(joinPath("tests","testImageSecret.png"))
  let data = img.discoverData()
  check(data.toString() == "Hello Nim World !!")

test "discover and store":
  discoverAndStore(joinPath("tests","testImageSecret.png"),"secret.txt")
  check(readFile("secret.txt")=="Hello Nim World !!")
  removeFile("secret.txt")

test "hide file":
  writeFile("secret.txt","Hello Nim World !!")
  hideAndStoreFile("tests/testImage.png","imageSecret.png","secret.txt")
  check(discoverData("imageSecret.png") == "Hello Nim World !!")
  removeFile("secret.txt")
  removeFile("imageSecret.png")

test "max secret":
  let img = loadImage("tests/testImage.png")
  img.hideData(repeat((byte)137,img.space()))

test "to big secret":
  expect OverflowError:
    let img = loadImage("tests/testImage.png")
    img.hideData(repeat((byte)137,img.space()+1))