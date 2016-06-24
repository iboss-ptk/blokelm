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
