module CarwowTheme.Drawer exposing (Model, Properties, Msg(Toggle), init, view, subscriptions, update)

{-| Drawer


# Exports

@docs Model, Properties, Msg, init, view, subscriptions, update

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
    , open : Bool
    }


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
    | Toggle Bool


{-| Placeholder
-}
init : String -> Model
init id =
    { id = id
    , open = False
    }


{-| Placeholder
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPressed code ->
            let
                open =
                    case code of
                        27 ->
                            False

                        _ ->
                            model.open
            in
                ( { model | open = open }, Cmd.none )

        Toggle open ->
            ( { model | open = open }, Cmd.none )


{-| Placeholder
-}
view : Model -> Properties msg -> msg -> msg -> Html msg
view model properties toggleOpenMsg toggleCloseMsg =
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
                , checked model.open
                , onClick toggleOpenMsg
                ]
                []
            , input
                [ class "modal-radio-button--close"
                , type_ "radio"
                , id (model.id ++ "-close")
                , name model.id
                , onClick toggleCloseMsg
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
                        ]
                        [ properties.body ]
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
