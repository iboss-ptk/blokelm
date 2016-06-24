module Polymino.Update exposing (update)

import Mouse

import Message exposing (..)

import Polymino.Message exposing (..)
import Polymino.Model exposing (..)
import Polymino.Util exposing (..)
import Config exposing (..)


update : PolyminoSubMsg -> PolyminoModel -> ( PolyminoModel, Cmd Msg )
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
      ( updateOnMouseMove model position
      , Cmd.none
      )

    NoOp ->
      ( model, Cmd.none )


updateOnMouseMove : PolyminoModel -> Mouse.Position -> PolyminoModel
updateOnMouseMove model position =
  { model | offset = calibrateOffset position model.polymino.anchor }
