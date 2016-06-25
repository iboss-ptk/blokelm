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
  svg []
    [ deck
    , svg [] ( renderPolymino model.offset model.polymino )
    ]


deck : Svg a
deck =
  svg [ x "780", y "120" ]
    ( col1 ++ col2 ++ col3 ++ col4 )


col1 : List ( Svg a )
col1 =
  [ monomino1 , domino1 , tromino1 , tromino2
  , tetromino1, tetromino2, tetromino3, tetromino4
  ]
    |> List.map ( \p -> p "#9b59b6" )
    |> renderDeckRow ( Offset 0 0 )


col2 : List ( Svg a )
col2 =
  [ tetromino5, pentomino1, pentomino2
  , pentomino3, pentomino4, pentomino5
  ]
    |> List.map ( \p -> p "#9b59b6" )
    |> renderDeckRow ( Offset ( 5 * blockSize ) 0 )


col3 : List ( Svg a )
col3 =
  [ pentomino6, pentomino7, pentomino8
  , pentomino9, pentomino10
  ]
    |> List.map ( \p -> p "#9b59b6" )
    |> renderDeckRow ( Offset ( 10 * blockSize ) 0 )


col4 : List ( Svg a )
col4 =
  [ pentomino11, pentomino12 ]
    |> List.map ( \p -> p "#9b59b6" )
    |> renderDeckRow ( Offset ( 13 * blockSize ) 0 )


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


renderDeckRow : Offset -> List Polymino -> List ( Svg a )
renderDeckRow offset polyminoes =
  polyminoes
    |> polyminoSpace offset
    |> List.map ( \poff -> renderPolymino ( snd poff ) ( fst poff ) )
    |> List.concat


polyminoSpace : Offset -> List Polymino -> List ( Polymino, Offset )
polyminoSpace offset polyminoes =
  case polyminoes of
    [ ] ->
      [ ]

    p :: ps ->
      let
        nextOffset =
          { offset | y = blockSize + ( boundaryOf p offset ).y.max }

      in
        [ ( p, offset ) ] ++ ( polyminoSpace nextOffset ps )
