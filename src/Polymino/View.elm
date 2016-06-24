module Polymino.View exposing (..)

import Polymino.Model exposing (..)
import Polymino.Util as Util exposing (..)
import Polymino.Message exposing (..)
import Polymino.Config exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


-- View Implementation

polyminoView : PolyminoModel -> Svg PolyminoSubMsg
polyminoView model =
  svg [] ( renderPolymino model.offset model.polymino )


-- Helpers

renderPolymino : Offset -> Polymino -> List ( Svg PolyminoSubMsg )
renderPolymino offset polymino =
  List.map ( renderBlock polymino.color offset ) polymino.blocks


renderBlock : String -> Offset -> Block -> Svg PolyminoSubMsg
renderBlock fillColor offset block =
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
