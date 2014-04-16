module TestTableAlign where

import CURI_Data.ElemTable (tabulate, alignTableColumns)


-- accord same width across row elements
fmtRow : Int -> [Int] -> [Element]
fmtRow w = map (container w 16 midRight . asText)

-- test
myTable = [fmtRow 30 [1,2,3,4], 
           fmtRow 60 [5,6,7,8,9]]

main = tabulate myTable |> map (flow right) |> flow down
