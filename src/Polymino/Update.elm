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
      ( { model | polymino = Maybe.map rotateCW model.polymino }
      , Cmd.none
      )

    RCCW ->
      ( { model | polymino = Maybe.map rotateCCW model.polymino }
      , Cmd.none
      )

    MouseMove position ->
      ( updateOnMouseMove model position
      , Cmd.none
      )

    Select polymino ->
      ( { model | polymino = Just polymino }
      , Cmd.none
      )

    NoOp ->
      ( model, Cmd.none )


updateOnMouseMove : PolyminoModel -> Mouse.Position -> PolyminoModel
updateOnMouseMove model position =
  case model.polymino of
    Just p ->
      { model | offset = calibrateOffset position p.anchor }

    Nothing ->
      model
