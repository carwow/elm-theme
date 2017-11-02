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
import Html.Attributes exposing (id, type_, class, for, disabled)
import Html.Events exposing (onCheck, onInput, targetValue)
import Json.Decode exposing (float, map, map2, succeed)


{-| Checkbox atom
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
    List (Html.Html msgType)
    -> String
    -> String
    -> List (Html.Attribute msgType)
    -> (String -> msgType)
    -> Html.Html msgType
select options value id attributes msg =
    Html.div [ Html.Attributes.class "select" ]
        [ Html.select
            (onChange msg :: Html.Attributes.value value :: Html.Attributes.id id :: attributes)
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
