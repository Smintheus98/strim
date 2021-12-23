#!/usr/bin/bash

string1="foobarspameggs"
string2="aaooobb"
exe="bin/strim"
testfile=/tmp/testdata.txt

RED="\e[31;1m"
MAGENTA="\e[35;1m"
RESET="\e[0m"

function check1 {
    # check if command $1 has a result that equals $2
    if [[ $(eval $1) != $2 ]] ; then
        echo -e "${RED}Failure: ${MAGENTA}'$1'${RESET} = ${MAGENTA}'$(eval $1)'${RESET} != ${MAGENTA}'$2'${RESET}"
        exit 1
    fi
}

function check2 {
    # check if command $1 exits with errorcode
    if $(eval $1 &>/dev/null) ; then
        echo -e "${RED}Failure: ${MAGENTA}'$1'${RESET} Does not give Error"
        exit 1
    fi
}


# test modes
    # indices
    check1  "$exe   -i 3,8          $string1"       "barsp"
    check1  "$exe   -i 3:8          $string1"       "barsp"
    check1  "$exe   -i 8            $string1"       "ameggs"
    check1  "$exe   -i 3 -l 2       $string1"       "ba"

    # before        
    check1  "$exe   -b a            $string1"       "foob"
    check1  "$exe   -b a -w         $string1"       "fooba"
    check1  "$exe   -b a -o 2       $string1"       "foobarsp"
    check1  "$exe   -b a -o 2 -w    $string1"       "foobarspa"
    check1  "$exe   -b a -o -2      $string1"       "foob"
    check1  "$exe   -b a -o -2 -w   $string1"       "fooba"
    check1  "$exe   -b oo           $string2"       "aa"
    check1  "$exe   -b oo -o 2      $string2"       "aao"
    check1  "$exe   -b oo -o 2 -w   $string2"       "aaooo"

    # after        
    check1  "$exe   -a a            $string1"       "rspameggs"
    check1  "$exe   -a a -w         $string1"       "arspameggs"
    check1  "$exe   -a a -o 2       $string1"       "meggs"
    check1  "$exe   -a a -o 2 -w    $string1"       "ameggs"
    check1  "$exe   -a a -o -2      $string1"       "rspameggs"
    check1  "$exe   -a a -o -2 -w   $string1"       "arspameggs"
    check1  "$exe   -a oo           $string2"       "obb"
    check1  "$exe   -a oo -o 2      $string2"       "bb"
    check1  "$exe   -a oo -o 2 -w   $string2"       "oobb"

# test input variants (pipelining, input-redirection)
    check1  "$exe   -i 3 -l 2       $string1"       "ba"
    check1  "echo $string1 | $exe   -i 3 -l 2"      "ba"
    if [[ ! -f $testfile ]] ; then
        echo $string1 > $testfile
        check1  "$exe   -i 3 -l 2       <$testfile"      "ba"
        rm $testfile
    fi
    

# test failing options
    # incompatible options, missing or invalid values or ambiguous mode
   check2   "$exe   -o              $string1"
   check2   "$exe   -o 1            $string1"
   check2   "$exe   -w              $string1"
   check2   "$exe   -l              $string1"
   check2   "$exe   -l 1            $string1"
   check2   "$exe   -b a -l 1       $string1"
   check2   "$exe   -a a -l 1       $string1"
   check2   "$exe   -i              $string1"
   check2   "$exe   -i 2,4 -l 1     $string1"
   check2   "$exe   -i 2,4 -b       $string1"
   check2   "$exe   -i 2,4 -a       $string1"
   check2   "$exe   -i 2,4 -o 1     $string1"
   check2   "$exe   -i 2,4 -w       $string1"
   check2   "$exe   -b a -a a       $string1"
   check2   "$exe   -b                      "
   check2   "$exe   -a                      "


echo "External Test Passed Successfully"
