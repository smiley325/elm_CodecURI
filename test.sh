# $1 TestFileName
# example run: . ./test.sh TestCharExtra TestEncodeURI TestHeaderEnc
#
BROWSER=firefox

while (( "$#" )); do
  elm --make --src-dir=src --scripts=../../src/Native/CURI-runtime.js test/$1.elm && $BROWSER build/test/$1.html &
  shift
done