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

polyminoView : PolyminoModel -> Svg PolyminoSubMsg
polyminoView model =
  case model.polymino of
    Just polymino ->
      svg []
        [ activePolymino model.offset polymino
        , deck player2
        ]

    Nothing ->
      svg []
        [ deck player2 ]


activePolymino : Offset -> Polymino -> Svg PolyminoSubMsg
activePolymino offset polymino =
  if ( shouldSnap polymino offset ) then
    renderPolymino offset polymino

  else
    svg [] []


deck : Player -> Svg PolyminoSubMsg
deck player =
  svg [ x "560", y "120" ]
    ( [ col1, col2, col3, col4 ]
      |> List.concatMap ( \c -> c player ) )


col1 : Player -> List ( Svg PolyminoSubMsg )
col1 player =
  [ monomino1 , domino1 , tromino1 , tromino2
  , tetromino1, tetromino2, tetromino3, tetromino4
  ]
    |> renderDeckRow player ( Offset 0 0 )


col2 : Player -> List ( Svg PolyminoSubMsg )
col2 player =
  [ tetromino5, pentomino1, pentomino2
  , pentomino3, pentomino4, pentomino5
  ]
    |> renderDeckRow player ( Offset ( 5 * blockSize ) 0 )


col3 : Player -> List ( Svg PolyminoSubMsg )
col3 player =
  [ pentomino6, pentomino7, pentomino8
  , pentomino9, pentomino10
  ]
    |> renderDeckRow player ( Offset ( 10 * blockSize ) 0 )


col4 : Player -> List ( Svg PolyminoSubMsg )
col4 player =
  [ pentomino11, pentomino12 ]
    |> renderDeckRow player ( Offset ( 13 * blockSize ) 0 )


-- Helpers

renderPolymino : Offset -> Polymino -> Svg PolyminoSubMsg
renderPolymino offset polymino =
  let
    render =
      if (shouldSnap polymino offset) then
        renderSnappedBlock
      else
        renderNormalBlock

    opacityLevel = if polymino.isAvailable then "1" else "0.3"

  in
    polymino.blocks
      |> List.map
        ( render opacityLevel polyminoStrokeColor polymino.player.color offset )
      |> svg [ onClick ( Select polymino ) ]


renderSnappedBlock = renderBlock snapAxis
renderNormalBlock = renderBlock identity


renderBlock : ( Int -> Int ) -> String -> String -> String -> Offset -> Block -> Svg a
renderBlock transform opacityLevel strokeColor fillColor offset block =
  rect
    [ x ( ( toRealPos offset.x block.x ) |> transform |> toString )
    , y ( ( toRealPos offset.y block.y ) |> transform |> toString )
    , width ( toString blockSize )
    , height ( toString blockSize )
    , fill fillColor
    , stroke strokeColor
    , opacity opacityLevel
    ] []


snapAxis : Int -> Int
snapAxis a = round ( toFloat a / blockSize ) * blockSize


renderDeckRow : Player -> Offset -> List ( Player -> Bool -> Polymino ) -> List ( Svg PolyminoSubMsg )
renderDeckRow player offset polyminoes =
  polyminoes
    |> List.map ( \p -> p player True )
    |> polyminoSpace offset
    |> List.map ( \poff -> renderPolymino ( snd poff ) ( fst poff ) )


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
