module CURI_Data.HeaderEncodings where
{-| Headers attribute parameter value encoding following [RFC2231](https://tools.ietf.org/html/rfc2231) 

# RFC2231 attrib value encoding
@docs encodeHeaderAttUnwrapped, encodeHeaderAttWrapped 
-}

import CURI_Data.CodecURI (encodeURI)
import String as S
import Maybe (Maybe, isJust)
import CURI_Data.Util (fromMaybe, chunksOf)
import CURI_Data.CharExtra (ord)

{-| encodeHeaderAttUnwrapped  mbLang name value

one line encoding of name value pair 
-}
encodeHeaderAttUnwrapped : Maybe String -> String -> String -> String
encodeHeaderAttUnwrapped  mbLang name value =
  let isNotLatin1 ch = ord ch > 255
      encNeeded = S.any isNotLatin1 value
      lang = fromMaybe "" mbLang
  in if encNeeded
        then let v = concat <| intersperse "\'" ["utf-8", lang, encodeURI value]
             in name ++ "*=" ++ v
        else name ++ "=\"" ++ value ++ "\""

        
{-| encodeHeaderAttWrapped lineTopSize mbLang name value

line-wrapped version for long param. values, result begins with newline
-}       
encodeHeaderAttWrapped : Int -> Maybe String -> String -> String -> String        
encodeHeaderAttWrapped lineTopSize mbLang name value =
  let isNotLatin1 ch = ord ch > 255
      encNeeded = S.any isNotLatin1 value
      lang = fromMaybe "" mbLang
      unwrappedValue = if encNeeded 
                          then concat <| intersperse "\'" ["utf-8", lang, encodeURI value]
                          else value
                        
      unwrapped = if encNeeded
                    then name ++ "*=" ++ unwrappedValue
                    else name ++ "=" ++ value
                    
  in if S.length unwrapped < lineTopSize
        then unwrapped
        else let valueSpace = (lineTopSize - S.length name - 5)
                 valueData = if encNeeded 
                                then concat <| intersperse "\'" ["utf-8", lang, value]
                                else value
                 chunkSize = if encNeeded 
                                then valueSpace `div` 3
                                else valueSpace
                 chunks = chunksOf chunkSize valueData
                 chunksWithPos = zip chunks [0 .. (length chunks)]
                 showContinuation (chunk, pos) = 
                   let prefix = "\n" ++ name ++ "*" ++ show pos
                       suffix = if encNeeded 
                                  then "*=" ++ encodeURI chunk
                                  else "=\"" ++ chunk ++ "\""
                   in prefix ++ suffix  
             in concatMap showContinuation chunksWithPos    
