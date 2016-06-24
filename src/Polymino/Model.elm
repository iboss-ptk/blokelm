module Polymino.Model exposing (..)


type alias Block =
  { x : Int
  , y : Int
  }


type alias Polymino =
  { blocks : List Block
  , anchor : Block
  , color : String
  }


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

tromino : Polymino
tromino = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 0 2
  ]
  ( Block 0 1 )
  "#2ecc71"


offset = Offset 50 50


initialPolyminoModel : PolyminoModel
initialPolyminoModel =
  PolyminoModel tromino offset False
