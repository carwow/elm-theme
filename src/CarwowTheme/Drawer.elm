module CarwowTheme.Drawer exposing (Model, Properties, Msg(Toggle), Action(Close, Open), init, view, subscriptions, update, State(Opened))

{-| Drawer


# Exports

@docs Model, Properties, Msg, init, view, subscriptions, update, Action, State

-}

import Keyboard
import CarwowTheme.Icons exposing (icon)
import Html exposing (Html, div, input, label, text)
import Html.Attributes exposing (class, style, for, type_, id, name, checked, attribute, property)
import Html.Events exposing (onClick)


{-| Placeholder
-}
type alias Model =
    { id : String
    , state : State
    }


{-| Placeholder
-}
type State
    = Opened
    | Closed


{-| Placeholder
-}
type Action
    = Open
    | Close


{-| Placeholder
-}
type alias Properties msg =
    { body : Html msg
    , title : String
    }


{-| Placeholder
-}
type Msg
    = KeyPressed Keyboard.KeyCode
    | Toggle Action


{-| Placeholder
-}
init : String -> Model
init id =
    { id = id
    , state = Closed
    }


{-| Placeholder
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPressed 27 ->
            ( { model | state = Closed }, Cmd.none )

        KeyPressed _ ->
            ( model, Cmd.none )

        Toggle Open ->
            ( { model | state = Opened }, Cmd.none )

        Toggle Close ->
            ( { model | state = Closed }, Cmd.none )


{-| Placeholder
-}
view : Model -> Properties msg -> msg -> msg -> Html msg -> Html msg
view model properties toggleOpenMsg toggleCloseMsg loadMoreButton =
    let
        closeButton =
            label
                [ class "modal__header-button modal__close-icon"
                , style [ ( "cursor", "pointer" ) ]
                , for (model.id ++ "-close")
                ]
                [ icon "close_b" { size = "small", colour = "dark-grey", colouring = "outline" } ]
    in
        div []
            [ input
                [ class "modal-radio-button--open"
                , type_ "radio"
                , id (model.id ++ "-open")
                , name model.id
                , checked (model.state == Opened)
                , onClick toggleOpenMsg
                , Html.Attributes.attribute "data-open-modal-input" "true"
                , Html.Attributes.attribute "data-modal-body-no-scroll" "true"
                ]
                []
            , input
                [ class "modal-radio-button--close"
                , type_ "radio"
                , id (model.id ++ "-close")
                , name model.id
                , onClick toggleCloseMsg
                , Html.Attributes.attribute "data-close-modal-input" "true"
                ]
                []
            , div
                [ class "modal-overlay notification-drawer-overlay"
                , id model.id
                ]
                [ label
                    [ class "modal-overlay__cancel"
                    , for (model.id ++ "-close")
                    ]
                    []
                , div [ class "notification-drawer" ]
                    [ div
                        [ class "modal__header modal__header--with-border notification-drawer__header"
                        ]
                        [ div [ class "modal__title" ]
                            [ text properties.title ]
                        , closeButton
                        ]
                    , div
                        [ class "notification-drawer__body"
                        , Html.Attributes.attribute "data-modal-content-body" "true"
                        ]
                        [ properties.body
                        , loadMoreButton
                        ]
                    ]
                ]
            ]


{-| Placeholder
-}
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Keyboard.downs KeyPressed
        ]
