module CarwowTheme.Filters exposing (select, filterView, standardFilterView, FilterGroupItem, filterGroup, TooltipAlignment(..), FilterDescriptionDisplay(..))

{-| Filters


# Exports

@docs select, filterView, standardFilterView, FilterGroupItem, filterGroup

-}

import CarwowTheme.Icons exposing (icon)
import CarwowTheme.Inputs exposing (select)
import Html exposing (div, span, text, ul, li, a)
import Html.Attributes exposing (class, attribute, href, id, property)
import Html.Events exposing (onCheck)
import Json.Encode

{-| Placeholder
-}
type alias FilterGroupItem msg =
    { filterId : String
    , filterLabel : String
    , filterValue : Bool
    , filterDescription : Maybe String
    , message : Bool -> msg
    }

type TooltipAlignment = Bottom |
                        BottomLeft |
                        BottomRight |
                        Left |
                        Right |
                        Top |
                        TopLeft |
                        TopRight

type FilterDescriptionDisplay = Inline | Expandable

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
filterGroupItem : FilterGroupItem msg -> String -> String -> FilterDescriptionDisplay -> Html.Html msg
filterGroupItem item groupLabel filterPrefix inlineOrExpandable =
    let
        checkbox = (filterCheckboxFromItem item groupLabel)
    in
        case item.filterDescription of
            Nothing ->
                filterGroupItemBasic checkbox
            Just description ->
                case inlineOrExpandable of
                    Inline ->
                        filterGroupItemInlineDescription checkbox description
                    Expandable ->
                        filterGroupItemWithExpander checkbox description item.filterId filterPrefix

{-| Placeholder
-}
filterGroupItemBasic : List (Html.Html msg) -> Html.Html msg
filterGroupItemBasic checkbox =
    li [ class "filter__input" ]
        checkbox

{-| Placeholder
-}
filterGroupItemInlineDescription : List (Html.Html msg) -> String -> Html.Html msg
filterGroupItemInlineDescription checkbox description =
    let
        inlineDescription =
            div [ class "filter__description" ] [text description]
        children =
            List.append checkbox [inlineDescription]
    in
        li [ class "filter__input" ] children

{-| Placeholder
-}
filterGroupItemWithExpander : List (Html.Html msg) -> String -> String -> String -> Html.Html msg
filterGroupItemWithExpander checkbox description filterId filterPrefix =
    let
        expanderID =
            filterPrefix ++ "_" ++ filterId
    in
        li [ class "filter__input filter__with-description" ]
           [
           div [ class "filter-expandable__header" ]
               checkbox
           , a [
                   class "filter-expandable__link",
                   attribute "data-toggle" "expandable",
                   href ("#" ++ expanderID)
               ]
               [ icon "caret_down" { colour = "light-black", size = "x-small", colouring = "outline" } ]
           , div [
               class "hidden-content filter__description"
               , id expanderID
               , property "innerHTML" (Json.Encode.string description)
               ]
               []
           ]

filterCheckboxFromItem : FilterGroupItem msg -> String -> List (Html.Html msg)
filterCheckboxFromItem item groupLabel =
    (filterCheckbox
        item.filterId
        [ Html.span [ Html.Attributes.class "filter__input-label" ] [ Html.text item.filterLabel ] ]
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
filterGroup : List (FilterGroupItem msg) -> String -> String -> FilterDescriptionDisplay -> List (Html.Html msg)
filterGroup items label filterPrefix descriptionDisplay =
    List.map (\item -> filterGroupItem item label filterPrefix descriptionDisplay) items

{-| Placeholder
-}
standardFilterView : String -> String -> List (FilterGroupItem msg) -> TooltipAlignment -> Html.Html msg
standardFilterView label selectedIcon items alignment =
    let
        itemsCount =
            List.length items

        content =
            filterGroup items label "" Inline

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
            filterView label selectedFiltersLabel selectedIcon content alignment Inline
        else
            text ""

{-| Placeholder
-}
alignmentClass : TooltipAlignment -> String
alignmentClass alignment =
    case alignment of
        Left ->
            "left"
        Right ->
            "right"
        Top ->
            "top"
        Bottom ->
            "bottom"
        TopLeft ->
            "top-left"
        TopRight ->
            "top-right"
        BottomLeft ->
            "bottom-left"
        BottomRight ->
            "bottom-right"

{-| Placeholder
-}
filterView : String -> String -> String -> List (Html.Html msg) -> TooltipAlignment -> FilterDescriptionDisplay -> Html.Html msg
filterView label selectedFiltersLabel filterIcon content alignment filterDescriptionDisplay =
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
                [ class ("tooltip-dropdown tooltip-dropdown--" ++ (alignmentClass alignment)) ]
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
