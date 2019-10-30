# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import nimagehidepkg/[imageIO,storeData,helpers],os
export imageIO,storeData,helpers

when isMainModule:
  import nimagehidepkg/cli,cligen
  if paramCount() == 0:
    interactiveMenu()
  else:
    dispatchMulti([hide],[discover],[cli.space])
