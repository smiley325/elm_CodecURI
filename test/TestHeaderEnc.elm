module TestHeaderEnc where

import Text as T
import CURI_Data.HeaderEncodings as H

legend = "IETF rfc2231 See examples at paragraphs 4, 4.1"
legend_link = "https://tools.ietf.org/html/rfc2231"

prependNl s = "\n" ++ s

-- src contains non-latin1 Unicode U+0140 (Latin small letter l with middle dot)
-- See: http://www.fileformat.info/info/unicode/char/0140/index.html

src = "és l'hora del coŀlegi vet aquí un gat vet aquí un gos"

test1 = H.encodeHeaderAttUnwrapped (Just "ca") "test1" src
test2 = H.encodeHeaderAttWrapped 48 (Just "ca") "test2" src

test1a = H.encodeHeaderAttUnwrapped Nothing "test1" src
test2a = H.encodeHeaderAttWrapped 48 Nothing "test2" src

-- src2: all latin1 characters, encoding not needed
src2 = "és l'hora del colegi vet aquí un gat vet aquí un gos"

test1b = H.encodeHeaderAttUnwrapped (Just "ca") "test1" src2
test2b = H.encodeHeaderAttWrapped 48 (Just "ca") "test2" src2

tests = map (plainText . prependNl) [test1, test2, test1a, test2a, test1b, test2b]
prelude = link legend_link <| (text . T.color red . underline . toText) legend

main = flow down <| (prelude :: tests)
