{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings    #-}
{-# LANGUAGE TemplateHaskell      #-}
{-# LANGUAGE QuasiQuotes          #-}
{-# LANGUAGE TypeFamilies         #-}

import Yesod

data HelloWorldJson = HelloWorldJson

mkYesod "HelloWorldJson" [parseRoutes|
/ HomeR GET
|]

instance Yesod HelloWorldJson

getHomeR :: Handler Value
getHomeR = return $ object ["msg" .= "Hello World"]

main :: IO ()
main = warp 5050 HelloWorldJson
