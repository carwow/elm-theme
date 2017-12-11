module CarwowTheme.ToolTips exposing (toolTip)

{-| ToolTips are displayed with provided messages


# Embed toolTip

@docs toolTip

-}

import Html exposing (Html)
import Html.Attributes exposing (class)
import CarwowTheme.Icons exposing (icon)


{-| Creates a tool tip with provided message
-}
toolTip : String -> Html.Html msg
toolTip helpMessage =
    Html.a [ Html.Attributes.href "javascript:;", Html.Attributes.class "tooltip tooltip--no-border tooltip--helper-icon" ]
        [ Html.div [ Html.Attributes.class "tooltip__label" ]
            [ Html.div [ Html.Attributes.class "tooltip--helper-icon__container" ]
                [ icon "question_mark" { size = "x-small", colour = "white", colouring = "outline" }
                ]
            ]
        , Html.div [ Html.Attributes.class "tooltip-dropdown tooltip-dropdown--bottom" ]
            [ Html.div [ Html.Attributes.class "tooltip-dropdown__arrow" ] []
            , Html.div [ Html.Attributes.class "tooltip-dropdown__content" ] [ Html.text helpMessage ]
            ]
        ]
