import 
  imageIO,
  bitops,
  helpers

method hideData*(img: Image,data: seq[byte]) {.base.} =
  var bitCount = 0
  var bit = 0.byte
  var lenBits = data.len.toBits()
  # store the data length
  for lenBit in lenBits:
    if lenBit == 1:
      img.data[bitCount].setBit(0)
    else:
      img.data[bitCount].clearBit(0)
    bitCount += 1
  # store the actual data
  for dataByte in data:
    for shift in countdown(7,0):
      bit = dataByte.shr(shift) and 1 # get the next bit of data
      if bit == 1:
        img.data[bitCount].setBit(0)
      else:
        img.data[bitCount].clearBit(0)
      bitCount += 1

proc hideAndStore*(loadLoacation, storeLocation, secret: string) =
  let img = loadImage(loadLoacation)
  img.hideData(secret.toBytes())
  img.storeImagePNG(storeLocation)
  

method discoverData*(img: Image): seq[byte] {.base.} = 
  var dataLen = 0
  # discover the data length
  for i in 0..63:
    dataLen = dataLen shl 1
    dataLen += (int) (img.data[i] and 1)
  # discover the actual data
  var dataByte: byte
  var bitIndex = 64
  for i in 64..(dataLen+63):
    dataByte = 0
    for bit in 0..7:
      dataByte = dataByte shl 1
      dataByte += img.data[bitIndex] and 1
      bitIndex += 1
    result.add(dataByte)

proc discoverAndStore*(imageLocation, outFileLocation: string) =
  let img = loadImage(imageLocation)
  let data = img.discoverData()
  writeFile(outFileLocation,data.toString())