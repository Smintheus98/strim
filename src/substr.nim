import std/[strutils, unicode]


proc findNth(s, sub: string; n = 1): int =
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


proc substrByIdx*(s: string; idx: int): string =
  if idx notin 0..s.high:
    return s
  return s[idx .. ^1]


proc substrByIdx*(s: string; idx1, idx2: int): string =
  var
    i1 = idx1
    i2 = idx2
    str = s
  
  if i1 > i2:
    (i1, i2) = (i2, i1)
    str = s.reversed

  if i1 notin 0..s.high or i2 notin 0..s.len:
    return s

  return str[i1 ..< i2]


proc substrByIdx*(s: string; idcs: seq[int]): string =
  if idcs.len == 1:
    return s.substrByIdx(idcs[0])
  elif idcs.len == 2:
    return s.substrByIdx(idcs[0], idcs[1])
  else:
    return s


proc substrByIdxLen*(s: string; idx, length: int): string =
  if idx notin 0..s.high or idx+length notin 0..s.len:
    return s
  return s[idx ..< idx+length]


proc substrBefore*(s, sub: string; n = 1; includesub = false): string =
  let pos = s.findNth(sub, n)

  if pos < 0:
    return s

  if includesub:
    return s[0..<pos+sub.len]
  else:
    return s[0..<pos]


proc substrAfter*(s, sub: string; n = 1; includesub = false): string =
  let pos = s.findNth(sub, n)

  if pos < 0:
    return s

  if includesub:
    return s[pos..s.high]
  else:
    return s[pos+sub.len..s.high]

