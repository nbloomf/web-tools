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
  myWidget1
  myWidget2

myWidget1 :: Widget
myWidget1 = do
  toWidget [hamlet|<h1>My Title|]
  toWidgetBody
    [hamlet|<script src=/included-in-body.js>|]
  toWidgetHead
    [hamlet|<script src=/included-in-head.js>|]
  toWidget [lucius|h1 { color: green } |]

myWidget2 :: Widget
myWidget2 = do
  setTitle "My Page Title"
  addScriptRemote "http://www.example.com/script.js"

main :: IO ()
main = warp 5050 App
