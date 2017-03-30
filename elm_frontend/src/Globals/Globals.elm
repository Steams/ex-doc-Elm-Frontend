module Globals exposing (..)

type alias Flags =
    { extras : List Extra
    , exceptions : List Exception
    , modules : List Module
    , protocols : List Protocol
    }

type alias Extra = {id : String, title : String, group : String, headers : List Header}

type alias Header = {id : String, anchor : String}

type alias Exception = {id : String, title : String, functions : Maybe (List Function)}

type alias Function = {id : String, anchor : String}

type alias Module = {id : String, title : String, functions : List Function}

type alias Protocol = {id : String, title : String, functions : List Function, types : List ProtocolType}

type alias ProtocolType = {id : String, anchor : String}
