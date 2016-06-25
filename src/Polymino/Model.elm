module Polymino.Model exposing (..)

import Polymino.Collection exposing (..)


type Axis
  = X
  | Y


type alias Offset =
  { x : Int
  , y : Int
  }


type alias PolyminoModel =
  { polymino : Maybe Polymino
  , deck : List Polymino
  , offset : Offset
  , isSnapping : Bool
  }


-- Init

player1 = Player "#e74c3c"
player2 = Player "#f1c40f"
player3 = Player "#1abc9c"
player4 = Player "#3498db"


p : Polymino
p = pentomino12 player1 True


offset = Offset 50 50


initialPolyminoModel : PolyminoModel
initialPolyminoModel =
  PolyminoModel Nothing [] offset False
