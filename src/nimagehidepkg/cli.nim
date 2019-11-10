import 
  ../nimagehide,
  strformat,
  cli_menu,
  rdstdin,
  os,
  sugar

proc hide*(image: string,output: string,secret = "",file = "") =
  if secret == "" and file != "":
    try:
      hideAndStoreFile(image,output,file)
    except OverflowError:
      echo "Error:"
      echo "  " & getCurrentExceptionMsg()
  elif file == "" and secret != "":
    try:
      hideAndStore(image,output,secret)
    except OverflowError:
      echo "Error:"
      echo "  " & getCurrentExceptionMsg()
  else: # no file or secret or both specified
    echo "specify either a secret string (-s) or a file (-f)"

proc discover*(images: seq[string]) =
  for image in images:
    let img = loadImage(image)
    echo img.discoverData().toString()

proc space*(images: seq[string]) =
  ## echos out the available storage space for the `images`
  for image in images:
    let img = loadImage(image)
    let space = img.space()
    write(stdout,"Available storage: ")
    if space < 1024:
      echo fmt"{space} Bytes"
    elif space < 1048576:
      echo fmt"{space/1024:.2f} KB"
    else:
      echo fmt"{space/1048576:.2f} MB"

template space*(image: string) = space(@[image])
template discover*(image: string) = discover(@[image])

proc checkImagePath(path: string): bool =
  true

proc showSpace() =
  let image = getUserInput("Show available storage space","imagepath","invalid imagepath",checkImagePath)
  space(image)
  waitForEnter()

proc showData() =
  let image = getUserInput("Show hidden data","imagepath","invalid imagepath",checkImagePath)
  discover(image)
  waitForEnter()

proc saveData() =
  let image = getUserInput("Select image to discover from","imagepath","invalid imagepath",checkImagePath)
  let file = getUserInput("Select file to save data in","filepath","directory does not exist",
                            x => (x.parentDir & "/.").existsDir(), # check if directory of savefile exists
                            false)
  discoverAndStore(image,file)
    

proc spaceMenu() =
  subMenus("Check storage space of an Image",@[
    ("Choose image",showSpace)
  ])
  
proc discoverMenu() =
  subMenus("Discover Data",@[
    ("Output data",showData),
    ("Save data to file",saveData)
  ])

proc hideFile() =
  let imageIn = getUserInput("Select source image","imagepath","invalid imagepath",checkImagePath)
  let imageOut = getUserInput("Select output image","imagepath","invalid imagepath",checkImagePath,false)
  let file = getUserInput("Select file to hide","filepath","directory does not exist",existsFile,false)
  hideAndStoreFile(imageIn,imageOut,file)


proc hideText() =
  let imageIn = getUserInput("Select source image","imagepath","invalid imagepath",checkImagePath)
  let imageOut = getUserInput("Select output image","imagepath","invalid imagepath",checkImagePath,false)
  let secret = getUserInput("Secret message to hide","message",false)
  hideAndStore(imageIn,imageOut,secret)

proc hideMenu() =
  subMenus("Hide Data",@[
    ("Hide text input",hideText),
    ("Hide File",hideFile)
  ])

proc interactiveMenu*() = 
  subMenus("What do you want to do",@[
        ("Hide data",hideMenu),
        ("Discover data",discoverMenu),
        ("Check storage space",spaceMenu)
        ])