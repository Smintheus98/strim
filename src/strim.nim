import std/[strutils, strformat, unicode]
import cligen
import utils



proc substrByIdx(s: string; idx: int): string =
  if idx notin 0..s.high:
    return s
  return s[idx .. ^1]


proc substrByIdx(s: string; idx1, idx2: int; includeBorder = false): string =
  var
    i1 = idx1
    i2 = idx2
    str = s
  
  if i1 > i2:
    (i1, i2) = (i2, i1)
    str = s.reversed

  if i1 notin 0..s.high or i2 notin 0..s.len:
    return s

  if includeBorder:
    return str[i1 .. i2]
  else:
    return str[i1 ..< i2]


proc substrByIdxLen(s: string; idx, length: int; includeBorder = false): string =
  if idx notin 0..s.high or idx+length notin 0..s.len:
    return s
  if includeBorder:
    return s[idx .. idx+length]
  else:
    return s[idx ..< idx+length]


proc substrBefore(s, sub: string; n = 1; includesub = false): string =
  let pos = s.findNth(sub, n)

  if pos < 0:
    return s

  if includesub:
    return s[0..<pos+sub.len]
  else:
    return s[0..<pos]


proc substrAfter(s, sub: string; n = 1; includesub = false): string =
  let pos = s.findNth(sub, n)

  if pos < 0:
    return s

  if includesub:
    return s[pos..s.high]
  else:
    return s[pos+sub.len..s.high]


type Mode = enum
  None, Indices, IndexLength, Before, After


proc checkParameterCombination(index: string; length: int; before, after: string; occourrence: int; includeBorder: bool): tuple[valid: bool, mode: Mode] =
  # TODO: test only simple cases and keep error messages simple
  var 
    mode = Mode.None
    separators = {',',';','-'}

  if index != "" and index.split(separators).len == 2:
    mode = Mode.Indices
  if index != "" and index.split(separators).len == 1:
    mode = Mode.Indices
  if index != "" and index.split(separators).len > 2:
    error fmt"Too many values for Parameter '--index': {index.split(separators).len}"
    return (false, None)
    
  if length != 0 and ( before != "" or after != "" or occourrence != 0 ):
    discard
  return (true, mode)


proc strim(index = ""; length = 0; before = ""; after = ""; occourrence = 0; includeBorder = true; strparam: seq[string]): int =
  ## Usage:
  ## (1) substr -i|--index=idx1[,idx2]  ["string"]
  ## (2) substr -i|--index=idx [-l|--length=length]  ["string"]
  ## (3) substr -b|--before=CHAR|STRING  [-n|--occourrence=1]  [-c|--include]  ["string"]
  ## (4) substr -a|--after=CHAR|STRING  [-n|--occourrence=1]  [-c|--include]  ["string"]
  ## 
  ## All modes(1-4) may conflict with each other! 
  ## -> prevent misuse by appropriate detection and handling of not allowed combination of modes
  var
    instr: string

  # TODO: Check if combination of used parameters is valid
  discard checkParameterCombination(index, length, before, after, occourrence, includeBorder)

  # TODO: Parse parameters
  
  if strparam.len > 0:
    if strparam.len == 1:
      instr = strparam[0]
    else:
      error "Too many arguments"
  else:
    instr = stdin.readLine

  
  return QuitSuccess


when isMainModule:
  cligen.dispatch(strim)
