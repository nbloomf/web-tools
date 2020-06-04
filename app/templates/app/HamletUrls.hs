{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

module Main where

import Text.Hamlet (HtmlUrl, hamlet)
import Text.Blaze.Html.Renderer.String (renderHtml)
import Data.Text (Text)

data MyRoute = Home

render :: MyRoute -> [(Text, Text)] -> Text
render Home _ = "/home"

footer :: HtmlUrl MyRoute
footer = [hamlet|
<footer>
  Return to #
  <a href=@{Home}>Home page
  .
|]

main :: IO ()
main = putStrLn $ renderHtml $ [hamlet|
<body>
  <p>This is muh page.
  ^{footer}
|] render
