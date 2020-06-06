{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import Yesod

data App = App

mkYesod "App" [parseRoutes|
/ HomeR GET
|]

instance Yesod App

getHomeR :: HandlerFor App Html
getHomeR = defaultLayout $ do
  headerClass <- newIdent
  toWidget [hamlet|<h1 .#{headerClass}>My Header|]
  toWidget [lucius| .#{headerClass} { color: green; }|]
  page

page :: Widget
page = [whamlet|
<p>This is muh page. I hope you like it
^{footer}
|]

footer :: Widget
footer = do
  toWidget [lucius|
    footer {
      font-weight: bold;
      text-align: center;
    }
  |]
  toWidget [hamlet|
    <footer>
      <p>That's all folx
  |]

main :: IO ()
main = warp 5050 App
