module CarwowTheme.EmptyState exposing (emptyState)

{-| EmptyState


# Exports

@docs emptyState

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)


{-| Placeholder
-}
emptyState : String -> String -> Html msg -> Html msg
emptyState title description emptyStateIcon =
    div [ Html.Attributes.class "empty-state empty-state--full-width" ]
        [ div [ Html.Attributes.class "empty-state__confetti" ]
            [ Svg.svg [ Svg.Attributes.class "empty-state__confetti-image", viewBox "0 0 181 68", attribute "xmlns" "http://www.w3.org/2000/svg" ]
                [ g [ fill "none", attribute "fill-rule" "evenodd" ]
                    [ Svg.path [ d "M163.8 18.4c0-3.5-3-6.4-6.4-6.4-3.5 0-6.4 3-6.4 6.4 0 3.5 3 6.4 6.4 6.4 3.5 0 6.3-3 6.3-6.4zm-11 0c0-2.5 2-4.6 4.6-4.6 2.5 0 4.5 2 4.5 4.6 0 2.5-2 4.5-4.6 4.5-2.5 0-4.6-2-4.6-4.6zM27 62c0-2.8-2.2-5-5-5s-5 2.2-5 5 2.2 5 5 5 5-2.2 5-5zm-8.6 0c0-2 1.6-3.6 3.6-3.6s3.6 1.6 3.6 3.6-1.6 3.6-3.6 3.6-3.6-1.6-3.6-3.6z", fill "#00A4FF", attribute "fill-rule" "nonzero", attribute "stroke" "#00A4FF" ]
                        []
                    , Svg.text ""
                    , Svg.path [ d "M8 44.5c0-2-1.6-3.5-3.5-3.5-2 0-3.5 1.6-3.5 3.5 0 2 1.6 3.5 3.5 3.5 2 0 3.5-1.6 3.5-3.5zm-6 0C2 43 3 42 4.5 42 6 42 7 43 7 44.5 7 46 6 47 4.5 47 3 47 2 46 2 44.5z", fill "#666B76", attribute "fill-rule" "nonzero", attribute "stroke" "#666B76" ]
                        []
                    , Svg.text ""
                    , Svg.path [ d "M177.5 2.4L175.8.7c-.3-.3-.8-.3-1 0-.4.3-.4.8 0 1l1.6 1.8-1.7 1.6c-.3.4-.3 1 0 1.2.3.3.8.3 1 0l1.8-1.6 1.6 1.6c.4.3 1 .3 1.2 0 .3-.3.3-.8 0-1l-1.6-1.7 1.6-1.7c.3-.3.3-.8 0-1-.3-.4-.8-.4-1 0l-1.7 1.6z", fill "#666B76", attribute "stroke" "#666B76" ]
                        []
                    , Svg.text ""
                    , Svg.path [ d "M25 26H23c-.4 0-.8.4-.8 1 0 .3.3.6.8.6H25V30c0 .4.4.7 1 .7.3 0 .6-.3.6-.7v-2.4H29c.4 0 .7-.3.7-.7 0-.6-.3-1-.7-1h-2.4V24c0-.4-.3-.8-.7-.8-.6 0-1 .3-1 .8V26zM171 35h-1.5c-.3 0-.5 0-.5.4 0 .2.2.4.5.4h1.4v1.5c0 .2 0 .4.4.4.2 0 .4-.2.4-.4v-1.5h1.5c.2 0 .4-.2.4-.4 0-.3-.2-.5-.4-.5h-1.5v-1.5c0-.3-.2-.5-.4-.5-.3 0-.5.2-.5.5V35z", fill "#00A4FF", attribute "stroke" "#00A4FF" ]
                        []
                    , Svg.text ""
                    ]
                ]
            ]
        , div [ Html.Attributes.class "empty-state__icon-container" ]
            [ emptyStateIcon
            ]
        , h5 [ Html.Attributes.class "empty-state__title" ]
            [ Html.text title ]
        , p [ Html.Attributes.class "empty-state__text" ]
            [ Html.text description ]
        ]
