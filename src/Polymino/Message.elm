module Polymino.Message exposing (..)

import Mouse
import Polymino.Collection exposing (Polymino)

type PolyminoSubMsg
  = RCW
  | RCCW
  | NoOp
  | MouseMove Mouse.Position
  | Select Polymino
