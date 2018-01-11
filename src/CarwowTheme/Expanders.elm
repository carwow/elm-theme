module CarwowTheme.Expanders exposing (expander)

{-| Expanders

# Exports

@docs expander

-}

import Html exposing (div, span, text, ul, li, a, p)
import Html.Attributes exposing (class, attribute, href, id)

{-| Placeholder
-}
expander : List(Html.Html msg) -> String -> String -> Html.Html msg
expander header body expanderID =
    let
        elementID = "expandable-panel-" ++ expanderID
    in
        div []
            [ a [ class "expandable-link expandable-link--full-width expandable-link--arrow is-expanded", attribute "data-toggle" "expandable", href ("#" ++ elementID) ]
                 [ div [ class "expandable-link___icon-text" ]
                     header
                 ]
            , div [ class "hidden-content ", id elementID, attribute "style" "display: block;" ]
                [ text body ]
            ]

