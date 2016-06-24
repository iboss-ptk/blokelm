import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)

import Message exposing (..)

import Polymino.View exposing (..)
import Polymino.Model exposing (..)
import Polymino.Util exposing (rotateCW, rotateCCW)

import Keyboard as Keyboard
import Mouse as Mouse

import Char as Char exposing (KeyCode)

import Html.App as Html


main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { polymino : Polymino
  , offset : Offset
  }


tromino : Polymino
tromino = Polymino
  [ Block 1 0
  , Block 1 1
  , Block 1 2
  , Block 1 3
  , Block 0 2
  , Block 0 3
  , Block 2 2
  , Block 2 3
  ]
  ( Block 1 2 )
  "#14B7CC"

offset = Offset 50 50

init : ( Model, Cmd Msg )
init =
  ( Model tromino offset
  , Cmd.none
  )

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
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
    blockSize = 30
  in
    round
      ( toFloat mousePos
      - blockSize * ( toFloat anchor + 0.5 )
      )

-- VIEW

view : Model -> Svg Msg
view model =
  svg [ width "800", height "800" ]
    ( renderPolymino model.offset model.polymino)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.presses rotationKey
    , Mouse.moves MouseMove
    ]


rotationKey : KeyCode -> Msg
rotationKey keyCode =
  case ( Char.fromCode keyCode ) of
    'a' ->
      RCCW
    'd' ->
      RCW
    _ ->
      NoOp
