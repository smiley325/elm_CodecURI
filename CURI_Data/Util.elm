module CURI_Data.Util where
{-| not so uncommmon utility routines

# Miscellaneous
@docs fromMaybe, unfoldr, chunksOf
-}
import String as S

{-| missing in the Maybe library -}
fromMaybe : a -> Maybe a -> a
fromMaybe default mb = 
  case mb of
    Just v -> v
    Nothing -> default

{-| missing in the List library -}
unfoldr : (b -> Maybe (a, b)) -> b -> [a]
unfoldr f b  =
  case f b of
   Just (a, new_b) -> a :: unfoldr f new_b
   Nothing        -> []    

{-| could be added to the String library-}   
chunksOf : Int -> String -> [String]
chunksOf size str =
  let f s = 
    let (prefix, suffix) = (S.left size s, S.dropLeft size s)
    in if S.isEmpty prefix 
         then Nothing
         else Just (prefix, suffix)
  in unfoldr f str         
  