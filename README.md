## Elm library to url_encode Http.send requests

tests run: . ./test.sh TestCharExtra TestEncodeURI TestHeaderEnc

using this library requires 
   --scripts=elm_dependencies/griba2001-elm_CodecURI/N.N.N/Native/CURI-runtime.js 

(check test.sh)

#### CURI_Data.CodecURI exposes:

````
urlEncodedGet, urlEncodedPost : String -> [(String, String)] -> [(String, String)] -> Bool -> Request String
urlEncoded{Get|Post} url qry headers shouldEncodeNames

{encode|decode}URI : String -> String
{encode|decode}URIComponent : String -> String
````
------------------

#### CURI_Data.HeaderEncodings exposes:

[RFC2231](https://tools.ietf.org/html/rfc2231) compliant functions to encode non-latin1 parameter values in headers.   

````
encodeHeaderAttUnwrapped : Maybe String -> String -> String -> String
encodeHeaderAttUnwrapped  mbLang name value

-- line-wrapped version for long parameter values

encodeHeaderAttWrapped : Int -> Maybe String -> String -> String -> String        
encodeHeaderAttWrapped lineTopSize mbLang name value
````
------------------

#### CURI_Data.Util 

(fromMaybe, lists unfoldr, strings chunksOf)


