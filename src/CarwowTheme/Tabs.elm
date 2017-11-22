module CarwowTheme.Tabs
    exposing
        ( view
        , config
        , tabs
        , TabItem(TabItem)
        , getCurrentState
        , initialState
        , State
        )

{-| Tabs


# Exports

@docs view, config, tabs, TabItem, getCurrentState, initialState, State

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


{-| Placeholder
-}
type State
    = State
        { activeTab : String
        }


{-| Placeholder
-}
type Config msg
    = Config
        { toMsg : State -> msg
        , tabs : List (TabItem msg)
        }


{-| Placeholder
-}
type TabItem msg
    = TabItem
        { id : String
        , tabLabel : String
        , tabContent : Html.Html msg
        }


{-| Placeholder
-}
config : (State -> msg) -> Config msg
config toMsg =
    Config
        { toMsg = toMsg
        , tabs = []
        }


{-| Placeholder
-}
tabs : List (TabItem msg) -> Config msg -> Config msg
tabs tabs (Config config) =
    Config
        { config | tabs = tabs }


{-| Placeholder
-}
initialState : String -> State
initialState tabId =
    State
        { activeTab = tabId
        }


{-| Placeholder
-}
view : State -> Config msg -> Html.Html msg
view (State { activeTab }) ((Config { tabs }) as config) =
    div [ class "tabs-container" ]
        [ div [ class "tabs__navigation-container" ]
            [ nav [ class "tabs__navigation" ]
                [ ul [ class "list-unstyled tabs__navigation-list", attribute "role" "tablist" ]
                    (List.map
                        (\(TabItem { id, tabLabel }) -> tabNavView id tabLabel (isActive activeTab id) config)
                        tabs
                    )
                ]
            ]
        , ul [ class "list-unstyled" ]
            (List.map
                (\(TabItem { id, tabContent }) -> tabContentView id tabContent (isActive activeTab id))
                tabs
            )
        ]


{-| Placeholder
-}
tabNavView : String -> String -> Bool -> Config msg -> Html msg
tabNavView tabId tabName active (Config { toMsg }) =
    li [ class "tabs__navigation-list-item" ]
        [ label
            [ classList
                [ ( "tab__link", True )
                , ( "tab__link--active", active )
                ]
            , for tabId
            , onClick <|
                toMsg <|
                    State
                        { activeTab = tabId
                        }
            ]
            [ text tabName ]
        ]


{-| Placeholder
-}
tabContentView : String -> Html msg -> Bool -> Html msg
tabContentView tabId content active =
    div []
        [ input [ class "tab__radio-button", id tabId, type_ "radio", name "tabs", checked active ]
            []
        , div [ class "tab__content" ]
            [ content
            ]
        ]


{-| Placeholder
-}
getCurrentState : State -> String
getCurrentState (State { activeTab }) =
    activeTab


{-| Placeholder
-}
isActive : String -> String -> Bool
isActive activeTab tabId =
    if activeTab == tabId then
        True
    else
        False
