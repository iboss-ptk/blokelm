module Polymino.Update exposing (update)

import Mouse

import Polymino.Message exposing (..)
import Polymino.Model exposing (..)
import Polymino.Util exposing (..)
import Polymino.Config exposing (..)


update : PolyminoSubMsg -> PolyminoModel -> ( PolyminoModel, Cmd PolyminoSubMsg )
update msg model =
  case msg of
    RCW ->
      ( { model | polymino = ( rotateCW model.polymino ) }
      , Cmd.none
      )

    RCCW ->
      ( { model | polymino = ( rotateCCW model.polymino ) }
      , Cmd.none
      )

    MouseMove position ->
      ( { model | offset = calibrateOffset position model.polymino.anchor }
      , Cmd.none
      )

    NoOp ->
      ( model, Cmd.none )


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
