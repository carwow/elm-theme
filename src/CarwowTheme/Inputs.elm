module CarwowTheme.Inputs exposing (checkbox, select, option)

{-| Helpers for user input elements.


# Checkbox

@docs checkbox


# Select

@docs select


# Option

@docs option

-}

import Html exposing (Html, input, label, text, div, select)
import Html.Attributes exposing (id, type_, class, for)
import Html.Events exposing (onCheck, onInput, targetValue)
import Json.Decode exposing (float, map, map2, succeed)


{-| Checbox atom
-}
checkbox :
    String
    -> List (Html.Html msg)
    -> Bool
    -> (Bool -> msg)
    -> List (Html.Html msg)
checkbox id label value msg =
    [ Html.input
        [ Html.Attributes.id id
        , Html.Attributes.type_ "checkbox"
        , Html.Events.onCheck msg
        , Html.Attributes.checked value
        ]
        []
    , Html.label [ Html.Attributes.for id ]
        label
    ]


{-| Select atom
-}
select :
    String
    -> List (Html.Html msgType)
    -> String
    -> (String -> msgType)
    -> Bool
    -> Html.Html msgType
select id options value msg isDisabled =
    Html.div [ Html.Attributes.class "select" ]
        [ Html.select
            [ Html.Attributes.id id
            , Html.Attributes.value value
            , onChange msg
            , disabled isDisabled
            ]
            options
        ]


{-| Option atom
-}
option : String -> String -> Html.Html msg
option value text =
    Html.option [ Html.Attributes.value value ] [ Html.text text ]


onChange : (String -> value) -> Html.Attribute value
onChange tagger =
    Html.Events.on "change" (map tagger Html.Events.targetValue)
