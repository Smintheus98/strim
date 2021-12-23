import std/[strformat, strutils, sequtils]
import substr, errutils
import cligen


type Mode = enum
  None, Indices, IndexLength, Before, After


proc parseIndices(s: string): seq[int] =
  let separators = {',',';',':'}
  return s.split(separators).map parseInt


proc checkOptionCombination(index: string; length: int; before, after: string; occourrence: int; withborder: bool): Mode =
  # DONE: test only simple cases and keep error messages simple
  var mode = Mode.None
  block:
    # mode: Indices, IndexLength
    if index != "":
      var idcs: seq[int]
      try:
        idcs = index.parseIndices
      except:
        quitWith "Invalid value format for `--index` option", QuitFailure

      if idcs.len > 2:
        quitWith fmt"Too many values for option '--index': {idcs.len}", QuitFailure
      if idcs.len == 2:
        if length != 0:
          quitWith "Incompatible options used.\pSee option `-h` for more information", QuitFailure
        mode = Mode.Indices
      elif idcs.len == 1:
        if length > 0:
          mode = Mode.IndexLength
        else:
          mode = Mode.Indices

      if mode in {Indices, IndexLength} and
          ( before != "" or
            after  != "" or
            occourrence != 0 or
            withborder != false ):
        quitWith "Incompatible options used.\pSee option `-h` for more information", QuitFailure
  block:
    # mode: Before
    if before != "":
      mode = Mode.Before
      if index != "" or length != 0 or after != "":
        quitWith "Incompatible options used.\pSee option `-h` for more information", QuitFailure
  block:
    # mode: After
    if after != "":
      mode = Mode.After
      if index != "" or length != 0 or before != "":
        quitWith "Incompatible options used.\pSee option `-h` for more information", QuitFailure
  block:
    # mode: None
    if mode == Mode.None:
      quitWith "Operation mode ambiguous.\pUse one of options: [ `--index`, `--before`, `--after` ]", QuitFailure

  return mode


proc strim(index = ""; length = 0; before = ""; after = ""; occourrence = 0; withborder = false; strparam: seq[string]): int =
  ## Modes:
  ##
  ## (1) substr -i|--index=idx1[,idx2]  ["string"]
  ##
  ## (2) substr -i|--index=idx [-l|--length=length]  ["string"]
  ## 
  ## (3) substr -b|--before=SUBSTRING  [-o|--occourrence=1]  [-w|--withborder]  ["string"]
  ## 
  ## (4) substr -a|--after=SUBSTRING  [-o|--occourrence=1]  [-w|--withborder]  ["string"]
  ## 
  ## All modes(1-4) may conflict with each other! 
  ## -> prevent misuse by appropriate detection and handling of not allowed combination of modes
  ##
  var
    instr: string
    outstr: string
    mode = checkOptionCombination(index, length, before, after, occourrence, withborder)
  
  if strparam.len > 1:
    quitWith "Too many arguments", QuitFailure
  elif strparam.len == 1:   # If string given use it
    instr = strparam[0]
  else:                     # Otherwise read from stdin
    instr = stdin.readLine

  # Apply arguments
  case mode:
    of Mode.Indices:
      outstr = instr.substrByIdx(index.parseIndices)
    of Mode.IndexLength:
      outstr = instr.substrByIdxLen(index.parseIndices[0], length)
    of Mode.Before:
      outstr = instr.substrBefore(before, occourrence, withborder)
    of Mode.After:
      outstr = instr.substrAfter(after, occourrence, withborder)
    of Mode.None:
      discard

  echo outstr
  return QuitSuccess


when isMainModule:
  cligen.dispatch(strim)
