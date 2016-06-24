module Polymino.Util exposing (..)

import Polymino.Model exposing (..)

type RDirection
  = CW
  | CCW

moveBlock : RDirection -> Block -> Block -> Block
moveBlock direction anchor block =
  let
    sinOrth =
      case direction of
        CW ->
          1
        CCW ->
          -1
  in
    { x = -sinOrth * ( block.y - anchor.y ) + anchor.x
    , y = sinOrth * ( block.x - anchor.x ) + anchor.y
    }

rotate : RDirection -> Polymino -> Polymino
rotate direction p =
  let
    newBlocks =
      List.map (moveBlock direction p.anchor) p.blocks
  in
    { p | blocks = newBlocks }

rotateCW = rotate CW
rotateCCW = rotate CCW
