module Sidebar.View exposing (view)

import Html exposing (Attribute, Html, button, div, text, program, ul, li, img, span, a, h1, h2, i, input, section)
import Html.Attributes exposing (class, classList, src, height, width, href,type_, placeholder, autocomplete,id, style)
import Html.Events exposing (onClick)

import Globals exposing (..)
import Sidebar.Types exposing (..)



sidebar_fullList : Model -> Html Msg
sidebar_fullList model =
    ul [id "full-list", class "sidebar-fullList"] []

sidebar_list_item : Category -> Html Msg -> (Category -> Html Msg)
sidebar_list_item category content =
    let
        status : Category -> String
        status selected =
            if selected == category then
                "selected"
            else
                ""
    in
        \selectedCategory ->
            li [class <| status selectedCategory, onClick <| SelectCategory category]
                [
                 content
                ]

sidebar_listNav : Model -> Html Msg
sidebar_listNav model =
    let
        category = model.selectedCategory

        extras_list_link =
            a [ id "extras-list", href "#full-list"] [text "Pages"]

        modules_list_link : List Module -> Html Msg
        modules_list_link modules =
            case modules of
                [] ->
                    text ""

                _  ->
                    a [ id "modules-list", href "#full-list"] [ text "Modules" ]

        exceptions_list_link : List Exception -> Html Msg
        exceptions_list_link exceptions =
            case exceptions of
                [] ->
                    text ""

                _  ->
                    a [ id "exceptions-list", href "#full-list"] [ text "Exceptions" ]

        protocols_list_link : List Protocol -> Html Msg
        protocols_list_link protocols =
            case protocols of
                [] ->
                    text ""

                _  ->
                    a [ id "protocols-list", href "#full-list"] [ text "Protocols" ]
    in
        ul [class "sidebar-listNav"]
            [
                category |> sidebar_list_item EXTRAS extras_list_link

              , category |> sidebar_list_item MODULES (modules_list_link model.modules)

              , category |> sidebar_list_item EXCEPTIONS (exceptions_list_link model.exceptions)

              , category |> sidebar_list_item PROTOCOLS (protocols_list_link model.protocols)
            ]

sidebar_search : Html Msg
sidebar_search =
    div [ class "sidebar-search" ]
        [
          i [class "icon-search"] []
         ,input [ type_ "text", class "sidebar-searchInput", placeholder "search", autocomplete False] []
        ]

sidebar_header : Html Msg
sidebar_header =
    a [href "insert url from model here", class "sidebar-projectLink"]
        [
         div [class "sidebar-projectDetails"]
             [
                h1 [class "sidebar-projectName"] [text "Project Name"]
              , h2 [class "sidebar-projectVersion"] [text "todo: find out how to add header info to generated json."]
             ]
        ]
    -- TODO add back in logo 
    -- <%= if config.logo do %>
    --   <img src="<%= logo_path(config) %>" alt="<%= config.project %>" class="sidebar-projectImage">
    -- <% end %>

sidebar_content : Model -> Html Msg
sidebar_content model =
    section [ class "content" ]
        [
          div [class "content-outer"]
              [
               div [ id "content", class "content-inner"] []
              ]
        ]

sidebar_top : Model -> Html Msg
sidebar_top model =
    section [class "sidebar"]
        [
          sidebar_header
         ,sidebar_search
         ,sidebar_listNav model
         , div [ class "gradient"] []
         , sidebar_fullList model
        ]

sidebar_toggle_style : Bool -> Attribute Msg
sidebar_toggle_style isOpen =
    case isOpen of
        True ->
            style
            [
             ("transform","translateX(250px)")
            ]
        False ->
            style
            [
             ("transform","translateX(0px)")
            ]

sidebar_toggle : Bool -> Html Msg
sidebar_toggle isOpen =
    button [ class "sidebar-toggle", onClick ToggleSidebar, sidebar_toggle_style isOpen ]
        [
         i [class "icon-menu"] []
        ]

view : Model -> Html Msg
view model =
    let top = if model.isOpen
              then sidebar_top model
              else div [][]
    in
        div [class "main"]
            [
             sidebar_toggle model.isOpen
            ,top
            ,sidebar_content model
            ]
