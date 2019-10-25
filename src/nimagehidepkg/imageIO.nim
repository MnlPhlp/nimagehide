# functions for loading and storing images
import   
  stb_image/read as stbi,
  stb_image/write as stbw

type Image* = ref object
  width,heigth,channels: int
  data*: seq[byte]

proc loadImage*(filename: string): Image =
  let img = new Image
  img.data = stbi.load(filename,img.width,img.heigth,img.channels,stbi.RGB)
  result = img

method storeImagePNG*(img: Image, filename: string) {.base.}=
  stbw.writePNG(filename,img.width,img.heigth,stbw.RGB,img.data)