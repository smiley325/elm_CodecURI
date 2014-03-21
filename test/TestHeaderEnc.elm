module TestHeaderEnc where

import Text as T
import CURI_Data.HeaderEncodings as H

legend = "IETF rfc2231 See examples at paragraphs 4, 4.1"
legend_link = "https://tools.ietf.org/html/rfc2231"

prependNl s = "\n" ++ s

sep = plainText "\n\n"

-- src contains non-latin1 Unicode U+0140 (Latin small letter l with middle dot)
-- See: http://www.fileformat.info/info/unicode/char/0140/index.html

titleStyle : Text -> Text
titleStyle = T.height 24 . T.color red

sect1 = titleStyle <| toText "\n## With non latin1 characters, and language == Just ca"

src = "és l'hora del coŀlegi vet aquí un gat vet aquí un gos"

test1 = H.encodeHeaderAttUnwrapped (Just "ca") "test1" src
test2 = H.encodeHeaderAttWrapped 48 (Just "ca") "test2" src

sect1Layout : [Element]
sect1Layout = (text sect1) :: (map (plainText . prependNl) [test1, test2])

sect2 = titleStyle <| toText "\n## With non latin1 characters, and language == Nothing"

test1a = H.encodeHeaderAttUnwrapped Nothing "test1" src
test2a = H.encodeHeaderAttWrapped 48 Nothing "test2" src

sect2Layout = text sect2 :: (map (plainText . prependNl) [test1a, test2a])

sect3 = titleStyle <| toText "\n## Without non latin1 characters, and language == Just ca"

-- src2: all latin1 characters, encoding not needed
src2 = "és l'hora del colegi vet aquí un gat vet aquí un gos"

test1b = H.encodeHeaderAttUnwrapped (Just "ca") "test1" src2
test2b = H.encodeHeaderAttWrapped 48 (Just "ca") "test2" src2

sect3Layout = text sect3 :: (map (plainText . prependNl) [test1b, test2b])

prelude = link legend_link <| (text . T.color red . underline . toText) legend

main = flow down <| [prelude] ++ sect1Layout ++ sect2Layout ++ sect3Layout
