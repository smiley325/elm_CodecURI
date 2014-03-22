module CURI_Data.ElemTable where

{-| Element matrix as tables 

Rows don't need to have equal length

# Alignment
@docs alignTableColumns
-}

import CURI_Data.Util (transpose)

{-| alignTableColumns rows

set element widths to max width in column
-}
alignTableColumns : [[Element]] -> [[Element]]
alignTableColumns rows = case rows of
       [] -> []
       _ -> let cols = transpose rows
                colWidths = cols |> map (maximum . map widthOf)

            in rows |> map (\row -> zipWith width colWidths row)
