module Polymino.Message exposing (..)

import Mouse

type PolyminoSubMsg
  = RCW
  | RCCW
  | NoOp
  | MouseMove Mouse.Position
