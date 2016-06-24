module Polymino.Subscription exposing (polyminoSubsciptions)

import Mouse
import Keyboard
import Char exposing (KeyCode)

import Polymino.Message exposing (..)


polyminoSubsciptions =
  [ Keyboard.presses rotationKey
  , Mouse.moves MouseMove
  ]


rotationKey : KeyCode -> PolyminoSubMsg
rotationKey keyCode =
  case ( Char.fromCode keyCode ) of
    'a' ->
      RCCW
    'd' ->
      RCW
    _ ->
      NoOp
