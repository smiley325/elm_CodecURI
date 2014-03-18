module TestEncodeURI where

import open CURI_Data.CodecURI
-- import String as S

type MyTest a = { name:String, actual:a, expected:a}

test1 = {name="encodeURI", 
         actual = encodeURI "http://www.google.com/a file with spaces.html", 
         expected = "http://www.google.com/a%20file%20with%20spaces.html"}

test2 = {name="encodeURIComponent",
         actual = let p1 = encodeURIComponent("http://abc.com/?x=1&y=2")
                  in "http://www.domain.com/?p1=" ++ p1 ++ "&p2=2" ,
         expected = "http://www.domain.com/?p1=http%3A%2F%2Fabc.com%2F%3Fx%3D1%26y%3D2&p2=2" }  


runTest : MyTest a -> String
runTest test = "test: " ++ test.name ++ (if test.actual == test.expected 
                                            then " Ok" 
                                            else " Fail actual:" ++ show test.actual)

main = flow down <| map (asText . runTest) [test1, test2]