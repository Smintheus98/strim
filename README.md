# strim
A sub-string command line tool for Shell scripting

## Usage:

The input string may be given as an argument or passed via pipelining.
If the program got no input string it listens on stdin for input.

There are 4 different and incompatible operation modes for this program:
```
(1) $ substr -i|--index=idx1[,idx2]  [input]

(2) $ substr -i|--index=idx [-l|--length=length]  [input]

(3) $ substr -b|--before=SUBSTRING  [-o|--occourrence=1]  [-w|--withborder]  [input]

(4) $ substr -a|--after=SUBSTRING  [-o|--occourrence=1]  [-w|--withborder]  [input]

```
