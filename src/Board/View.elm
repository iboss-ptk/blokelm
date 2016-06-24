module Board.View exposing (..)

import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)

import Polymino.Model exposing (..)
import Polymino.View exposing (renderBlock)

import Config exposing (board)


boardView : Svg a
boardView =
  svg []
    ( List.map
      ( \e ->
        renderBlock
          board.strokeColor
          board.fillColor
          (Offset 100 100)
          (Block ( fst e ) ( snd e ) )
      )
      grid20
    )


grid20 : List ( Int, Int )
grid20 =
  let
    row =
      \e -> List.map ( (,) e ) list20

  in
    List.concatMap row list20


list20 : List Int
list20 =
  [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  , 11, 12, 13, 14, 15, 16, 17, 18, 19
  ]
