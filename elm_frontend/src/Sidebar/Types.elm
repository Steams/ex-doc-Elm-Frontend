module Sidebar.Types exposing (..)

import Globals exposing (..)

-- MESSAGES

type Msg
    = NoOp
    | ToggleSidebar
    | SelectCategory Category

type Category
    = EXTRAS
    | MODULES
    | EXCEPTIONS
    | PROTOCOLS

-- MODEL

type alias Model =
    {
         modules : List Module
        ,exceptions : List Exception
        ,protocols : List Protocol
        ,isOpen : Bool
        ,selectedCategory : Category
    }

