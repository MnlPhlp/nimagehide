import 
  unittest,
  nimagehidepkg/helpers,
  sequtils,sugar

test "int to bits":
  const expected = @[0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0,
   1, 1, 1, 0, 0, 1].map(x => (byte) x)
  check(1337.toBits() == expected)

test "bytes to string":
  const str = @[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100].map(x => (byte)x)
  const expected = "hello world"
  check(str.toString() == expected)