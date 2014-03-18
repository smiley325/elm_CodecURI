module CURI_Data.CodecURI where
{-| This library brings url encoded Request String for GET and Post

as well as JavaScript encodeURI, encodeURIComponent and decode.. correspondents 
-}

import Native.CodecURI
import Http (Request, request)
import String as S
import Native.Error

{-| elm interface to Javascript function -} 
encodeURI : String -> String
encodeURI = Native.CodecURI.encodeURI

{-| elm interface to Javascript function -} 
encodeURIComponent : String -> String
encodeURIComponent = Native.CodecURI.encodeURIComponent

{-| elm interface to Javascript function -} 
decodeURI : String -> String
decodeURI = Native.CodecURI.decodeURI

{-| elm interface to Javascript function -} 
decodeURIComponent : String -> String
decodeURIComponent = Native.CodecURI.decodeURIComponent

{-| build an encoded GET Request 
    url must not include a query part
    shouldEncodeNames is for encoding non latin1 parameter names
-} 
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

{-| build an encoded GET Request 
    url must not include a query part
    shouldEncodeNames is for encoding non latin1 parameter names
-} 
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

        
        