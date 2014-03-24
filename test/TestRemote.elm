module TestRemote where

import Graphics.Input as Input
import Http (..) 
import String (trim)
import JavaScript as JS
import JavaScript (JSString)
import CURI_Data.CodecURI as C

(fld1Elem, fld1Status) = Input.field "enter problematic characters"

url = "http://localhost:3000/echo-status"

urlSignal = lift (\str -> url ++ "; query status=" ++ str) fld1Status

-- local echo
fld2Elem = lift plainText urlSignal

myGet url status = C.urlEncodedGet url [("status",status)] [] False

myPost url status = C.urlEncodedPost url [("status",status)] [] False

resultSignal = send <| lift (myPost url) fld1Status 

showResult : Response String -> String
showResult result = case result of
                      Waiting -> "waiting"
                      Success str -> "success: " ++ trim str
                      Failure iStatus msg -> "failure! " ++ show iStatus ++ msg

--remote echo from localhost server                     
fld3Elem = lift (plainText . showResult) resultSignal

main = lift (flow down) <| combine [fld1Elem, fld2Elem, fld3Elem]
