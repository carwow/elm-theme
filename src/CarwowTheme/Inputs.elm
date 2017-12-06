module CarwowTheme.Inputs exposing (checkbox, select, selectWithAttributes, option)

{-| Helpers for user input elements.


# Checkbox

@docs checkbox


# Select

@docs select


# Select with Attributes

@docs selectWithAttributes


# Option

@docs option

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (float, map, map2, succeed)


{-| Checkbox atom
-}
checkbox :
    String
    -> List (Html msg)
    -> Bool
    -> (Bool -> msg)
    -> List (Html msg)
checkbox cbId cbLabel value msg =
    [ input
        [ id cbId
        , type_ "checkbox"
        , onCheck msg
        , checked value
        ]
        []
    , label [ for cbId ]
        cbLabel
    ]


{-| Select atom
-}
select :
    List (Html msgType)
    -> String
    -> String
    -> (String -> msgType)
    -> Html msgType
select options value id msg =
    selectWithAttributes options value id msg []


{-| Select atom with extra attributes
-}
selectWithAttributes :
    List (Html msgType)
    -> String
    -> String
    -> (String -> msgType)
    -> List (Attribute msgType)
    -> Html msgType
selectWithAttributes options selectValue selectId msg attributes =
    div [ class "select" ]
        [ Html.select
            (onChange msg :: value selectValue :: id selectId :: attributes)
            options
        ]


{-| Option atom
-}
option : String -> String -> Html msg
option optionValue optionText =
    Html.option [ value optionValue ] [ text optionText ]


onChange : (String -> value) -> Attribute value
onChange tagger =
    on "change" (Json.Decode.map tagger targetValue)
