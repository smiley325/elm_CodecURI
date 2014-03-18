module CURI_Data.Util where

import String as S
-- utilities

fromMaybe : a -> Maybe a -> a
fromMaybe default mb = 
  case mb of
    Just v -> v
    Nothing -> default

unfoldr : (b -> Maybe (a, b)) -> b -> [a]
unfoldr f b  =
  case f b of
   Just (a, new_b) -> a :: unfoldr f new_b
   Nothing        -> []    

chunksOf : Int -> String -> [String]
chunksOf size str =
  let f s = 
    let (prefix, suffix) = (S.left size s, S.dropLeft size s)
    in if S.isEmpty prefix 
         then Nothing
         else Just (prefix, suffix)
  in unfoldr f str         
  