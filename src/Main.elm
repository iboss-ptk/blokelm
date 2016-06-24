import Svg exposing (..)
import Svg.Attributes exposing (..)
import Svg.Events exposing (..)

import Message exposing (..)

import Polymino.View exposing (..)
import Polymino.Model exposing (..)
import Polymino.Message exposing (..)
import Polymino.Subscription exposing (polyminoSubsciptions)
import Polymino.Update exposing (update)

import Board.View exposing (boardView)

import Keyboard
import Mouse
import VirtualDom

import Char exposing (KeyCode)

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
  { polyminoModel : PolyminoModel
  }


init : ( Model, Cmd Msg )
init =
  ( Model initialPolyminoModel
  , Cmd.none
  )


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    PolyminoMsg subMsg ->
      let
        (updatedPolyminoModel, polyminoCmd) =
          Polymino.Update.update subMsg model.polyminoModel
      in
        ( { model | polyminoModel = updatedPolyminoModel }
        , polyminoCmd
        )


-- VIEW

view : Model -> Svg Msg
view model =
  svg
    [ width "1200", height "1200" ]
    [ boardView
    , VirtualDom.map PolyminoMsg ( polyminoView model.polyminoModel )
    ]


-- SUBSCRIPTIONS

subscriptionList =
  List.map ( Sub.map PolyminoMsg ) polyminoSubsciptions


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch subscriptionList
