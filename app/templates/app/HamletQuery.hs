{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Main where

import Text.Hamlet (HtmlUrl, hamlet)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Data.Text (Text, append, pack)
import Control.Arrow (second)
import Network.HTTP.Types (renderQueryText)
import Data.Text.Encoding (decodeUtf8)
import Blaze.ByteString.Builder (toByteString)

data MyRoute = SomePage

render :: MyRoute -> [(Text, Text)] -> Text
render SomePage params = "/home" `append`
  decodeUtf8 (toByteString $ renderQueryText True (map (second Just) params))

main :: IO ()
main = do
  let currentPage = 2 :: Int
  putStrLn $ renderHtml $ [hamlet|
<p>
  You are currently on page #{currentPage}
  <a href=@?{(SomePage, [("page", pack $ show $ currentPage - 1)])}>Previous
  <a href=@?{(SomePage, [("page", pack $ show $ currentPage + 1)])}>Next
|] render
