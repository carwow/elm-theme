module CarwowTheme.Modal exposing (ModalProperties, Model, Msg, PaddingStyle, init, linkView, subscriptions, update, view)

{-| Displays modal window


# Exported

@docs ModalProperties, Model, Msg, PaddingStyle, init, linkView, subscriptions, update, view

-}

import Keyboard
import CarwowTheme.Icons exposing (icon)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import CarwowTheme.ModalPorts exposing (fixScroll)


{-| Placeholder
-}
type alias Model =
    { id : String
    , isOpen : Bool
    }


{-| Placeholder
-}
type alias ModalProperties msg =
    { body : Html msg
    , title : String
    , paddingStyle : PaddingStyle
    , footer : Maybe (Html msg)
    , secondaryAction : Maybe (Html msg)
    }


{-| Placeholder
-}
type PaddingStyle
    = NoPadding
    | DefaultPadding


{-| Placeholder
-}
type Msg
    = SwitchModal Bool
    | KeyPressed Keyboard.KeyCode


{-| Placeholder
-}
init : String -> Model
init id =
    { id = id
    , isOpen = False
    }


{-| Placeholder
-}
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyPressed code ->
            let
                nextIsOpen =
                    case code of
                        27 ->
                            False

                        _ ->
                            model.isOpen
            in
                ( { model | isOpen = nextIsOpen }, Cmd.none )

        SwitchModal isOpen ->
            ( { model | isOpen = isOpen }, fixScroll isOpen )


{-| Placeholder
-}
linkView : Model -> List (Html msg) -> String -> Html msg
linkView model content classes =
    label
        [ for (model.id ++ "-open"), class classes ]
        content


{-| Placeholder
-}
view : Model -> msg -> msg -> ModalProperties msg -> Html msg
view model openModalEvent closeModalEvent properties =
    let
        closeButton =
            label
                [ Html.Attributes.class "modal__header-button modal__close-icon"
                , Html.Attributes.style [ ( "cursor", "pointer" ) ]
                , Html.Attributes.for (model.id ++ "-close")
                ]
                [ icon "close_b" { size = "small", colour = "dark-grey", colouring = "outline" } ]

        footer =
            case properties.footer of
                Just content ->
                    div [ class "modal__footer" ] [ content ]

                Nothing ->
                    Html.text ""
    in
        div []
            [ input
                [ Html.Attributes.class "modal-radio-button--open"
                , Html.Attributes.type_ "radio"
                , id (model.id ++ "-open")
                , name "modal-make-model-selector"
                , checked model.isOpen
                , onClick openModalEvent
                ]
                []
            , input
                [ Html.Attributes.class "modal-radio-button--close"
                , Html.Attributes.type_ "radio"
                , id (model.id ++ "-close")
                , name "modal-make-model-selector"
                , onClick closeModalEvent
                ]
                []
            , div [ Html.Attributes.class "modal-overlay", id "modal-make-model-selector" ]
                [ label
                    [ Html.Attributes.class "modal-overlay__cancel"
                    , Html.Attributes.for (model.id ++ "-close")
                    ]
                    []
                , div [ Html.Attributes.class "modal" ]
                    [ div [ Html.Attributes.class "modal__header modal__header--with-border" ]
                        [ Maybe.withDefault (Html.text "") properties.secondaryAction
                        , div [ Html.Attributes.class "modal__title modal__title--centered" ]
                            [ text properties.title ]
                        , closeButton
                        ]
                    , div
                        [ Html.Attributes.classList
                            [ ( "modal__body", True )
                            , ( "modal__body--no-padding", properties.paddingStyle == NoPadding )
                            ]
                        ]
                        [ properties.body ]
                    , footer
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
