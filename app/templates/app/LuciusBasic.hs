{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

import Text.Lucius (lucius, luciusMixin, renderCss, Css, Mixin)
import Data.Text (Text)
import qualified Data.Text.Lazy.IO as TLIO

data MyRoute = BackgroundR

-- Trivial render function.
render :: MyRoute -> [(Text, Text)] -> Text
render BackgroundR _ = "/background"

-- Our mixin, which provides a number of vendor prefixes for transitions.
transition :: String -> Mixin
transition val = [luciusMixin|
  -webkit-transition: #{val};
  -moz-transition: #{val};
  -ms-transition: #{val};
  -o-transition: #{val};
  transition: #{val};
|]

-- Our actual Lucius template, which uses the mixin.
myCSS :: (MyRoute -> [(Text, Text)] -> Text) -> Css
myCSS = [lucius|
  .some-class {
    ^{transition "all 4s ease"}
  }
  section.blog {
    padding: 1em;
    border: 1px solid #000;
    h1 {
      color: #{headingColor};
      background-image: url(@{BackgroundR});
    }
  }
|]
  where
    headingColor = "red" :: String

main :: IO ()
main = TLIO.putStrLn $ renderCss $ myCSS render
