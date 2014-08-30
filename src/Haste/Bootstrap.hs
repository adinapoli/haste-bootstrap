{-# LANGUAGE OverloadedStrings #-}
module Haste.Bootstrap where

import Haste
import Haste.Foreign




--------------------------------------------------------------------------------
-- | The state of a Bootstrap button.
-- See http://getbootstrap.com/javascript/#buttons
data ButtonState =
    Loading
  | Reset deriving Eq


instance Pack ButtonState

instance Unpack ButtonState

instance Show ButtonState where
  show Loading = "loading"
  show Reset   = "reset"

instance JSType ButtonState where
  toJSString = toJSString . show
  fromJSString "Loading" = Just Loading
  fromJSString "Reset"   = Just Reset
  fromJSString _         = Nothing


--------------------------------------------------------------------------------
setButtonState :: ButtonState -> Elem -> IO ()
setButtonState btn el = let btnJs = toJSString btn in doFFI btnJs el
  where
    doFFI :: JSString -> Elem -> IO ()
    doFFI = ffi "(function (st, domEl) { domEl.button(st); })"
