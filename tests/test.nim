import ../src/strim {.all.}

## Expected behaviour:
## TODO: Define expected behaviour

  
const s = "Der Dumme sagt, was er weiß, der Weise weiß, was er sagt."

doAssert substrBefore(s, "s") == "Der Dumme "
doAssert substrBefore(s, "wer") == s
doAssert substrBefore(s, "s", 2) == "Der Dumme sagt, wa"
doAssert substrBefore(s, "s", -1) == "Der Dumme sagt, was er weiß, der Weise weiß, was er "
doAssert substrBefore(s, "s", -2) == "Der Dumme sagt, was er weiß, der Weise weiß, wa"
doAssert substrBefore(s, "s", -2, true) == "Der Dumme sagt, was er weiß, der Weise weiß, was"
doAssert substrBefore(s, "s", 100) == s
doAssert substrBefore(s, "s", -100) == s
doAssert substrAfter(s, "s") == "agt, was er weiß, der Weise weiß, was er sagt."
doAssert substrAfter(s, "wer") == s
doAssert substrAfter(s, "s", 2) == " er weiß, der Weise weiß, was er sagt."
doAssert substrAfter(s, "s", -1) == "agt."
doAssert substrAfter(s, "s", -2) == " er sagt."
doAssert substrAfter(s, "s", -2, true) == "s er sagt."
doAssert substrAfter(s, "s", 100) == s
doAssert substrAfter(s, "s", -100) == s

echo "Test Passed Successfully"
