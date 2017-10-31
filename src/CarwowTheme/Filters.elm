module CarwowTheme.Filters exposing (select, filterView, standardFilterView, FilterGroupItem, filterGroup)

{-| Filters


# Exports

@docs select, filterView, standardFilterView, FilterGroupItem, filterGroup

-}

import CarwowTheme.Icons exposing (icon)
import CarwowTheme.Inputs exposing (checkbox, select)
import Html exposing (div, span, text, ul, li)
import Html.Attributes exposing (class)


{-| Placeholder
-}
select :
    String
    -> String
    -> String
    -> List (Html.Html value)
    -> String
    -> (String -> value)
    -> List (Html.Html value)
select id label help_message options value msg =
    [ Html.div []
        [ Html.div [ Html.Attributes.class "lease-contract-filters__filter-label" ]
            [ Html.label [ Html.Attributes.for id, Html.Attributes.class "form-input-label" ] [ Html.text label ]
            , Html.a [ Html.Attributes.href "javascript:;", Html.Attributes.class "tooltip tooltip--no-border" ]
                [ Html.div [ Html.Attributes.class "tooltip__label" ] [ icon "help" { size = "x-small", colour = "grey", colouring = "filled" } ]
                , Html.div [ Html.Attributes.class "tooltip-dropdown tooltip-dropdown--bottom" ]
                    [ Html.div [ Html.Attributes.class "tooltip-dropdown__arrow" ] []
                    , Html.div [ Html.Attributes.class "tooltip-dropdown__content" ] [ Html.text help_message ]
                    ]
                ]
            ]
        , CarwowTheme.Inputs.select id options value msg
        ]
    ]


{-| Placeholder
-}
type alias FilterGroupItem msg =
    { filterId : String
    , filterLabel : String
    , filterValue : Bool
    , message : Bool -> msg
    }


{-| Placeholder
-}
filterGroupItem : FilterGroupItem msg -> Html.Html msg
filterGroupItem item =
    li [ class "filter__input" ]
        (CarwowTheme.Inputs.checkbox
            item.filterId
            [ Html.span [ Html.Attributes.class "filter__input-label" ] [ Html.text item.filterLabel ] ]
            item.filterValue
            item.message
        )


{-| Placeholder
-}
isFilterGroupItemSelected : FilterGroupItem msg -> Bool
isFilterGroupItemSelected item =
    item.filterValue


{-| Placeholder
-}
getFilterGroupItemLabel : FilterGroupItem msg -> String
getFilterGroupItemLabel item =
    item.filterLabel


{-| Placeholder
-}
filterGroup : List (FilterGroupItem msg) -> List (Html.Html msg)
filterGroup items =
    List.map filterGroupItem items


{-| Placeholder
-}
standardFilterView : String -> String -> List (FilterGroupItem msg) ->  Html.Html msg
standardFilterView label selectedIcon items =
    let
        itemsCount =
            List.length items

        content =
            filterGroup items

        selectedFilters =
            List.filter isFilterGroupItemSelected items

        selectedFilterLabels =
            List.map getFilterGroupItemLabel selectedFilters

        selectedFilterCount =
            List.length selectedFilters

        firstSelectedFilter =
            case List.head selectedFilterLabels of
                Nothing ->
                    ""

                Just val ->
                    val

        selectedFiltersLabel =
            if selectedFilterCount > 1 then
                firstSelectedFilter ++ " and " ++ (toString (selectedFilterCount - 1)) ++ " more"
            else
                firstSelectedFilter
    in
        if itemsCount > 1 then
            filterView label selectedFiltersLabel selectedIcon content
        else
            text ""


{-| Placeholder
-}
filterView : String -> String -> String -> List (Html.Html msg) -> Html.Html msg
filterView label selectedFiltersLabel selectedIcon content =
    li [ class "filter" ]
        [ div
            [ class "filter__tooltip tooltip tooltip--no-border" ]
            [ div [ class "tooltip__label" ]
                [ div [ class "filter__icon" ]
                    [
                          icon selectedIcon { size = "small", colour = "dark-grey", colouring = "outline" }
                    ]
                    , div[]
                    [
                    div [ class "filter__label" ]
                        [ text label
                        , icon "caret_down" { size = "xx-small", colour = "dark-grey", colouring = "outline" }
                        ]
                        , div [ class "filter__current-selection" ] [ text selectedFiltersLabel ]
                    ]
                ]
            , div
                [ class "tooltip-dropdown tooltip-dropdown--bottom" ]
                [ div [ class "tooltip-dropdown__arrow" ]
                    []
                , div [ class "tooltip-dropdown__content" ]
                    [ div [ class "tooltip-dropdown__content" ]
                        [ ul [ class "filter-dropdown__inputs list-unstyled" ]
                        content
                        ]
                    ]
                ]
            ]
        ]
