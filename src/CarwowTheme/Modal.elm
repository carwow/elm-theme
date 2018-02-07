module CarwowTheme.Modal exposing (ModalProperties, Model, Msg(SwitchModal), PaddingStyle(NoPadding, DefaultPadding), init, linkView, subscriptions, update, view)

{-| Displays modal window


# Exported

@docs ModalProperties, Model, Msg, PaddingStyle, init, linkView, subscriptions, update, view

-}

import Keyboard
import CarwowTheme.Icons exposing (icon)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


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
    , title : Maybe (Html msg)
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
init : String -> Bool -> Model
init id isOpen =
    { id = id
    , isOpen = isOpen
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
            ( { model | isOpen = isOpen }, Cmd.none )


{-| Placeholder
-}
linkView : Model -> List (Html msg) -> String -> String -> Html msg
linkView model content classes interactionDataAttribute =
    label
        [ for (model.id ++ "-open"), attribute "data-interaction-type" "open modal", attribute "data-interaction" interactionDataAttribute, class classes ]
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
                [ icon "close_b" { size = "small", colour = "black", colouring = "outline" } ]

        title =
            case properties.title of
                Just content ->
                    div [ Html.Attributes.class "modal__title modal__title--centered" ]
                        [ content ]

                Nothing ->
                    Html.text ""

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
                , Html.Attributes.attribute "data-modal-input" "true"
                , Html.Attributes.attribute "data-open-modal-input" "true"
                , Html.Attributes.attribute "data-modal-body-no-scroll" "true"
                ]
                []
            , input
                [ Html.Attributes.class "modal-radio-button--close"
                , Html.Attributes.type_ "radio"
                , id (model.id ++ "-close")
                , name "modal-make-model-selector"
                , onClick closeModalEvent
                , Html.Attributes.attribute "data-modal-input" "true"
                , Html.Attributes.attribute "data-close-modal-input" "true"
                ]
                []
            , div
                [ Html.Attributes.class "modal-overlay"
                , id "modal-make-model-selector"
                , attribute "data-close-on-esc" "true"
                ]
                [ label
                    [ Html.Attributes.class "modal-overlay__cancel"
                    , Html.Attributes.for (model.id ++ "-close")
                    ]
                    []
                , div [ Html.Attributes.class "modal" ]
                    [ div [ Html.Attributes.class "modal__header modal__header--with-border" ]
                        [ Maybe.withDefault (Html.text "") properties.secondaryAction
                        , title
                        , closeButton
                        ]
                    , div
                        [ Html.Attributes.classList
                            [ ( "modal__body", True )
                            , ( "modal__body--no-padding", properties.paddingStyle == NoPadding )
                            ]
                        , Html.Attributes.attribute "data-modal-content-body" "true"
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
