import std/strutils

template errmsg*(args: varargs[string, `$`]) =
  stderr.write(args)
  stderr.write("\p")

template error*(args: varargs[string, `$`]) =
  errmsg(args)
  quit QuitFailure

proc findNth*(s, sub: string; n = 1): int =
  ## Give position of n-th occourrence of substring str
  ## Negative value for n: searching backwards
  var
    n = n
    pos: int

  if n == 0:
    n = 1

  if sub notin s:
    return -1
 
  if n.abs > s.count(sub, true):
    return -1

  if n > 0:
    pos = 0
    for i in 1..n:
      pos = s.find(sub, pos)
      if i < n:
        pos.inc
  else:
    n = n.abs
    pos = s.high
    for i in 1..n:
      pos = s.rfind(sub, 0, pos)
      if i < n:
        pos.dec

  return pos
