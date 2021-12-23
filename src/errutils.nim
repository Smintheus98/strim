## Utilities for error messages and quit procedures

template errmsg*(args: varargs[string, `$`]) =
  stderr.write(args)
  stderr.write("\p")


template quitWith*(msg: string; quitstate: int = QuitFailure) =
  errmsg(msg)
  quit quitstate


template failWith*(args: varargs[string, `$`]) =
  errmsg(args)
  quit QuitFailure


template succeedWith*(args: varargs[string, `$`]) =
  errmsg(args)
  quit QuitSuccess

