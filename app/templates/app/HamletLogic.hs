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
  let
    currentPage = 2 :: Int
    booleanFlagT = True
    booleanFlagF = False
    maybeJust = Just (1 :: Int)
    maybeNothing = Nothing
    maybeTwoStrings = Just ("foo" :: String, "bar" :: String)
    listOfInts = [1,2,3] :: [Int]
    eitherIntChar = Left 5 :: Either Int Char

  putStrLn $ renderHtml $ [hamlet|
<p #this-is-an-id .this-is-a-class>

  Working with Attributes
  <span style=quotesNotRequired>
  <span style="quotes required to embed spaces">
  <span valueIsOptional>
  <span :booleanFlagT:style="optional style" :booleanFlagF:attr="not rendered">
  <span :booleanFlagT:optionalAttribute :booleanFlagF:notRendered>
  <span :booleanFlagT:.className :booleanFlagF:.notRendered>

  If Blocks
  $if booleanFlagT
    <span>this is rendered
  $elseif booleanFlagF
    <span :True:style="interpolation happens here too">this is not
  $else
    <span>this is not either

  Maybe Blocks
  $maybe value <- maybeJust
    <span>The value is #{value}
  $nothing
    <span>There is no value

  $maybe value <- maybeNothing
    <span>Is something here?
  $nothing
    <span>something is not here

  $maybe (a,b) <- maybeTwoStrings
    <span>can also do basic pattern matching: #{a} and #{b}
  $nothing
    <span>nothing is here

  ForAll Blocks
  $forall num <- listOfInts
    <tt>#{num}

  Case Blocks for pattern matching
  $case eitherIntChar
    $of Left a
      <span>it is an #{a}
    $of Right b
      <span>it is an #{b}

  Expression blocks
  $with abbrev <- length $ listOfInts
    <span>Since #{abbrev} is used #{abbrev} more than once

  Doctype Abbreviations
  $doctype 5
|] render
