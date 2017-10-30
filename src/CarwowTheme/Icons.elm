module CarwowTheme.Icons exposing (icon)

{-| Icons are displayed using the SVG spirte technique.


# Embed icon

@docs icon

-}

import Html exposing (Html)
import Svg exposing (svg, use)
import Svg.Attributes exposing (class, version, viewBox, xlinkHref)


type alias Properties =
    { colour : String, size : String, colouring : String }


{-| Embeds an icon from the SVG sprite, with the given properties.
-}
icon : String -> Properties -> Html.Html msg
icon iconName iconProperties =
    let
        colouringClass =
            " inline-icon--" ++ iconProperties.colouring

        colourClass =
            " inline-icon--" ++ iconProperties.colour

        sizeClass =
            " inline-icon--" ++ iconProperties.size
    in
        svg
            [ version "1.1"
            , class ("inline-icon" ++ colouringClass ++ sizeClass ++ colourClass)
            , viewBox "0 0 24 24"
            ]
            [ use [ xlinkHref ("#sprite_icon_" ++ iconName) ] []
            ]
