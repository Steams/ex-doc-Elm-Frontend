module Main exposing (..)

import Html exposing (..)

import Globals exposing (Flags)
import Sidebar as Sidebar exposing (..)


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL

type alias Model =
    {
         sidebarNodes : Flags
       , sidebarModel : Sidebar.Model
    }

init : Flags -> ( Model, Cmd Msg )
init flags =
    (
     {
        sidebarNodes = flags
       ,sidebarModel = Sidebar.initialModel flags
     }
     , Cmd.none
    )

-- MESSAGES

type Msg
    = NoOp
    | SidebarMsg Sidebar.Msg


-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
        SidebarMsg sub ->
            let
                (sidebar,subMsg) =
                    Sidebar.update sub model.sidebarModel
            in
            ( {model | sidebarModel = sidebar}
            , Cmd.map SidebarMsg subMsg )


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    Html.map SidebarMsg <| Sidebar.view model.sidebarModel
