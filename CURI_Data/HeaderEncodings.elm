module CURI_Data.HeaderEncodings where
{-| Headers attribute parameter value encoding following [RFC2231](https://tools.ietf.org/html/rfc2231) 

# RFC2231 attrib value encoding
@docs encodeHeaderAttUnwrapped, encodeHeaderAttWrapped 
-}

import CURI_Data.CodecURI (encodeURI)
import String as S
import Maybe (Maybe, isJust)
import CURI_Data.Util (fromMaybe)
import Char (toCode)
import CURI_Data.HeaderEncodingsPrivate (encAttUnwrapped, encodeHeaderAttWrapped_FirstLine
                                                        , encodeHeaderAttWrapped_ContinuationLines)

{-| encodeHeaderAttUnwrapped  mbLang name value

one line encoding of name value pair 
-}
encodeHeaderAttUnwrapped : Maybe String -> String -> String -> String
encodeHeaderAttUnwrapped  mbLang name value =
  let isNotLatin1 ch = toCode ch > 255
      encNeeded = S.any isNotLatin1 value
      lang = fromMaybe "" mbLang
  in encAttUnwrapped encNeeded lang name value
-------------------------------------------        

{-| encodeHeaderAttWrapped lineTopSize mbLang name value

line-wrapped version for long param. values, result begins with newline
-}       
encodeHeaderAttWrapped : Int -> Maybe String -> String -> String -> String        
encodeHeaderAttWrapped lineTopSize mbLang name value =
  let isNotLatin1 ch = toCode ch > 255
      encNeeded = S.any isNotLatin1 value
      lang = fromMaybe "" mbLang
      unwrapped = encAttUnwrapped encNeeded lang name value
                    
  in if S.length unwrapped < lineTopSize
        then "\n" ++ unwrapped
        else let valueSpace = (lineTopSize - S.length name - 5) -- 5 for "*NN*="
                 charsetLangPrefix = "utf-8'" ++ lang ++ "'"
                 (firstLine, valueContinuation) = encodeHeaderAttWrapped_FirstLine valueSpace charsetLangPrefix encNeeded name value    
             in  firstLine ++ encodeHeaderAttWrapped_ContinuationLines valueSpace encNeeded name valueContinuation 
             