module CarwowTheme.Expanders exposing (expander)

{-| Expanders

# Exports

@docs expander

-}

import Html exposing (div, span, text, ul, li, a)
import Html.Attributes exposing (class, attribute, href, id, property)
import Json.Encode

{-| Placeholder
-}
expander : List(Html.Html msg) -> String -> String -> Html.Html msg
expander headerContent bodyContent expanderID =
    let
        elementID = "expandable-panel-" ++ expanderID
    in
        div []
            [ div [ class "expandable-link___icon-text" ]
                headerContent
            , a [ class "expandable-link expandable-link--full-width expandable-link--arrow", attribute "data-toggle" "expandable", href ("#" ++ elementID) ]
                [ text "" ]
            , div [
                class "hidden-content filter__description"
                , id elementID
                , attribute "style" "display: none;"
                , property "innerHTML" (Json.Encode.string bodyContent)
                ]
                []
            ]
