module CURI_Data.HeaderEncodingsPrivate where
{-| private functions for CURI_Data.HeaderEncodings
-}

import CURI_Data.CodecURI (encodeURI)
import String as S
import CURI_Data.Util (chunksOf, strSplitAt)


encAttUnwrapped : Bool ->  String -> String -> String -> String
encAttUnwrapped encNeeded lang name value =
  if encNeeded
        then let v = concat <| intersperse "\'" ["utf-8", lang, encodeURI value]
             in name ++ "*=" ++ v
        else name ++ "=\"" ++ value ++ "\""

encodeHeaderAttWrapped_FirstLine : Int -> String -> Bool -> String -> String -> (String, String)        
encodeHeaderAttWrapped_FirstLine valueSpace charsetLangPrefix encNeeded name value =
  if encNeeded 
    then let chunkSize = (valueSpace - S.length charsetLangPrefix) `div` 3  -- to prevent %dd tripling char space
             (valuePrefix, valueSuffix) = strSplitAt chunkSize value
             firstLine = "\n" ++ name ++ "*0*=" ++ charsetLangPrefix ++ encodeURI valuePrefix
         in (firstLine, valueSuffix)    
    else let chunkSize = valueSpace - 2  -- for enclosing double quotes
             (valuePrefix, valueSuffix) = strSplitAt chunkSize value
             firstLine = "\n" ++ name ++ "*0=\"" ++ valuePrefix ++ "\""
         in (firstLine, valueSuffix)    
             
encodeHeaderAttWrapped_ContinuationLines : Int -> Bool -> String -> String -> String
encodeHeaderAttWrapped_ContinuationLines valueSpace encNeeded name valueContinuation =
  if encNeeded
     then let chunkSize = valueSpace `div` 3 -- to prevent %dd tripling char space
              chunks = chunksOf chunkSize valueContinuation
              chunksWithPos = zip chunks [1 .. (length chunks)]
              showContinuation (chunk, pos) = "\n" ++ name ++ "*" ++ show pos ++ "*=" ++ encodeURI chunk                
          in concatMap showContinuation chunksWithPos 
     else let chunkSize = valueSpace - 2  -- for enclosing double quotes    
              chunks = chunksOf chunkSize valueContinuation
              chunksWithPos = zip chunks [1 .. (length chunks)]
              showContinuation (chunk, pos) = "\n" ++ name ++ "*" ++ show pos ++ "=\"" ++ chunk ++ "\""               
          in concatMap showContinuation chunksWithPos 
             