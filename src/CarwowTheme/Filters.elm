module CarwowTheme.Filters exposing (select, filterView, standardFilterView, FilterGroupItem, filterGroup, filterGroupWithExpander)

{-| Filters


# Exports

@docs select, filterView, standardFilterView, FilterGroupItem, filterGroup, filterGroupWithExpander

-}

import CarwowTheme.Icons exposing (icon)
import CarwowTheme.Inputs exposing (select)
import CarwowTheme.Expanders exposing (expander)
import Html exposing (div, span, text, ul, li)
import Html.Attributes exposing (class)
import Html.Events exposing (onCheck)

{-| Placeholder
-}
type alias FilterGroupItem msg =
    { filterId : String
    , filterLabel : String
    , filterValue : Bool
    , filterDescription : String
    , message : Bool -> msg
    }


{-| Placeholder
-}
select :
    String
    -> String
    -> String
    -> List ( String, String )
    -> String
    -> (String -> value)
    -> List (Html.Html value)
select id label help_message options value msg =
    let
        selectSettings =
            CarwowTheme.Inputs.selectSettings id options msg
                |> CarwowTheme.Inputs.setSelectedOption value
    in
        [ Html.div []
            [ Html.div []
                [ Html.label [ Html.Attributes.for id, Html.Attributes.class "form-input-label" ] [ Html.text label ]
                , Html.a [ Html.Attributes.href "javascript:;", Html.Attributes.class "tooltip tooltip--no-border tooltip--helper-icon" ]
                    [ Html.div [ Html.Attributes.class "tooltip__label" ]
                        [ Html.div [ Html.Attributes.class "tooltip--helper-icon__container" ]
                            [ icon "question_mark" { size = "x-small", colour = "white", colouring = "outline" }
                            ]
                        ]
                    , Html.div [ Html.Attributes.class "tooltip-dropdown tooltip-dropdown--bottom" ]
                        [ Html.div [ Html.Attributes.class "tooltip-dropdown__arrow" ] []
                        , Html.div [ Html.Attributes.class "tooltip-dropdown__content" ] [ Html.text help_message ]
                        ]
                    ]
                ]
            , CarwowTheme.Inputs.select selectSettings
            ]
        ]


{-| Placeholder
-}
filterGroupItem : FilterGroupItem msg -> String -> String -> Html.Html msg
filterGroupItem item groupLabel filterPrefix =
    let
        checkboxes = (filterCheckboxFromItem item groupLabel)
        description = div [ class "filter__description" ] [text item.filterDescription]
        content = List.concat [ checkboxes, [description] ]
    in
        li [ class "filter__input" ]
            content

filterGroupItemWithExpander : FilterGroupItem msg -> String -> String -> Html.Html msg
filterGroupItemWithExpander item groupLabel filterPrefix =
    let
        header
            = filterCheckboxFromItem item groupLabel
        body
            = item.filterDescription
        expanderID =
            filterPrefix ++ "_" ++ item.filterId
        expanderHtml
            = expander header body expanderID
    in
        li [ class "filter__input filter__with_description" ]
           [ expanderHtml ]

filterCheckboxFromItem : FilterGroupItem msg -> String -> List (Html.Html msg)
filterCheckboxFromItem item groupLabel =
    (filterCheckbox
        item.filterId
        [ Html.span [ Html.Attributes.class "filtser__input-label" ] [ Html.text item.filterLabel ] ]
        item.filterValue
        item.message
        (filterColoured item.filterLabel (String.toLower groupLabel))
    )


filterColoured : String -> String -> String
filterColoured filterLabel groupLabel =
    (if groupLabel == "colour" then
        "input-checkbox-coloured input-checkbox-coloured--" ++ (String.toLower filterLabel)
     else
        ""
    )


{-| Placeholder
-}
filterCheckbox :
    String
    -> List (Html.Html msg)
    -> Bool
    -> (Bool -> msg)
    -> String
    -> List (Html.Html msg)
filterCheckbox id label value msg class =
    [ Html.input
        [ Html.Attributes.id id
        , Html.Attributes.type_ "checkbox"
        , Html.Events.onCheck msg
        , Html.Attributes.checked value
        , Html.Attributes.class class
        ]
        []
    , Html.label [ Html.Attributes.for id ]
        label
    ]


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
filterGroup : List (FilterGroupItem msg) -> String -> String -> List (Html.Html msg)
filterGroup items label filterPrefix =
    List.map (\item -> filterGroupItem item label filterPrefix) items

filterGroupWithExpander : List (FilterGroupItem msg) -> String -> String -> List (Html.Html msg)
filterGroupWithExpander items label filterPrefix =
    List.map (\item -> filterGroupItemWithExpander item label filterPrefix) items

{-| Placeholder
-}
standardFilterView : String -> String -> List (FilterGroupItem msg) -> Html.Html msg
standardFilterView label selectedIcon items =
    let
        itemsCount =
            List.length items

        content =
            filterGroup items label ""

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
filterView label selectedFiltersLabel filterIcon content =
    li [ class "filter" ]
        [ div
            [ class "filter__tooltip tooltip tooltip--no-border" ]
            [ div [ class "tooltip__label" ]
                [ div [ class "filter__icon" ]
                    [ icon filterIcon { size = "small", colour = "dark-grey", colouring = "outline" }
                    ]
                , div []
                    [ div [ class "filter__label" ]
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
