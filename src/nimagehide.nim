import nimagehidepkg/[imageIO,storeData,helpers],os
export imageIO,storeData,helpers

when isMainModule:
  import nimagehidepkg/cli,cligen
  if paramCount() == 0:
    interactiveMenu()
  else:
    dispatchMulti([hide],[discover],[cli.space])
