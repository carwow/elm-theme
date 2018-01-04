module CarwowTheme.Inputs exposing (checkbox, select, selectSettings, disableSelect, setSelectedOption)

{-| Helpers for user input elements.


# Checkbox

@docs checkbox


# Select

@docs selectSettings

@docs select

@docs setSelectedOption

@docs disableSelect

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
type alias SelectSettings msg =
    { id : String
    , options : List ( String, String )
    , selectedOption : Maybe String
    , disabled : Bool
    , onChange : String -> msg
    }


{-| Required select settings: id, possible options, onchange message
-}
selectSettings : String -> List ( String, String ) -> (String -> msg) -> SelectSettings msg
selectSettings id options msg =
    { id = id
    , options = options
    , onChange = msg
    , selectedOption = Nothing
    , disabled = False
    }


{-| Disable a select
-}
disableSelect : SelectSettings msg -> SelectSettings msg
disableSelect settings =
    { settings | disabled = True }


{-| Define the selected option for the select
-}
setSelectedOption : String -> SelectSettings msg -> SelectSettings msg
setSelectedOption option settings =
    { settings | selectedOption = Just option }


{-| Render a select
-}
select : SelectSettings msg -> Html.Html msg
select settings =
    let
        selected : String -> Maybe String -> Bool
        selected name selectedName =
            selectedName == Just name

        makeOption : Maybe String -> ( String, String ) -> Html.Html msg
        makeOption selectedName ( name, label ) =
            Html.option
                [ Html.Attributes.value name
                , Html.Attributes.selected (selected name selectedName)
                ]
                [ Html.text label ]

        options =
            List.map (makeOption settings.selectedOption) settings.options
    in
        Html.div [ Html.Attributes.class "select" ]
            [ Html.select
                [ Html.Attributes.id settings.id
                , Html.Events.on "change" (map settings.onChange Html.Events.targetValue)
                , disabled settings.disabled
                ]
                options
            ]
