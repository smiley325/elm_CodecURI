module CURI_Data.ElemTable where

{-| Element matrix as tables 

Rows lengths need not be equal

# Alignment
@ docs alignTableColumns
-}

import CURI_Data.Util (transpose)

{-| alignTableColumns

set element widths to max width in column
-}
alignTableColumns : [[Element]] -> [[Element]]
alignTableColumns rows = case rows of
       [] -> []
       _ -> let cols = transpose rows
                colWidths = cols |> map (maximum . (map widthOf))
                
                reformatRow : [Int] -> [Element] -> [Element]
                reformatRow colWidths row = row `zip` (take (length row) colWidths) 
                                                    |> map (\(elem, w) -> width w elem)
            in rows |> map (reformatRow colWidths)
