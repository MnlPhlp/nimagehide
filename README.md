# nimagehide  [![Build Status](https://travis-ci.com/MnlPhlp/nimagehide.svg?branch=master)](https://travis-ci.com/MnlPhlp/nimagehide)
This provides a library and cli for hiding messages or other files in images.

For loading the images the library [stb_image](https://github.com/define-private-public/stb_image-Nim) is used.
Currently only png immages are supported but all loseless encodings supported by stb_image could easily be added.

## usage
### hiding
```nim
  import nimagehide
  
  let img = loadImage("baseImage.png")     # loading the image
  let secret = "Hello World".toBytes()     # prepare the secret data as a byte sequence
  img.hideData(data)                       # hide the data
  img.storeImagePng("imageWithSecret.png") # store the image with the secret
  
  hideAndStore("baseImage.png", "imageWithSecret.png", "Hello World") # can be done with one function
```
### discovering
```nim
  import nimagehide
  
  let img = loadImage("imageWithSecret.png") # loading the image
  let secret = img.discoverData              # extract the data
  echo secret                                # echo outputs 'Hello World'
  
  discoverAndStore("imageWithSecret.png", "secret.txt") # discovers te data and stores it in 'secret.txt'
```
