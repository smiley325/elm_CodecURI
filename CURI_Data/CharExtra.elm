module CURI_Data.CharExtra where
{-| Extra library for non-existant ord and chr

# Char type interchange
@docs ord, chr
-}
import Native.CharExtra
import Native.Error

chr : Int -> Char
chr i = if i < 0
           then Native.Error.raise ("chr: negative input: " ++ show i)
           else Native.CharExtra.chr i
           
ord : Char -> Int
ord ch = Native.CharExtra.ord ch

