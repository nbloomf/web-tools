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

myLayout :: Widget -> Handler Html
myLayout widget = do
  pc <- widgetToPageContent $ do
    widget
    toWidget [lucius|body { font-family: verdana; }|]
  withUrlRenderer
    [hamlet|
      $doctype 5
      <html>
        <head>
          <title>#{pageTitle pc}
          <meta charset=utf-8>
          ^{pageHead pc}
        <body>
          <article>
            ^{pageBody pc}
    |]

instance Yesod App where
  defaultLayout = myLayout

getHomeR :: HandlerFor App Html
getHomeR = defaultLayout $ do
  [whamlet|
    <p>Howdy doody
  |]

main :: IO ()
main = warp 5050 App
