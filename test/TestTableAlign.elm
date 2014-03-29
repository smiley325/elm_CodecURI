module TestTableAlign where

import CURI_Data.ElemTable (alignTableColumns)


-- accord same width across row elements
fmtRow : Int -> [Int] -> [Element]
fmtRow w = map (container w 16 midRight . asText)

-- test
myTable = [fmtRow 30 [1,2,3], 
           fmtRow 60 [5,6]]

main = tabulate myTable |> map (flow right) |> flow down
