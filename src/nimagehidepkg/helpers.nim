import
  sequtils,
  sugar

## convert an integer to a sequenze of bytes each representing one bit
proc toBits*(value: int): seq[byte] =
  result = @[]
  for shift in countdown(63,0):
    result.add((byte) ((value shr shift) and 1))

proc toBytes*(input: string): seq[byte] =
  input.toSeq().map(x => (byte)x)


proc toString*(str: seq[byte]): string =
  result = newStringOfCap(len(str))
  for ch in str:
    add(result, (char) ch)

