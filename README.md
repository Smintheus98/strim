# strim
A sub-string command line tool for Shell scripting


## Usage

The input string may be given as an argument or passed via pipelining.
If the program got no input string it listens on stdin for input.

There are 4 different and incompatible operation modes for this program:
```
(1) $ substr -i|--index=idx1[,idx2]  [input]

(2) $ substr -i|--index=idx [-l|--length=length]  [input]

(3) $ substr -b|--before=SUBSTRING  [-o|--occourrence=1]  [-w|--withborder]  [input]

(4) $ substr -a|--after=SUBSTRING  [-o|--occourrence=1]  [-w|--withborder]  [input]

```

## Installation

This program is written in the [Nim Programming Language](https://nim-lang.org) so a [Nim](https://github.com/nim-lang/Nim/)-Compiler is required.
The prefered installation method is using [choosenim](https://github.com/nim-lang/choosenim).
(Do not forget to add the nimble binary directory (usually: `~/.nimble/bin`) to your systems path by appending `export PATH=$PATH:$HOME/.nimble/bin` to according configuration file like `~/.bashrc` or `~/.profile`.)

Clone the repository:
```
$ git clone https://github.com/Smintheus98/strim.git
$ cd strim
```

After installation of Nim use:
```
$ nimble install
```
to install the programs dependencies and compile and install the program afterwards.

The program will be installed to `$HOME/.nimble/bin`.
Make sure to include that directory into your system path.
For explicit instructions see beginning of this section.
