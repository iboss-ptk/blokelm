module Polymino.View exposing (..)

import Polymino.Model exposing (..)
import Polymino.Util as Util exposing (..)

import Message exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)


blockSize : Int
blockSize = 30


type alias Offset =
  { x : Int
  , y : Int
  }


strokeColor : String
strokeColor = "#ecf0f1"


toRealPos : Int -> Int -> String
toRealPos offset index =
  toString ( offset + index * blockSize )


renderBlock : String -> Offset -> Block -> Svg Msg
renderBlock fillColor offset block =
  rect
    [ x ( toRealPos offset.x block.x )
    , y ( toRealPos offset.y block.y )
    , width ( toString blockSize )
    , height ( toString blockSize )
    , fill fillColor
    , stroke strokeColor
    ] []


renderPolymino : Offset -> Polymino -> List ( Svg Msg )
renderPolymino offset polymino =
  List.map ( renderBlock polymino.color offset ) polymino.blocks
