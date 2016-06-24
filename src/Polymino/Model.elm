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
  { polymino : Polymino
  , offset : Offset
  , isSnapping : Bool
  }


-- Init

p : Polymino
p = pentomino12 "#9b59b6"


offset = Offset 50 50


initialPolyminoModel : PolyminoModel
initialPolyminoModel =
  PolyminoModel p offset False
