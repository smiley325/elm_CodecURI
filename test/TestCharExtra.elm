module TestCharExtra where

import CURI_Data.CharExtra ( chr, ord)

ch : Char
ch = chr 65

codi : Int
codi = ord 'A'

main = flow down <| map plainText [show ch, show codi]