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
  }


-- Init

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


initialPolyminoModel : PolyminoModel
initialPolyminoModel =
  PolyminoModel tromino offset
