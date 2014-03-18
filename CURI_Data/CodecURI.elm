module CURI_Data.CodecURI where

import Native.CodecURI
import Http (Request, request)
import String as S
import Native.Error

encodeURI : String -> String
encodeURI = Native.CodecURI.encodeURI

encodeURIComponent : String -> String
encodeURIComponent = Native.CodecURI.encodeURIComponent

decodeURI : String -> String
decodeURI = Native.CodecURI.decodeURI

decodeURIComponent : String -> String
decodeURIComponent = Native.CodecURI.decodeURIComponent

urlEncodedGet : String -> [(String, String)] -> [(String, String)] -> Bool -> Request String
urlEncodedGet url qry headers shouldEncodeNames = 

  if | url `S.contains` "?" -> Native.Error.raise ("urlEncodedGet: qry params must be specified apart : " ++ url)
     | otherwise -> 
        let encPair (k, v) = 
              if shouldEncodeNames 
                 then (encodeURI k, encodeURIComponent v)
                 else (k, encodeURIComponent v)
            qryNameValue (k, v) = k ++ "=" ++ v
            encQry = concat <| intersperse "&" <| map (qryNameValue . encPair) qry
            encUrlWithQry = encodeURI url ++ 
               (if isEmpty qry 
                  then ""
                  else "?" ++ encQry
                  )
        in request "GET" encUrlWithQry "" headers    

urlEncodedPost : String -> [(String, String)] -> [(String, String)] -> Bool -> Request String
urlEncodedPost url qry headers shouldEncodeNames = 
  
  if | url `S.contains` "?" -> Native.Error.raise ("urlEncodedPost: qry params must be specified apart : " ++ url)
     | otherwise -> 
        let encPair (k, v) = 
              if shouldEncodeNames 
                 then (encodeURI k, encodeURIComponent v)
                 else (k, encodeURIComponent v)
            qryNameValue (k, v) = k ++ "=" ++ v
            encQry = concat <| intersperse "&" <| map (qryNameValue . encPair) qry
            headersWithEncType = ("Content-Type","application/x-www-form-urlencoded") :: headers
        in request "POST" (encodeURI url) encQry headersWithEncType    

        
        