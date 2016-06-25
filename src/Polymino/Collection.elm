module Polymino.Collection exposing (..)


type alias Block =
  { x : Int
  , y : Int
  }


type alias Polymino =
  { blocks : List Block
  , anchor : Block
  , color : String
  }


--  Monomino

monomino1 = Polymino
  [ Block 0 0 ]
  ( Block 0 0 )

-- Domino

domino1 = Polymino
  [ Block 0 0
  , Block 1 0
  ]
  ( Block 0 0 )

-- Trominoes

tromino1 = Polymino
  [ Block 0 0
  , Block 1 0
  , Block 1 1
  ]
  ( Block 1 0 )


tromino2 = Polymino
  [ Block 0 0
  , Block 1 0
  , Block 2 0
  ]
  ( Block 1 0 )

-- Tetrominoes

tetromino1 = Polymino
  [ Block 0 0
  , Block 1 0
  , Block 0 1
  , Block 1 1
  ]
  ( Block 0 0 )


tetromino2 = Polymino
  [ Block 1 0
  , Block 0 1
  , Block 1 1
  , Block 2 1
  ]
  ( Block 1 1 )


tetromino3 = Polymino
  [ Block 0 0
  , Block 1 0
  , Block 2 0
  , Block 3 0
  ]
  ( Block 2 0 )


tetromino4 = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 0 2
  , Block 1 2
  ]
  ( Block 0 2 )


tetromino5 = Polymino
  [ Block 0 1
  , Block 1 1
  , Block 1 0
  , Block 2 0
  ]
  ( Block 1 0 )


-- Pentominoes

pentomino1 = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 1 1
  , Block 2 1
  , Block 3 1
  ]
  ( Block 1 1 )


pentomino2 = Polymino
  [ Block 0 2
  , Block 1 0
  , Block 1 1
  , Block 1 2
  , Block 2 2
  ]
  ( Block 1 1 )


pentomino3 = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 0 2
  , Block 1 2
  , Block 2 2
  ]
  ( Block 0 2 )


pentomino4 = Polymino
  [ Block 0 1
  , Block 1 0
  , Block 1 1
  , Block 2 0
  , Block 3 0
  ]
  ( Block 1 0 )


pentomino5 = Polymino
  [ Block 0 2
  , Block 1 1
  , Block 0 1
  , Block 2 1
  , Block 2 0
  ]
  ( Block 1 1 )


pentomino6 = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 0 2
  , Block 0 3
  , Block 0 4
  ]
  ( Block 0 2 )


pentomino7 = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 0 2
  , Block 1 1
  , Block 1 2
  ]
  ( Block 0 1 )


pentomino8 = Polymino
  [ Block 0 1
  , Block 0 2
  , Block 1 0
  , Block 1 1
  , Block 2 0
  ]
  ( Block 1 1 )


pentomino9 = Polymino
  [ Block 0 0
  , Block 0 1
  , Block 0 2
  , Block 1 0
  , Block 1 2
  ]
  ( Block 0 1 )


pentomino10 = Polymino
  [ Block 0 1
  , Block 1 0
  , Block 1 1
  , Block 2 1
  , Block 3 1
  ]
  ( Block 1 1 )


pentomino11 = Polymino
  [ Block 0 1
  , Block 1 0
  , Block 1 1
  , Block 1 2
  , Block 2 1
  ]
  ( Block 1 1 )


pentomino12 = Polymino
  [ Block 0 1
  , Block 1 0
  , Block 1 1
  , Block 1 2
  , Block 2 0
  ]
  ( Block 1 1 )
