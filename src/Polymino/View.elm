module Polymino.View exposing (..)

import Polymino.Model exposing (..)
import Polymino.Collection exposing (..)
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
  let
    render =
      if (shouldSnap polymino offset) then
        renderSnappedBlock
      else
        renderNormalBlock

  in
    polymino.blocks
      |> List.map
        ( render polyminoStrokeColor polymino.color offset )


renderSnappedBlock = renderBlock snapAxis
renderNormalBlock = renderBlock identity


renderBlock : ( Int -> Int ) -> String -> String -> Offset -> Block -> Svg a
renderBlock transform strokeColor fillColor offset block =
  rect
    [ x ( ( toRealPos offset.x block.x ) |> transform |> toString )
    , y ( ( toRealPos offset.y block.y ) |> transform |> toString )
    , width ( toString blockSize )
    , height ( toString blockSize )
    , fill fillColor
    , stroke strokeColor
    ] []


snapAxis : Int -> Int
snapAxis a = round ( toFloat a / blockSize ) * blockSize
