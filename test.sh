# $1 TestFileName
# example run: . ./test.sh TestCharExtra TestEncodeURI TestHeaderEnc
#
# TestRemote requires a server at http://localhost:3000/echo-status that echoes the status parameter (GET and POST)
#
BROWSER=firefox

while (( "$#" )); do
  elm --make --scripts=../../Native/CURI-runtime.js test/$1.elm && $BROWSER build/test/$1.html &
  shift
done