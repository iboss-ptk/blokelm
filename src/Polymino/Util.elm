module Polymino.Util exposing (..)

import Polymino.Model exposing (..)
import Config exposing (..)

import Mouse

type RDirection
  = CW
  | CCW


type alias Boundary =
  { x : { min : Int, max : Int }
  , y : { min : Int, max : Int }
  }


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


rotateCW = rotate CW
rotateCCW = rotate CCW


rotate : RDirection -> Polymino -> Polymino
rotate direction p =
  let
    newBlocks =
      List.map (moveBlock direction p.anchor) p.blocks
  in
    { p | blocks = newBlocks }


boundaryOf : Polymino -> Offset -> Boundary
boundaryOf polymino offset =
  let
    xs = List.map (\bs -> bs.x) polymino.blocks
    ys = List.map (\bs -> bs.y) polymino.blocks
  in
    Boundary
      { min = toRealPos offset.x ( minInt xs )
      , max = toRealPos offset.x ( maxInt xs + 1 )
      }
      { min = toRealPos offset.y ( minInt ys )
      , max = toRealPos offset.y ( maxInt ys + 1 )
      }


shouldSnap : Polymino -> Offset -> Bool
shouldSnap polymino offset =
    let
      snapBoundary =
        { x =
          { max = board.offset.x + round ( toFloat blockSize * 20.5 )
          , min = board.offset.x - round ( toFloat blockSize * 0.5 )
          }
        , y =
          { max = board.offset.y + round ( toFloat blockSize * 20.5 )
          , min = board.offset.y - round ( toFloat blockSize * 0.5 )
          }
        }

      polyminoBoundary = boundaryOf polymino offset

    in
      polyminoBoundary.x.min > snapBoundary.x.min
      && polyminoBoundary.x.max < snapBoundary.x.max
      && polyminoBoundary.y.min > snapBoundary.y.min
      && polyminoBoundary.y.max < snapBoundary.y.max


calibrateOffset : Mouse.Position -> Block -> Offset
calibrateOffset mousePos anchor =
  Offset
    ( calculateNewOffset mousePos.x anchor.x )
    ( calculateNewOffset mousePos.y anchor.y )


calculateNewOffset : Int -> Int -> Int
calculateNewOffset mousePos anchor =
  let
    mousePosf = toFloat mousePos
    blockSizef = toFloat blockSize
    anchorf = toFloat anchor
  in
    round ( mousePosf - blockSizef * ( anchorf + 0.5 ) )


maxInt : List Int -> Int
maxInt list = ( List.maximum list ) |> Maybe.withDefault 0


minInt : List Int -> Int
minInt list = ( List.minimum list ) |> Maybe.withDefault 0


toRealPos : Int -> Int -> Int
toRealPos offset index = offset + index * blockSize
