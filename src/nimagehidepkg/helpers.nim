import
  sequtils,
  sugar,
  imageIO

proc toBits*(value: int): seq[byte] =
  ## convert an integer to a sequenze of bytes each representing one bit
  result = @[]
  for shift in countdown(63,0):
    result.add((byte) ((value shr shift) and 1))

proc toBytes*(input: string): seq[byte] =
  input.toSeq().map(x => (byte)x)


proc toString*(str: seq[byte]): string =
  result = newStringOfCap(len(str))
  for ch in str:
    add(result, (char) ch)

method space*(img: Image): int {.base.}=
  ## calculates the amount of bytes that can be stored in 'img'
  result = (int)((img.data.len - 64) / 8) # subtract bytes needed to store secret length