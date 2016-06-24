module Message exposing (..)

import Mouse as Mouse

type Msg
  = RCW
  | RCCW
  | NoOp
  | MouseMove Mouse.Position
