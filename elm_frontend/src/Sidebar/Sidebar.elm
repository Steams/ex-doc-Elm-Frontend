module Sidebar exposing (..)

import Html exposing (Html)

import Globals exposing (..)

import Sidebar.View as View
import Sidebar.Types as Types
import Sidebar.State as State

-- Types

type alias Msg = Types.Msg
type alias Model = Types.Model

-- State

initialModel : Flags -> Model
initialModel = State.initialModel

update : Msg -> Model -> ( Model, Cmd Msg )
update = State.update

-- subscriptions : Sub Msg
-- subscriptions = State.subscriptions

-- View

view : Model -> Html Msg
view = View.view
