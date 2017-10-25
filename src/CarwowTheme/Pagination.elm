module CarwowTheme.Pagination exposing (PaginationProperties, view)

{-| Filters


# Exports

@docs PaginationProperties, view

-}

import Html exposing (Html, a, div, text)
import Html.Attributes exposing (class, classList, href)
import Html.Events exposing (onClick)
import CarwowTheme.Icons exposing (icon)
import List.Extra exposing (group)


{-| Properties for the pagination component
-}
type alias PaginationProperties =
    { totalCount : Int
    , totalPages : Int
    , perPage : Int
    , currentPage : Int
    }


type Page
    = Maybe Int


linkView : Int -> Html msg -> (Int -> msg) -> PaginationProperties -> Html msg
linkView page content clickMsg pagination =
    div
        [ classList
            [ ( "pagination__page ", True )
            , ( "pagination__page--active", pagination.currentPage == page )
            ]
        ]
        [ a
            [ href "javascript:;"
            , onClick (clickMsg page)
            ]
            [ content ]
        ]


emptyLinkView : Html msg
emptyLinkView =
    div [ class "pagination__page" ]
        [ text "…"
        ]


prevLink : PaginationProperties -> (Int -> msg) -> Html msg
prevLink pagination clickMsg =
    if pagination.currentPage > 1 then
        linkView
            (pagination.currentPage - 1)
            (icon "caret_left" { size = "x-small", colour = "dark-grey", colouring = "outline" })
            clickMsg
            pagination
    else
        text ""


pageLinks : PaginationProperties -> (Int -> msg) -> List (Html msg)
pageLinks pagination clickMsg =
    let
        allPages =
            List.range 1 pagination.totalPages

        middlePages =
            List.map
                (\page ->
                    if abs (page - pagination.currentPage) < 2 then
                        Just page
                    else
                        Nothing
                )
                allPages

        middleAndLimitPages =
            List.concat [ [ Just 1 ], middlePages, [ Just pagination.totalPages ] ]

        pages =
            middleAndLimitPages |> List.Extra.group |> List.map (List.take 1) |> List.concat
    in
        List.map
            (\page ->
                case page of
                    Nothing ->
                        emptyLinkView

                    Just pageNum ->
                        linkView pageNum (text (toString pageNum)) clickMsg pagination
            )
            pages


nextLink : PaginationProperties -> (Int -> msg) -> Html msg
nextLink pagination clickMsg =
    if pagination.currentPage < pagination.totalPages then
        linkView
            (pagination.currentPage + 1)
            (icon "caret_right" { size = "x-small", colour = "dark-grey", colouring = "outline" })
            clickMsg
            pagination
    else
        text ""


{-| Helper to render the component
-}
view : PaginationProperties -> (Int -> msg) -> Html msg
view pagination clickMsg =
    let
        links =
            List.concat
                [ [ prevLink pagination clickMsg ]
                , pageLinks pagination clickMsg
                , [ nextLink pagination clickMsg ]
                ]
    in
        div [ class "pagination" ] links
