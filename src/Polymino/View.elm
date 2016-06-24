module Polymino.View exposing (..)

import Polymino.Model exposing (..)
import Polymino.Util as Util exposing (..)
import Polymino.Message exposing (..)
import Config exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


-- View Implementation

polyminoView : PolyminoModel -> Svg a
polyminoView model =
  svg [] ( renderPolymino model.offset model.polymino )


-- Helpers

renderPolymino : Offset -> Polymino -> List ( Svg a )
renderPolymino offset polymino =
  polymino.blocks
    |> List.map
      ( renderBlock polyminoStrokeColor polymino.color offset )



renderBlock : String -> String -> Offset -> Block -> Svg a
renderBlock strokeColor fillColor offset block =
  rect
    [ x ( toRealPos offset.x block.x )
    , y ( toRealPos offset.y block.y )
    , width ( toString blockSize )
    , height ( toString blockSize )
    , fill fillColor
    , stroke strokeColor
    ] []


toRealPos : Int -> Int -> String
toRealPos offset index =
  toString ( offset + index * blockSize )
