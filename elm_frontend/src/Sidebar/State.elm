module Sidebar.State exposing (..)

import Globals exposing (..)
import Debug exposing (log)
import Sidebar.Types exposing (..)

initialModel : Flags -> Model
initialModel flags =
    {
         modules = flags.modules
        ,exceptions = flags.exceptions
        ,protocols = flags.protocols
        ,isOpen = True
        ,selectedCategory = EXTRAS
    }

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleSidebar ->
            let
              _ = log "Toggling sidebar" "toggle"
            in
                ({model | isOpen  = not model.isOpen } , Cmd.none)
        SelectCategory category ->
            let
              _ = log "Toggling select" "toggle"
            in
                ({model | selectedCategory  = category} , Cmd.none)
        NoOp ->
                (model, Cmd.none)



-- SUBSCRIPTIONS

-- subscriptions : Sub Msg
-- subscriptions =
--     Sub.batch [ Sub.map UpdateShowcase Showcase.subscriptions ]
